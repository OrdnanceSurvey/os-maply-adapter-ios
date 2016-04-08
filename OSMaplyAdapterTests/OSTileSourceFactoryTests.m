//
//  OSTileSourceFactoryTests.m
//  MaplyAdapter
//
//  Created by David Haynes on 19/03/2016.
//  Copyright © 2016 Ordnance Survey. All rights reserved.
//

#import <XCTest/XCTest.h>
@import OSMaplyAdapter;
@import WhirlyGlobeMaply;
@import Expecta;

@interface OSMaplyTilesLayerTests : XCTestCase

@end

@implementation OSMaplyTilesLayerTests

- (void)test27700TilesourceCreation {
    MaplyQuadImageTilesLayer *testLayer = [[OSMaplyTilesLayer alloc] initWithBasemapStyle:OSBaseMapStyleRoad spatialReference:OSSpatialReferenceBNG apiKey:@"test"];
    expect(testLayer).toNot.beNil();
    expect(testLayer.coverPoles).to.beFalsy();
    expect(testLayer.drawPriority).to.equal(kMaplyImageLayerDrawPriorityDefault);
    expect(testLayer.tileSource).toNot.beNil();
}

- (void)test3857TilesourceCreation {
    MaplyQuadImageTilesLayer *testLayer = [[OSMaplyTilesLayer alloc] initWithBasemapStyle:OSBaseMapStyleRoad spatialReference:OSSpatialReferenceWebMercator apiKey:@"test"];
    expect(testLayer).toNot.beNil();
    expect(testLayer.coverPoles).to.beFalsy();
    expect(testLayer.drawPriority).to.equal(kMaplyImageLayerDrawPriorityDefault);
    expect(testLayer.tileSource).toNot.beNil();
}

@end
