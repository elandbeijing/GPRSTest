//
//  MyCLController.h
//  GPRSTest
//
//  Created by ElandApple02 on 13. 1. 31..
//  Copyright (c) 2013년 ElandApple02. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>


// This is hoping that in the future (beyond SDK 2.0) we can access SystemConfiguration info


#import <SystemConfiguration/SCNetworkConnection.h>





// This protocol is used to send the info for location updates back to another view controller


@protocol MyCLControllerDelegate <NSObject>


@required


-(void)gpsUpdate:(CLLocation *)aLoc;


@end

// Class definition


@interface MyCLController : NSObject <CLLocationManagerDelegate> {
    
    
    BOOL findShouldStop;

}

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic,strong) id <MyCLControllerDelegate> delegate;
@property (nonatomic, strong) CLLocation *myCurrentLoc;

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation;
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error;
+ (MyCLController *)sharedInstance;

@end






