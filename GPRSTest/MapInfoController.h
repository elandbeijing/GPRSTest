//
//  MapInfoController.h
//  GPRSTest
//
//  Created by ElandApple02 on 13. 1. 31..
//  Copyright (c) 2013년 ElandApple02. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>


@interface MapInfoController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate>
{
	// the rect that bounds the loaded points
	MKMapRect _routeRect;
    
    // current location
    CLLocation* _currentLocation;
}

@property (weak, nonatomic) IBOutlet UILabel *timeSection;

@property (weak, nonatomic) IBOutlet UILabel *distance;

@property (weak, nonatomic) IBOutlet UILabel *lblSpeed;


@property (weak, nonatomic) IBOutlet UIButton *leftbtn;

@property (weak, nonatomic) IBOutlet UIButton *rightbtn;

- (IBAction)StartOrPause:(id)sender;
- (IBAction)stopOrExit:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *ShowView;

@property (nonatomic, strong) MKMapView* mapView;
@property (nonatomic, strong) NSMutableArray* points;
@property (nonatomic, strong) MKPolyline* routeLine;
@property (nonatomic, strong) MKPolylineView* routeLineView;
@property (nonatomic, strong) CLLocationManager* locationManager;

-(void) configureRoutes;


@end
