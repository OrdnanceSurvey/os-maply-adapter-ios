//
//  MaplyAdapter.h
//  MaplyAdapter
//
//  Created by David Haynes on 18/03/2016.
//  Copyright © 2016 Ordnance Survey. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for MaplyAdapter.
FOUNDATION_EXPORT double MaplyAdapterVersionNumber;

//! Project version string for MaplyAdapter.
FOUNDATION_EXPORT const unsigned char MaplyAdapterVersionString[];

#import "OSBNGUtils.h"
#import "OSMapsAPI.h"
#import "OSTileSourceFactory.h"

#import "MaplyCoordinate.h"
#import "MaplyCoordinateSystem.h"
#import "MaplyMatrix.h"
#import "MaplyVertexAttribute.h"
#import "MaplyTexture.h"
#import "MaplyLabel.h"
#import "MaplyScreenLabel.h"
#import "MaplyMarker.h"
#import "MaplyScreenMarker.h"
#import "MaplyShape.h"
#import "MaplySticker.h"
#import "MaplyBillboard.h"
#import "MaplyParticleSystem.h"
#import "MaplyVectorObject.h"
#import "MaplyViewTracker.h"
#import "MaplyViewController.h"
#import "MaplyQuadPagingLayer.h"
#import "MaplyUpdateLayer.h"
#import "MaplyQuadImageTilesLayer.h"
#import "MaplyQuadImageOfflineLayer.h"
#import "MaplyBlankTileSource.h"
#import "MaplyTileSource.h"
#import "MaplyWMSTileSource.h"
#import "MaplyMBTileSource.h"
#import "MaplyGDALRetileSource.h"
#import "MaplyRemoteTileSource.h"
#import "MaplyMultiplexTileSource.h"
#import "MaplyAnimationTestTileSource.h"
#import "MaplyPagingVectorTestTileSource.h"
#import "MaplyElevationSource.h"
#import "MaplyElevationDatabase.h"
#import "MaplyIconManager.h"
#import "MaplyTextureBuilder.h"
#import "MaplyGeomModel.h"
#import "MaplyVertexAttribute.h"
#import "MaplyQuadTracker.h"
#import "MaplyStarsModel.h"
#import "MaplySun.h"
#import "MaplyAtmosphere.h"
#import "MaplyMoon.h"
#import "MaplyRemoteTileElevationSource.h"
#import "MaplyPoints.h"
#import "MaplyGeomBuilder.h"
