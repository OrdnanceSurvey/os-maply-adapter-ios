//
//  ViewController.swift
//  MaplyExampleSwift
//
//  Created by Dave Hardiman on 08/04/2016.
//  Copyright © 2016 Ordnance Survey. All rights reserved.
//

import UIKit
import OSMaplyAdapter

class ViewController: UIViewController {

    lazy var maplyViewController: MaplyViewController = {
        let maplyViewController = MaplyViewController(mapType: .TypeFlat)
        maplyViewController.viewWrap = false
        maplyViewController.doubleTapZoomGesture = true
        maplyViewController.twoFingerTapGesture = true
        maplyViewController.cancelAnimationOnTouch = true
        maplyViewController.coordSys = OSBNGCoordinateSystem.britishNationalGrid()
        return maplyViewController
    }()

    var apiKey: String {
        return NSBundle.mainBundle().URLForResource("APIKEY", withExtension: nil).flatMap { url -> String? in
            do { return try String(contentsOfURL: url).stringByTrimmingCharactersInSet(.whitespaceAndNewlineCharacterSet()) } catch { return nil }
            } ?? ""
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create map and tile layer
        addMapToViewHierarchy()
        let tileLayer = OSMaplyTilesLayer(basemapStyle: .Leisure, spatialReference: .BNG, apiKey: apiKey)
        maplyViewController.addLayer(tileLayer)

        // Create test marker
        let londonCoordinate = MaplyCoordinateMakeWithDegrees(-0.1275, 51.507222)
        let marker = MaplyScreenMarker()
        marker.image = UIImage(named: "map_pin")
        marker.loc = londonCoordinate
        marker.size = CGSizeMake(40, 40)
        marker.selectable = true
        marker.userObject = "London"
        maplyViewController.addScreenMarkers([ marker ], desc: nil)

        // Set initial map position to the centre of GB
        let centreOfGB = MaplyCoordinateMake(-0.049939, 0.964304)
        if let centreOfGBLocal = maplyViewController.coordSys?.geoToLocal(centreOfGB) {
            maplyViewController.setPosition(centreOfGBLocal, height: 1.839962)
        }
    }

    func addMapToViewHierarchy() {
        addChildViewController(maplyViewController)
        view.addSubview(maplyViewController.view)
        view.sendSubviewToBack(maplyViewController.view)
        maplyViewController.didMoveToParentViewController(self)
    }
}

