//
//  OSMapsAPI.h
//  Maply
//
//  Created by David on 12/01/2016.
//  Copyright © 2016 Ordnance Survey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OSMapsAPI : NSObject

+ (NSString *)URLForSRS:(NSString *)srs layer:(NSString *)layer service:(NSString *)service;

@end
