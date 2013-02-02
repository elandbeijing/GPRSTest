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

@property (weak, nonatomic) IBOutlet UILabel *lblLon;
@property (weak, nonatomic) IBOutlet UILabel *lblLat;

@property (nonatomic, retain) MKMapView* mapView;
@property (nonatomic, retain) NSMutableArray* points;
@property (nonatomic, retain) MKPolyline* routeLine;
@property (nonatomic, retain) MKPolylineView* routeLineView;
@property (nonatomic, retain) CLLocationManager* locationManager;

-(void) configureRoutes;


@end
