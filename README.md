# OS WhirlyGlobe-Maply Adapter Framework

Framework for integration of WhirlyGlobe-Maply map SDK using Ordnance Survey mapping API.

Build: [![Circle CI](https://circleci.com/gh/OrdnanceSurvey/os-maply-adapter-ios.svg?style=svg)](https://circleci.com/gh/OrdnanceSurvey/os-maply-adapter-ios) [![Coverage Status](https://coveralls.io/repos/github/OrdnanceSurvey/os-maply-adapter-ios/badge.svg?branch=master)](https://coveralls.io/github/OrdnanceSurvey/os-maply-adapter-ios?branch=master)

### Getting started

The officially supported way to use the OSMaplyAdapter framework, is with [Carthage](https://github.com/Carthage/Carthage) but you can also build the framework manually.

##### Carthage:

1. Add `github "OrdnanceSurvey/os-maply-adapter-ios"` to your Cartfile.
2. Run `carthage update --platform iOS --no-use-binaries`
3. Drag the built frameworks from the `Carthage/Build` folder into the "Embedded Binaries" section in the "General" settings tab of your application target. Note, this framework has a dependency on 3 other frameworks, OSMapProducts, OSTransformation and WhirlyGlobeMaply. All 4 frameworks must be added.
4. In the "Build Phases" of your application target's settings, click the '+' and select "New Run Script Phase". Add the following to the script:

    `/usr/local/bin/carthage copy-frameworks`

    and add the path to the OS framework in the "Input Files" section:

    `$(SRCROOT)/Carthage/Build/iOS/OSMaplyAdapter.framework`
    `$(SRCROOT)/Carthage/Build/iOS/OSMapProducts.framework`
    `$(SRCROOT)/Carthage/Build/iOS/OSTransformation.framework`
    `$(SRCROOT)/Carthage/Build/iOS/WhirlyGlobeMaply.framework`

### Creating a map:

1. `@import OSMaplyAdapter;` in your view controller
2. Create a mapView property:
```
@property (nonatomic, strong) MaplyViewController *maplyViewController;
```

3. Make your view controller conform to `<MaplyViewControllerDelegate>`

4. The map is created and added to the view hierarchy like this (example is for a BNG map):
  ```
  - (MaplyViewController *)createMaplyViewController {
    MaplyViewController *maplyViewController = [[MaplyViewController alloc] initWithMapType:MaplyMapTypeFlat];
    maplyViewController.coordSys = [OSBNGCoordinateSystem britishNationalGrid];
    maplyViewController.viewWrap = false;
    maplyViewController.doubleTapZoomGesture = true;
    maplyViewController.twoFingerTapGesture = true;
    maplyViewController.cancelAnimationOnTouch = true;
    maplyViewController.delegate = self;
    return maplyViewController;
  }

  - (void)addMapToViewHierarchy {
    [self addChildViewController:self.maplyViewController];
    [self.view addSubview:self.maplyViewController.view];
    [self.view sendSubviewToBack:self.maplyViewController.view];
    [self.maplyViewController didMoveToParentViewController:self];
  }
  ```
5. Create the tile layer at the end of `viewDidLoad:` like so:
```
MaplyQuadImageTilesLayer *tileLayer = [[OSMaplyTilesLayer alloc] initWithBasemapStyle:OSBaseMapStyleRoad spatialReference:OSSpatialReferenceBNG apiKey:self.apiKey];
[self.maplyViewController addLayer:tileLayer];
```
6. It's probably useful to set the initial map position to the centre of the country, do that like this:

    ```
    MaplyCoordinate centreOfGB = MaplyCoordinateMakeWithDegrees(-2.42, 54.83);
    MaplyCoordinate centreOfGBLocal = [self.maplyViewController.coordSys geoToLocal:centreOfGB];
    [self.maplyViewController setPosition:centreOfGBLocal height:1.7];
    ```
7. Run your app. If everything is configured correctly, you will see something similar to the below screenshot:

![Map Screenshot](images/map.png)

### License
This framework is released under the [Apache 2.0 License](LICENSE)
WhirlyGlobe-Maply is also released under the [Apache 2.0 License](https://github.com/mousebird/WhirlyGlobe/blob/master/LICENSE)
