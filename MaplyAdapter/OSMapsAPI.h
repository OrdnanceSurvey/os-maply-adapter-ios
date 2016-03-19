//
//  OSMapsAPI.h
//  MaplyAdapter
//
//  Created by David Haynes on 12/01/2016.
//  Copyright © 2016 Ordnance Survey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OSMapsAPI : NSObject

/**
 *  Build a URL for accessing the OS Maps API
 *
 *  @param srs     The spatial reference
 *  @param layer   <#layer description#>
 *  @param service <#service description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)URLForSRS:(NSString *)srs layer:(NSString *)layer service:(NSString *)service;

@end
