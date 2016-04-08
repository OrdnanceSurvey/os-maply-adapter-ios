//
//  OSMaplyTilesLayer.h
//  OSMaplyAdapter
//
//  Created by Dave Hardiman on 08/04/2016.
//  Copyright © 2016 Ordnance Survey. All rights reserved.
//

@import WhirlyGlobeMaply;
@import OSMapProducts;

/**
 *  Tile layer subclass to be used with OS Maps API
 */
@interface OSMaplyTilesLayer : MaplyQuadImageTilesLayer

/**
 *  Initialise a layer with the given style and spatial reference.
 *
 *  @param style            The layer style.
 *  @param spatialReference Spatial reference for the layer.
 *  @param apiKey           The OS Maps API key to use for this layer.
 *
 *  @return An instance of OSWMTSBaseLayer configured with the provided style
 *          and spatial reference.
 */
- (instancetype)initWithBasemapStyle:(OSBaseMapStyle)style
                    spatialReference:(OSSpatialReference)spatialReference
                              apiKey:(NSString *)apiKey;

@end
