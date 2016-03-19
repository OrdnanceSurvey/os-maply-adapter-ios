//
//  OSRemoteTileInfoTests.m
//  MaplyAdapter
//
//  Created by David Haynes on 19/03/2016.
//  Copyright © 2016 Ordnance Survey. All rights reserved.
//

#import <XCTest/XCTest.h>
@import MaplyAdapter;
@import Expecta;
#import "MaplyComponent.h"

@interface OSRemoteTileInfoTests : XCTestCase

@end

@implementation OSRemoteTileInfoTests

- (void)testTheTileInfoSubclassTranslatesRequestsCorrectly {
    MaplyQuadImageTilesLayer *testLayer = [OSTileSourceFactory create27700TileLayer];
    expect(testLayer).toNot.beNil();
    MaplyRemoteTileSource *testTileSource = [testLayer valueForKey:@"_tileSource"];
    expect(testTileSource).toNot.beNil();
    MaplyRemoteTileInfo *testInfo = [testTileSource valueForKey:@"_tileInfo"];
    expect(testInfo).toNot.beNil();
    MaplyTileID testTileID = { 50, 50, 10 };
    NSURLRequest *testRequest = [testInfo requestForTile:testTileID];
    expect(testRequest).toNot.beNil();
    expect(testRequest.URL.query).to.equal(@"key=(null)&height=256&width=256&tilematrixSet=EPSG:27700&version=1.0.0&style=&layer=Road%2027700&SERVICE=WMTS&REQUEST=GetTile&format=image/png&TileMatrix=EPSG:27700:7&TileRow=973&TileCol=50");
}

@end
