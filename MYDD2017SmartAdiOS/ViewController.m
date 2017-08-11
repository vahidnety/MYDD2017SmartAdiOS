//
//  ViewController.m
//  MYDD2017SmartAdiOS
//
//  Created by Seyedvahid Dianat on 11/08/2017.
//  Copyright © 2017 Seyedvahid Dianat. All rights reserved.
//

#import "ViewController.h"
#import <GoogleMaps/GoogleMaps.h>

@implementation ViewController

// You don't need to modify the default initWithNibName:bundle: method.
- (void)viewDidLoad {
    [super viewDidLoad];
    _locationManager = [[CLLocationManager alloc] init];
    [_locationManager setDelegate:self];
    [_locationManager setDistanceFilter:kCLDistanceFilterNone];
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
//    if (IS_OS_8_OR_LATER) {
        if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [_locationManager requestWhenInUseAuthorization];
        }
//    }
    [_locationManager startUpdatingLocation];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86
                                                            longitude:151.20
                                                                 zoom:6];
    GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.myLocationEnabled = YES;
    self.view = mapView;
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
    //marker.title = @"Sydney";
    //marker.snippet = @"Australia";
    marker.map = mapView;

}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    NSLog(@"%@",locations);
    CLLocation *currentLoc=[locations objectAtIndex:0];
    NSLog(@"CurrentLoc : %@",currentLoc);
    _coordinate=currentLoc.coordinate;
    currentLatitude = currentLoc.coordinate.latitude;
    currentLongitude = currentLoc.coordinate.longitude;
}


-(void)plotMarkerForLatitude:(float)latitude andLongitude:(float)longitude {
    
    // Now create maker on current location
    if (marker_ == NULL) {
        marker_ = [[GMSMarker alloc] init];
    }
    CLLocationCoordinate2D target =
    CLLocationCoordinate2DMake(latitude, longitude);
    
    marker_.position = target;
    marker_.title = @"title";
    
    marker_.appearAnimation = kGMSMarkerAnimationPop;
    NSLog(@"%f %f",latitude,longitude);
    marker_.icon = [UIImage imageNamed:@"marker"];
    marker_.snippet = @"Address";
    marker_.map = mapView_;

    
}

//- (void)loadView {
//    // Create a GMSCameraPosition that tells the map to display the
//    // coordinate -33.86,151.20 at zoom level 6.
//    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86
//                                                            longitude:151.20
//                                                                 zoom:6];
//    GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
//    mapView.myLocationEnabled = YES;
//    self.view = mapView;
//    
//    // Creates a marker in the center of the map.
//    GMSMarker *marker = [[GMSMarker alloc] init];
//    marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
//    marker.title = @"Sydney";
//    marker.snippet = @"Australia";
//    marker.map = mapView;
//}

@end
