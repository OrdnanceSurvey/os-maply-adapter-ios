//
//  OSBNGCoordinateSystem.h
//  OSMaplyAdapter
//
//  Created by David Haynes on 12/01/2016.
//  Copyright © 2016 Ordnance Survey. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MaplyCoordinateSystem;

/**
 *  Utility methods for working with British National Grid and WhirlyGlobe-Maply
 */
@interface OSBNGCoordinateSystem : NSObject

/**
 *  Build a standard BNG coordinate system.
 *
 *  @return The BNG coordinate system.
 */
+ (MaplyCoordinateSystem *)britishNationalGrid;

/**
 *  Builds a BNG coordinate system for use with a WG-Maply tilesource.
 *
 *  This, simplistically, expands the bounding box of the National Grid to the 
 *  nearest equivalent power-of-two zoom level. See implementation for details.
 *
 *  @return The BNG coordinate system initalised as required.
 */
+ (MaplyCoordinateSystem *)britishNationalGridForTileSource;

@end
