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
    oldLat=0;
    oldLong=0;

}

-(void)locMap{
    camera = [GMSCameraPosition cameraWithLatitude:currentLatitude
                                         longitude:currentLongitude
                                              zoom:17];
    
    mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.myLocationEnabled = YES;
    self.view = mapView;
    
    // Creates a marker in the center of the map.
    marker_ = [[GMSMarker alloc] init];
    marker_.position = CLLocationCoordinate2DMake(currentLatitude, currentLongitude);
    //marker.title = @"Sydney";
    //marker.snippet = @"Australia";
    marker_.map = mapView;
    NSString *post = [NSString stringWithFormat:@"http://192.168.2.9:8080/geo?id=%@&lat=%f&lng=%f",@"1",currentLatitude,currentLongitude];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:post]];

    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(conn) {
        NSLog(@"Connection Successful");
    } else {
        NSLog(@"Connection could not be made");
    }
    
}

// This method is used to receive the data which we get using post method.
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData*)data{
    [receivedData appendData:data];
}

// This method receives the error report in case of connection is not made to server.
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    NSLog(@"error.description=%@",error.description);
}

// This method is used to process the data after connection has made successfully.
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"receivedData=%@",receivedData);
    receivedData=nil;
    connection=nil;
    
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    //?NSLog(@"%@",locations);
    CLLocation *currentLoc=[locations objectAtIndex:0];
    _coordinate=currentLoc.coordinate;
    
    currentLatitude = currentLoc.coordinate.latitude;
    currentLongitude = currentLoc.coordinate.longitude;
    
    if((currentLatitude!=oldLat && currentLongitude!=oldLong )|| (oldLat==0 && oldLong==0)){
        NSLog(@"CurrentLoc : %@",currentLoc);
        oldLat=currentLatitude;
        oldLong=currentLongitude;

        [self performSelector:@selector(locMap) withObject:self afterDelay:2.0];
    }

}


//-(void)plotMarkerForLatitude:(float)latitude andLongitude:(float)longitude {
//    
//    // Now create maker on current location
//    if (marker_ == NULL) {
//        marker_ = [[GMSMarker alloc] init];
//    }
//    CLLocationCoordinate2D target =
//    CLLocationCoordinate2DMake(latitude, longitude);
//    
//    marker_.position = target;
//    marker_.title = @"title";
//    
//    marker_.appearAnimation = kGMSMarkerAnimationPop;
//    NSLog(@"%f %f",latitude,longitude);
//    marker_.icon = [UIImage imageNamed:@"marker"];
//    marker_.snippet = @"Address";
//    marker_.map = mapView;
//    
//    
//
//
//    
//}

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
