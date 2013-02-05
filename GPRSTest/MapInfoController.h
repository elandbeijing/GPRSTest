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
#import "MyAnnotation.h"


@interface MapInfoController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate>
{
	// the rect that bounds the loaded points
	MKMapRect _routeRect;
    
    // current location
    CLLocation* _currentLocation;
    MyAnnotation *_pinAnnotation ;
}

@property (strong, nonatomic) IBOutlet UILabel *timeSection;

@property (strong, nonatomic) IBOutlet UILabel *distance;
@property (strong, nonatomic) IBOutlet UIButton *leftbtn;
@property (strong, nonatomic) IBOutlet UIButton *rightbtn;

- (IBAction)StartOrPause:(id)sender;
- (IBAction)stopOrExit:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *ShowView;

@property (nonatomic, strong) MKMapView* mapView;
@property (nonatomic, strong) NSMutableArray* points;
@property (nonatomic, strong) MKPolyline* routeLine;
@property (nonatomic, strong) MKPolylineView* routeLineView;
@property (nonatomic, strong) CLLocationManager* locationManager;

-(void) configureRoutes;


@end
