//
//  OSTileSourceFactory.h
//  Maply
//
//  Created by David on 13/01/2016.
//  Copyright © 2016 Ordnance Survey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OSTileSourceFactory : NSObject

+ (MaplyQuadImageTilesLayer *)create27700TileLayer;
+ (MaplyQuadImageTilesLayer *)create3857TileLayer;

@end
