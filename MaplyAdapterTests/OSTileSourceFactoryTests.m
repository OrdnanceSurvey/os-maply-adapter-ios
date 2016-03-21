//
//  OSTileSourceFactoryTests.m
//  MaplyAdapter
//
//  Created by David Haynes on 19/03/2016.
//  Copyright © 2016 Ordnance Survey. All rights reserved.
//

#import <XCTest/XCTest.h>
@import MaplyAdapter;
@import Expecta;
#import "MaplyComponent.h"

@interface OSTileSourceFactoryTests : XCTestCase

@end

@implementation OSTileSourceFactoryTests

- (void)test27700TilesourceCreation {
    MaplyQuadImageTilesLayer *testLayer = [OSTileSourceFactory create27700TileLayer];
    expect(testLayer).toNot.beNil();
    expect(testLayer.coverPoles).to.beFalsy();
    expect(testLayer.drawPriority).to.equal(kMaplyImageLayerDrawPriorityDefault);
    expect(testLayer.tileSource).toNot.beNil();
}

- (void)test3857TilesourceCreation {
    MaplyQuadImageTilesLayer *testLayer = [OSTileSourceFactory create3857TileLayer];
    expect(testLayer).toNot.beNil();
    expect(testLayer.coverPoles).to.beFalsy();
    expect(testLayer.drawPriority).to.equal(kMaplyImageLayerDrawPriorityDefault);
    expect(testLayer.tileSource).toNot.beNil();
}


@end
