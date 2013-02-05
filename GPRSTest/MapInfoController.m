//
//  MapInfoController.m
//  GPRSTest
//
//  Created by ElandApple02 on 13. 1. 31..
//  Copyright (c) 2013년 ElandApple02. All rights reserved.
//

#import "MapInfoController.h"

static float distanceSum;

@interface MapInfoController ()
{
    NSTimer *timer;
    BOOL checked;
    NSString *timestr;
    float time;
    float time_lap;
    NSString *timestr_lap;
    NSArray *list_time;
    NSArray *list_lap;

}

@end



@implementation MapInfoController

- (void)viewDidUnload {
    distanceSum =0;
    [self setShowView:nil];
    [self setTimeSection:nil];
    [self setDistance:nil];
    [self setLeftbtn:nil];
    [self setRightbtn:nil];
    [self setMapView:nil];
    [self setPoints:nil];
    [self setRouteLine:nil];
    [self setRouteLineView:nil];
    [self setLocationManager:nil];
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
    if(!self.mapView)
    {
        self.mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    }
   // [self.mapView setMapType:MKMapTypeHybrid];
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    self.mapView.userInteractionEnabled = YES;
    self.mapView.userTrackingMode = MKUserTrackingModeFollowWithHeading;


        [self.ShowView addSubview:self.mapView];
    

    
    
    // configure location manager
    // [self configureLocationManager];
    

    
    checked=YES;
    [_timeSection setText:@"00:00:00:00"];

}


- (void)configureRoutes
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    // define minimum, maximum points
	MKMapPoint northEastPoint = MKMapPointMake(0.f, 0.f);
	MKMapPoint southWestPoint = MKMapPointMake(0.f, 0.f);
	
	// create a c array of points.
	MKMapPoint* pointArray = malloc(sizeof(CLLocationCoordinate2D) * _points.count);
    
    
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
    
    
//     double width = northEastPoint.x - southWestPoint.x;
//     double height = northEastPoint.y - southWestPoint.y;
//     
//     _routeRect = MKMapRectMake(southWestPoint.x, southWestPoint.y, width, height);
//     
//     // zoom in on the route. 
//     [self.mapView setVisibleMapRect:_routeRect];
    
}



- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    NSLog(@"%@ ----- %@", self, NSStringFromSelector(_cmd));
    
    
//    CLLocation *location = [[CLLocation alloc] initWithLatitude:userLocation.coordinate.latitude
//                                                      longitude:userLocation.coordinate.longitude];
//   // _lblLat.text=[NSString stringWithFormat:@"%f",userLocation.coordinate.latitude];
//   // _lblLon.text=[NSString stringWithFormat:@"%f",userLocation.coordinate.longitude];
//    
//    NSLog(@"%f,%f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
//    
//    // check the zero point
//    if  (userLocation.coordinate.latitude == 0.0f ||
//         userLocation.coordinate.longitude == 0.0f)
//        return;
//    
//    // check the move distance
//    if (_points.count > 0) {
//        CLLocationDistance distance = [location distanceFromLocation:_currentLocation];
//        
//        if (distance < 2)
//            return;
//        else
//        {
//            distanceSum+=distance;
//            _distance.text=[NSString stringWithFormat:@"%d m",(int)distanceSum];
//        }
//    }
//    
//    if (nil == _points) {
//        _points = [[NSMutableArray alloc] init];
//    }
//    
//    [_points addObject:location];
//    _currentLocation = location;
//    
//  
//    
//    NSLog(@"points: %@", _points);
//    
//   // [self configureRoutes];
//    
//    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude);
//    [self.mapView setCenterCoordinate:coordinate animated:YES];
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
        self.routeLineView.lineWidth = 3;
        
		overlayView = self.routeLineView;
	}
	
	return overlayView;
}

//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
//    NSLog(@"-------viewForAnnotation-------");
//
//
//    //此类可以显示针一样的图标
//    MKPinAnnotationView *newAnnotation=[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"annotation1"];
//    
//    //newAnnotation.animatesDrop=YES;
//    //newAnnotation.animatesDrop=NO;
//    
//    newAnnotation.pinColor=MKPinAnnotationColorPurple;
//    //显示标志提示
//   // newAnnotation.canShowCallout=YES;
//    return newAnnotation;
//}

//- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
//{
////    CLLocationCoordinate2D coordinate=CLLocationCoordinate2DMake(_currentLocation.coordinate.latitude, _currentLocation.coordinate.longitude);
////    if(_pinAnnotation!=nil)
////    {
////        [_mapView removeAnnotation:_pinAnnotation];
////
////    }
////    _pinAnnotation= [[MyAnnotation alloc] initWithCoords:coordinate];
////    _pinAnnotation.title = @"PIN-TITLE";
////    _pinAnnotation.subtitle = @"PIN_SUBTITLE";
////    [_mapView addAnnotation:_pinAnnotation];
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}





- (IBAction)StartOrPause:(id)sender {
    
    //点击切换按钮背景图
    // UIImage *newImage = (checked) ? [UIImage imageNamed:@"red.png"] : [UIImage imageNamed:@"green.png"];
    // [_leftbtn setBackgroundImage:newImage forState:UIControlStateNormal];
    
        [self configureRoutes];
    NSString *titlel = (checked) ? (@"Pause") : (@"Start");
    [_leftbtn setTitle:titlel forState:UIControlStateNormal];
//    NSString *titler = (checked) ? (@"Lap") : (@"Reset");
//    [_rightbtn setTitle:titler forState:UIControlStateNormal];
    
    
    if (checked)   //start
    {
        timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
    }else {        //stop
        [timer invalidate];
    }
    
    checked = !checked;

}

- (IBAction)stopOrExit:(id)sender {
    
   // [timer invalidate];
        NSLog(@"%@",NSStringFromSelector(_cmd));

    
    static NSInteger count = 1;
    
    if (checked) //reset
    {
        time = time_lap = 0.0;
        timestr = [NSString stringWithFormat:@"00:00:00:00"];
        [_timeSection setText:timestr];
        list_time = list_lap = nil;
        count = 1;
       // [_tableview reloadData];
        
    }else {      //lap
        if (list_time == nil) {
            list_time = [[NSArray alloc]initWithObjects:timestr_lap, nil];
            list_lap = [[NSArray alloc]initWithObjects:[NSString stringWithFormat:@"%d",count++], nil];
        }else {
            
            NSArray *array = [[NSArray alloc]initWithObjects:timestr_lap, nil];
            list_time = [array arrayByAddingObjectsFromArray:list_time];
            array = [[NSArray alloc]initWithObjects:[NSString stringWithFormat:@"%d",count++], nil];
            list_lap = [array arrayByAddingObjectsFromArray:list_lap];
            
        }
        time_lap = 0;
      //  [_tableview reloadData];
    }

    
        [self.navigationController popViewControllerAnimated:YES];
   // [self viewDidUnload];

}

- (float) updateTime
{
    time+=0.01;
    time_lap +=0.01;
    timestr = [NSString stringWithFormat:@"%02d:%02d:%05.2f",(int)(time / 3600) ,(int)(time / 60) ,time - ( 60 * (int)( time / 60 ) )];
    timestr_lap = [NSString stringWithFormat:@"%02d:%02d:%05.2f",(int)(time_lap / 3600) ,(int)(time_lap / 60) ,time_lap - ( 60 * (int)( time_lap / 60 ) )];
    timestr=[timestr stringByReplacingOccurrencesOfString:@"." withString:@":"];
    timestr_lap=[timestr_lap stringByReplacingOccurrencesOfString:@"." withString:@":"];
    [_timeSection setText:timestr];
    return time;
}

@end
