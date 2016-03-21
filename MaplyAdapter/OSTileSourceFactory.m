//
//  OSTileSourceFactory.m
//  MaplyAdapter
//
//  Created by David Haynes on 13/01/2016.
//  Copyright © 2016 Ordnance Survey. All rights reserved.
//

#import "OSTileSourceFactory.h"
#import "MaplyComponent.h"
#import "OSBNGUtils.h"
#import "OSMapsAPI.h"
#import "OSRemoteTileInfo.h"

@implementation OSTileSourceFactory

+ (MaplyQuadImageTilesLayer *)create27700TileLayer {
    NSString *mapName = @"Road 27700";
    NSString *baseURLPath = [OSMapsAPI URLForSRS:@"EPSG:27700" layer:mapName service:@"wmts"];

    MaplyRemoteTileInfo *tileInfo = [[OSRemoteTileInfo alloc] initWithBaseURL:baseURLPath ext:nil minZoom:3 maxZoom:16];
    MaplyCoordinateSystem *bng = [OSBNGUtils bngForTileSource];
    tileInfo.coordSys = bng;

    MaplyRemoteTileSource *tileSource = [[MaplyRemoteTileSource alloc] initWithInfo:tileInfo];
    tileSource.cacheDir = [self pathForTileSourceCacheNamed:mapName];
    return [self createOSMapLayerWithTileSource:tileSource];
}

+ (MaplyQuadImageTilesLayer *)create3857TileLayer {
    NSString *mapName = @"Road 3857";
    MaplyRemoteTileSource *tileSource = [[MaplyRemoteTileSource alloc] initWithBaseURL:[OSMapsAPI URLForSRS:@"EPSG:3857" layer:mapName service:@"wmts"] ext:nil minZoom:7 maxZoom:24];
    tileSource.cacheDir = [self pathForTileSourceCacheNamed:mapName];
    return [self createOSMapLayerWithTileSource:tileSource];
}

+ (MaplyQuadImageTilesLayer *)createOSMapLayerWithTileSource:(MaplyRemoteTileSource *)tileSource {
    MaplyQuadImageTilesLayer *layer = [[MaplyQuadImageTilesLayer alloc] initWithCoordSystem:tileSource.coordSys tileSource:tileSource];
    layer.handleEdges = false;
    layer.coverPoles = false;
    layer.drawPriority = kMaplyImageLayerDrawPriorityDefault;
    layer.numSimultaneousFetches = 8;
    // Normally we'd try to match the screen resolution with tiles, but that seems
    // to overfetch OS Maps, so we'll back off a bit.  Smaller number for even more backing off
    layer.importanceScale = 0.5;
    layer.singleLevelLoading = true;
    layer.multiLevelLoads = @[ @-3 ];
    return layer;
}

+ (NSString *)pathForTileSourceCacheNamed:(NSString *)cacheName {
    NSString *baseCacheDirectory = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSURL *baseCacheURL = [NSURL URLWithString:baseCacheDirectory];
    NSURL *tileCacheURL = [baseCacheURL URLByAppendingPathComponent:cacheName];
    return tileCacheURL.path;
}

@end
