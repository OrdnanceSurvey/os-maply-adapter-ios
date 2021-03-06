//
//  OSBNGUtils.m
//  MaplyAdapter
//
//  Created by David Haynes on 12/01/2016.
//  Copyright © 2016 Ordnance Survey. All rights reserved.
//

#import "OSBNGCoordinateSystem.h"
@import OSTransformation;
@import WhirlyGlobeMaply;

@implementation OSBNGCoordinateSystem

+ (MaplyProj4CoordSystem *)bngCoordinateSystem {
    NSString *proj4Str = [OSBNGTransformation proj4String];
    MaplyProj4CoordSystem *coordSys = [[MaplyProj4CoordSystem alloc] initWithString:proj4Str];
    return coordSys;
}

/* Build two different versions of BNG.  One can go out larger than the other.
 If display is set, we'll allow a bigger bounding box.
 */
+ (MaplyCoordinateSystem *)britishNationalGrid {
    MaplyCoordinateSystem *coordSys = [self bngCoordinateSystem];
    // Set the bounding box for validity.  It assumes it can go everywhere by default.
    MaplyBoundingBox bbox;
    bbox.ll.x = 1393.0196;
    bbox.ll.y = 13494.9764;
    bbox.ur.x = 671196.3657;
    bbox.ur.y = 1230275.0454;

    [coordSys setBounds:bbox];
    return coordSys;
}

+ (MaplyCoordinateSystem *)britishNationalGridForTileSource {
    MaplyProj4CoordSystem *coordSys = [self bngCoordinateSystem];

    // We need to figure out what the real world bounding box of the lowest level (and all the others)
    // would be if each tile set were a power of two.
    // Formulas courtesy: https://gist.github.com/atlefren/c41921d64a2636c9598e
    double standardizedRenderingPixelSize = 0.00028; // A constant having to do with assumed resolution
    int tileWidth = 256, tileHeight = 256; // The number of pixels in individual tiles
    int matrixHeight = 8, matrixWidth = 8; // The number of tiles at level 0 (e.g. level 3) if they were power of 2
    double scaleDenom = 3200000.0000000005; // Scale denominator from the Capabilities
    double leftRW = -238375.0, topRW = 1376256.0; // Upper left corner from the Capabilities
    double rightRW = scaleDenom * (tileWidth * matrixWidth) * standardizedRenderingPixelSize + leftRW;
    double bottomRW = topRW - scaleDenom * (tileHeight * matrixHeight) * standardizedRenderingPixelSize;

    // Set the bounding box for validity.  It assumes it can go everywhere by default
    MaplyBoundingBox bbox;
    bbox.ll.x = leftRW;
    bbox.ll.y = bottomRW;
    bbox.ur.x = rightRW;
    bbox.ur.y = topRW;

    // Top left corner from wmts is -238375.0 1376256.0
    [coordSys setBounds:bbox];
    return coordSys;
}

@end
