//
//  MapInfoController.m
//  GPRSTest
//
//  Created by ElandApple02 on 13. 1. 31..
//  Copyright (c) 2013년 ElandApple02. All rights reserved.
//

#import "MapInfoController.h"

@interface MapInfoController ()

@end

@implementation MapInfoController

- (void)viewDidUnload {
    [self setLblLat:nil];
    [self setLblLon:nil];
    [super viewDidUnload];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"newbalance"]];
    [self.navigationController setNavigationBarHidden:YES];
    
    // setup map view
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    self.mapView.userInteractionEnabled = YES;
    self.mapView.userTrackingMode = MKUserTrackingModeFollowWithHeading;
    [self.view addSubview:self.mapView];
    
    
    // configure location manager
    // [self configureLocationManager];
    
    [self configureRoutes];
}

- (void)configureRoutes
{
    // define minimum, maximum points
	MKMapPoint northEastPoint = MKMapPointMake(0.f, 0.f);
	MKMapPoint southWestPoint = MKMapPointMake(0.f, 0.f);
	
	// create a c array of points.
	MKMapPoint* pointArray = malloc(sizeof(CLLocationCoordinate2D) * _points.count);
    
	// for(int idx = 0; idx < pointStrings.count; idx++)
    for(int idx = 0; idx < _points.count; idx++)
	{
        CLLocation *location = [_points objectAtIndex:idx];
        CLLocationDegrees latitude  = location.coordinate.latitude;
		CLLocationDegrees longitude = location.coordinate.longitude;
        
		// create our coordinate and add it to the correct spot in the array
		CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
		MKMapPoint point = MKMapPointForCoordinate(coordinate);
		
        		// if it is the first point, just use them, since we have nothing to compare to yet.
        		if (idx == 0) {
        			northEastPoint = point;
        			southWestPoint = point;
        		} else {
        			if (point.x > northEastPoint.x)
        				northEastPoint.x = point.x;
        			if(point.y > northEastPoint.y)
        				northEastPoint.y = point.y;
        			if (point.x < southWestPoint.x)
        				southWestPoint.x = point.x;
        			if (point.y < southWestPoint.y)
        				southWestPoint.y = point.y;
        		}
        
		pointArray[idx] = point;
	}
	
    if (self.routeLine) {
        [self.mapView removeOverlay:self.routeLine];
    }
    
    self.routeLine = [MKPolyline polylineWithPoints:pointArray count:_points.count];
    
    // add the overlay to the map
	if (nil != self.routeLine) {
		[self.mapView addOverlay:self.routeLine];
	}
    
    // clear the memory allocated earlier for the points
	free(pointArray);
    
    
     double width = northEastPoint.x - southWestPoint.x;
     double height = northEastPoint.y - southWestPoint.y;
     
     _routeRect = MKMapRectMake(southWestPoint.x, southWestPoint.y, width, height);
     
     // zoom in on the route. 
     [self.mapView setVisibleMapRect:_routeRect];
     
}



- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    NSLog(@"%@ ----- %@", self, NSStringFromSelector(_cmd));
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:userLocation.coordinate.latitude
                                                      longitude:userLocation.coordinate.longitude];
    // check the zero point
    if  (userLocation.coordinate.latitude == 0.0f ||
         userLocation.coordinate.longitude == 0.0f)
        return;
    
    // check the move distance
    if (_points.count > 0) {
        CLLocationDistance distance = [location distanceFromLocation:_currentLocation];
        if (distance < 1)
            return;
    }
    
    if (nil == _points) {
        _points = [[NSMutableArray alloc] init];
    }
    
    [_points addObject:location];
    _currentLocation = location;
    
    NSLog(@"points: %@", _points);
    
    [self configureRoutes];
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude);
    [self.mapView setCenterCoordinate:coordinate animated:YES];
}

//over lay

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
{
    NSLog(@"%@ ----- %@", self, NSStringFromSelector(_cmd));
    
	MKOverlayView* overlayView = nil;
	
	if(overlay == self.routeLine)
	{
		//if we have not yet created an overlay view for this overlay, create it now.
        if (self.routeLineView) {
            [self.routeLineView removeFromSuperview];
        }
        
        self.routeLineView = [[MKPolylineView alloc] initWithPolyline:self.routeLine];
        self.routeLineView.fillColor = [UIColor redColor];
        self.routeLineView.strokeColor = [UIColor redColor];
        self.routeLineView.lineWidth = 10;
        
		overlayView = self.routeLineView;
	}
	
	return overlayView;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    NSLog(@"-------viewForAnnotation-------");

    
    //此类可以显示针一样的图标
    MKPinAnnotationView *newAnnotation=[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"annotation1"];
    
    //newAnnotation.animatesDrop=YES;
    //newAnnotation.animatesDrop=NO;
    
    newAnnotation.pinColor=MKPinAnnotationColorPurple;
    //显示标志提示
    newAnnotation.canShowCallout=YES;
    return newAnnotation;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}





@end
