//
//  OSRemoteTileInfoTests.m
//  MaplyAdapter
//
//  Created by David Haynes on 19/03/2016.
//  Copyright © 2016 Ordnance Survey. All rights reserved.
//

#import <XCTest/XCTest.h>
@import Expecta;
@import OSMaplyAdapter;
@import WhirlyGlobeMaply;

@interface OSRemoteTileInfoTests : XCTestCase

@end

@implementation OSRemoteTileInfoTests

- (void)testTheTileInfoSubclassTranslatesRequestsCorrectly {
    MaplyQuadImageTilesLayer *testLayer = [[OSMaplyTilesLayer alloc] initWithBasemapStyle:OSBaseMapStyleRoad spatialReference:OSSpatialReferenceBNG apiKey:@"test"];
    expect(testLayer).toNot.beNil();

    // Value for key is used here as OSTileInfo is not a public class in the adapter
    // framework, and cannot be made so, due to it being a subclass of a Maply class,
    // thus requiring inclusion of a non-module header (MaplyRemoteTileInfo) in its
    // own header.
    MaplyRemoteTileSource *testTileSource = [testLayer valueForKey:@"_tileSource"];
    expect(testTileSource).toNot.beNil();
    MaplyRemoteTileInfo *testInfo = [testTileSource valueForKey:@"_tileInfo"];
    expect(testInfo).toNot.beNil();
    MaplyTileID testTileID = {50, 50, 10};
    NSURLRequest *testRequest = [testInfo requestForTile:testTileID];
    expect(testRequest).toNot.beNil();
    expect(testRequest.URL.query).to.equal(@"key=test&height=256&width=256&tilematrixSet=EPSG:27700&version=1.0.0&style=&layer=Road%2027700&SERVICE=WMTS&REQUEST=GetTile&format=image/png&TileMatrix=EPSG:27700:7&TileRow=973&TileCol=50");
}

@end
