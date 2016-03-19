//
//  OSBNGUtilsTests.m
//  MaplyAdapter
//
//  Created by David Haynes on 19/03/2016.
//  Copyright © 2016 Ordnance Survey. All rights reserved.
//

#import <XCTest/XCTest.h>
@import MaplyAdapter;
@import Expecta;

@interface OSBNGUtilsTests : XCTestCase

@end

@implementation OSBNGUtilsTests

- (void)test {
    MaplyCoordinateSystem *coordinateSystem = [OSBNGUtils buildBritishNationalGrid];
    expect(coordinateSystem).toNot.beNil();
}

@end
