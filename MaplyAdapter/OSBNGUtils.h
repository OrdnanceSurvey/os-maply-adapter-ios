//
//  OSBNGUtils.h
//  Maply
//
//  Created by David on 12/01/2016.
//  Copyright © 2016 Ordnance Survey. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MaplyCoordinateSystem;

@interface OSBNGUtils : NSObject

+ (MaplyCoordinateSystem *)buildBritishNationalGrid;
+ (MaplyCoordinateSystem *)bngForTileSource;

@end
