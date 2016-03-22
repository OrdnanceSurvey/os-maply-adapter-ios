//
//  ViewController.m
//  MaplyExampleObjC
//
//  Created by David Haynes on 19/03/2016.
//  Copyright © 2016 Ordnance Survey. All rights reserved.
//

#import "ViewController.h"
@import MaplyAdapter;
#import "MaplyComponent.h"

@interface ViewController ()<MaplyViewControllerDelegate>

@property (nonatomic, strong) MaplyViewController *maplyViewController;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Create map and tile layer
    self.maplyViewController = [self createMaplyViewController];
    [self addMapToViewHierarchy];
    MaplyQuadImageTilesLayer *tileLayer = [OSTileSourceFactory create27700TileLayer];
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
    maplyViewController.coordSys = [OSBNGUtils buildBritishNationalGrid];
    maplyViewController.delegate = self;
    return maplyViewController;
}

- (void)addMapToViewHierarchy {
    [self.view addSubview:self.maplyViewController.view];
    [self.view sendSubviewToBack:self.maplyViewController.view];
    [self addChildViewController:self.maplyViewController];
}

- (void)maplyViewController:(MaplyViewController *)viewC didTapAt:(MaplyCoordinate)coord {
    MaplyCoordinate centre;
    float height;
    [self.maplyViewController getPosition:&centre height:&height];
    NSLog(@"%f, %f height: %f", centre.x, centre.y, height);
}

@end
