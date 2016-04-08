//
//  OSBNGUtilsTests.m
//  MaplyAdapter
//
//  Created by David Haynes on 19/03/2016.
//  Copyright © 2016 Ordnance Survey. All rights reserved.
//

#import <XCTest/XCTest.h>
@import Expecta;
@import OSMaplyAdapter;
@import WhirlyGlobeMaply;

@interface OSBNGUtilsTests : XCTestCase

@end

@implementation OSBNGUtilsTests

- (void)testStandardBNGCoordinateSystemCreation {
    MaplyCoordinateSystem *coordinateSystem = [OSBNGUtils buildBritishNationalGrid];
    expect(coordinateSystem).toNot.beNil();
    MaplyBoundingBox bounds = [coordinateSystem getBounds];
    expect(bounds.ll.x).to.beCloseToWithin(1393.019653320312, FLT_EPSILON);
    expect(bounds.ll.y).to.beCloseToWithin(13494.9765625, FLT_EPSILON);
    expect(bounds.ur.x).to.beCloseToWithin(671196.375, FLT_EPSILON);
    expect(bounds.ur.y).to.beCloseToWithin(1230275.0, FLT_EPSILON);
}

- (void)testTilesourceBNGCoordinateSystemCreation {
    MaplyCoordinateSystem *coordinateSystem = [OSBNGUtils bngForTileSource];
    expect(coordinateSystem).toNot.beNil();
    MaplyBoundingBox bounds = [coordinateSystem getBounds];
    expect(bounds.ll.x).to.beCloseToWithin(-238375.0, FLT_EPSILON);
    expect(bounds.ll.y).to.beCloseToWithin(-458752.0, FLT_EPSILON);
    expect(bounds.ur.x).to.beCloseToWithin(1596633.0, FLT_EPSILON);
    expect(bounds.ur.y).to.beCloseToWithin(1376256.0, FLT_EPSILON);
}

@end
