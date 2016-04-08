//
//  ViewController.m
//  MaplyExampleObjC
//
//  Created by David Haynes on 19/03/2016.
//  Copyright © 2016 Ordnance Survey. All rights reserved.
//

#import "ViewController.h"
@import WhirlyGlobeMaply;
@import OSMaplyAdapter;

@interface ViewController ()<MaplyViewControllerDelegate>

@property (nonatomic, strong) MaplyViewController *maplyViewController;

@end

@implementation ViewController

- (NSString *)apiKey {
    NSError *error;
    NSString *apiKey = [NSString stringWithContentsOfURL:[NSBundle.mainBundle URLForResource:@"APIKEY"
                                                                               withExtension:nil]
                                                encoding:NSUTF8StringEncoding
                                                   error:&error];
    if (!apiKey || error) {
        NSException *exception = [[NSException alloc] initWithName:@"OSAPIKeyMissing" reason:@"Error loading api key. Make sure this is in an APIKEY file in the project bundle." userInfo:nil];
        [exception raise];
    }
    return [apiKey stringByReplacingOccurrencesOfString:@"\n" withString:@""];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Create map and tile layer
    self.maplyViewController = [self createMaplyViewController];
    [self addMapToViewHierarchy];
    MaplyQuadImageTilesLayer *tileLayer = [[OSMaplyTilesLayer alloc] initWithBasemapStyle:OSBaseMapStyleRoad spatialReference:OSSpatialReferenceBNG apiKey:self.apiKey];
    [self.maplyViewController addLayer:tileLayer];

    // Create test marker
    MaplyCoordinate londonCoordinate = MaplyCoordinateMakeWithDegrees(-0.1275, 51.507222);
    MaplyScreenMarker *marker = [[MaplyScreenMarker alloc] init];
    marker.image = [UIImage imageNamed:@"map_pin"];
    marker.loc = londonCoordinate;
    marker.size = CGSizeMake(40, 40);
    marker.selectable = true;
    marker.userObject = @"London";
    [self.maplyViewController addScreenMarkers:@[ marker ] desc:nil mode:MaplyThreadAny];

    // Set initial map position to the centre of GB
    MaplyCoordinate centreOfGB = MaplyCoordinateMake(-0.049939, 0.964304);
    MaplyCoordinate centreOfGBLocal = [self.maplyViewController.coordSys geoToLocal:centreOfGB];
    [self.maplyViewController setPosition:centreOfGBLocal height:1.839962];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (MaplyViewController *)createMaplyViewController {
    MaplyViewController *maplyViewController = [[MaplyViewController alloc] initWithMapType:MaplyMapTypeFlat];
    maplyViewController.viewWrap = false;
    maplyViewController.doubleTapZoomGesture = true;
    maplyViewController.twoFingerTapGesture = true;
    maplyViewController.cancelAnimationOnTouch = true;
    maplyViewController.coordSys = [OSBNGCoordinateSystem britishNationalGrid];
    maplyViewController.delegate = self;
    return maplyViewController;
}

- (void)addMapToViewHierarchy {
    [self addChildViewController:self.maplyViewController];
    [self.view addSubview:self.maplyViewController.view];
    [self.view sendSubviewToBack:self.maplyViewController.view];
    [self.maplyViewController didMoveToParentViewController:self];
}

@end
