//
//  ViewController.h
//  MYDD2017SmartAdiOS
//
//  Created by Seyedvahid Dianat on 11/08/2017.
//  Copyright © 2017 Seyedvahid Dianat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@import GooglePlaces;


@interface ViewController : UIViewController <CLLocationManagerDelegate> {
    
    GMSMapView *mapView_;
    GMSMarker *marker_;
    
    float currentLatitude;
    float currentLongitude;
    
}

@property(nonatomic,retain) CLLocationManager *locationManager;
@property (nonatomic)CLLocationCoordinate2D coordinate;

@end;
