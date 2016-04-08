//
//  OSMaplyTilesLayer.m
//  OSMaplyAdapter
//
//  Created by Dave Hardiman on 08/04/2016.
//  Copyright © 2016 Ordnance Survey. All rights reserved.
//

#import "OSMaplyTilesLayer.h"
#import "OSRemoteTileInfo.h"
@import OSMapProducts;
#import "OSMapsAPI.h"
#import "OSBNGCoordinateSystem.h"

@implementation OSMaplyTilesLayer

+ (NSString *)_pathForTileSourceCacheNamed:(NSString *)cacheName {
    NSString *baseCacheDirectory = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    NSURL *baseCacheURL = [NSURL URLWithString:baseCacheDirectory];
    NSURL *tileCacheURL = [baseCacheURL URLByAppendingPathComponent:cacheName];
    return tileCacheURL.path;
}

- (instancetype)initWithBasemapStyle:(OSBaseMapStyle)style spatialReference:(OSSpatialReference)spatialReference apiKey:(NSString *)apiKey {
    NSString *srs = [NSString stringWithFormat:@"EPSG:%ld", OSWkIDFromSpatialReference(spatialReference)];
    NSString *layer = NSStringFromOSMapLayer(style, spatialReference);
    NSString *baseURLPath = [OSMapsAPI URLForSRS:srs layer:layer service:@"wmts" key:apiKey];
    MaplyRemoteTileInfo *tileInfo = [[OSRemoteTileInfo alloc] initWithBaseURL:baseURLPath ext:nil minZoom:3 maxZoom:16];
    if (spatialReference == OSSpatialReferenceBNG) {
        MaplyCoordinateSystem *bng = [OSBNGCoordinateSystem britishNationalGridForTileSource];
        tileInfo.coordSys = bng;
    }
    MaplyRemoteTileSource *tileSource = [[MaplyRemoteTileSource alloc] initWithInfo:tileInfo];
    NSString *mapName = [NSString stringWithFormat:@"%@%@", srs, layer];
    tileSource.cacheDir = [OSMaplyTilesLayer _pathForTileSourceCacheNamed:mapName];

    if ((self = [super initWithCoordSystem:tileSource.coordSys tileSource:tileSource])) {
        self.handleEdges = false;
        self.coverPoles = false;
        self.drawPriority = kMaplyImageLayerDrawPriorityDefault;
        self.numSimultaneousFetches = 8;
        // Normally we'd try to match the screen resolution with tiles, but that seems
        // to overfetch OS Maps, so we'll back off a bit.  Smaller number for even more backing off
        self.importanceScale = 0.5;
        self.singleLevelLoading = true;
        self.multiLevelLoads = @[ @-3 ];
    }
    return self;
}

@end
