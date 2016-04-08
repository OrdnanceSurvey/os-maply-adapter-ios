//
//  OSMapsAPITests.m
//  MaplyAdapter
//
//  Created by David Haynes on 19/03/2016.
//  Copyright © 2016 Ordnance Survey. All rights reserved.
//

#import <XCTest/XCTest.h>
@import OSMaplyAdapter;
@import Expecta;

@interface OSMapsAPITests : XCTestCase

@end

@implementation OSMapsAPITests

- (void)testTheURLIsConstructedCorrectly {
    NSString *templateURL = [OSMapsAPI URLForSRS:@"27700" layer:@"Night" service:@"wmts"];
    expect(templateURL).toNot.beNil();
    expect(templateURL).to.equal(@"https:/api2.ordnancesurvey.co.uk/mapping_api/v1/service/wmts?key=(null)&height=256&width=256&tilematrixSet=27700&version=1.0.0&style=&layer=Night&SERVICE=WMTS&REQUEST=GetTile&format=image/png&TileMatrix=27700:{z}&TileRow={y}&TileCol={x}");
}

@end
