//
//  MyCLController.m
//  GPRSTest
//
//  Created by ElandApple02 on 13. 1. 31..
//  Copyright (c) 2013년 ElandApple02. All rights reserved.
//

#import "MyCLController.h"

static MyCLController *sharedCLDelegate = nil;

@implementation MyCLController
@synthesize delegate, locationManager, myCurrentLoc;


// Called when the location is updated
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{  
    // Horizontal coordinates
    if (signbit(newLocation.horizontalAccuracy)) {
        // Negative accuracy means an invalid or unavailable measurement
        [self.delegate gpsUpdate:nil];
        return;
    }
    
    
    
    
    
    // // Altitude (we don't care about it)
    
    
    // if (signbit(newLocation.verticalAccuracy)) {
    
    
    // // Negative accuracy means an invalid or unavailable measurement
    
    
    // }
    
    
    
    
    
    // Check the timestamp, see if it's an hour old or more. If so, don't send an update
    
    
    if (ABS([newLocation.timestamp timeIntervalSinceNow]) > 3600) {
        
        
        [self.delegate gpsUpdate:nil];
        
        
        return;
        
        
    }
    
    
    myCurrentLoc = [newLocation copy]; // TODO: Why does this increment the retain count? We should be manually retaining
    
    
    
    
    
    // Looks like the loc is good
    
    
    [self.delegate gpsUpdate:myCurrentLoc];
    
    
    return;
    
    
}





// Called when there is an error getting the location


// TODO: Update this function to return the proper info in the proper UI fields


- (void)locationManager:(CLLocationManager *)manager


       didFailWithError:(NSError *)error


{
    
    
    
    
    
    NSMutableString *errorString = [[NSMutableString alloc] init];
    
    
    BOOL shouldQuit;
    
    
    
    
    
    if ([error domain] == kCLErrorDomain) {
        
        
        
        
        
        // We handle CoreLocation-related errors here
        
        
        
        
        
        switch ([error code]) {
                
                
                // This error code is usually returned whenever user taps "Don't Allow" in response to
                
                
                // being told your app wants to access the current location. Once this happens, you cannot
                
                
                // attempt to get the location again until the app has quit and relaunched.
                
                
                //
                
                
                // "Don't Allow" on two successive app launches is the same as saying "never allow". The user
                
                
                // can reset this for all apps by going to Settings > General > Reset > Reset Location Warnings.
                
                
                //
                
                
            case kCLErrorDenied:
                
                
                [errorString appendFormat:@"%@\n", NSLocalizedString(@"LocationDenied", nil)];
                
                
                [errorString appendFormat:@"%@\n", NSLocalizedString(@"AppWillQuit", nil)];
                
                
                shouldQuit = YES;
                
                
                break;
                
                
                
                
                
                // This error code is usually returned whenever the device has no data or WiFi connectivity,
                
                
                // or when the location cannot be determined for some other reason.
                
                
                //
                
                
                // CoreLocation will keep trying, so you can keep waiting, or prompt the user.
                
                
                //
                
                
            case kCLErrorLocationUnknown:
                
                
                [errorString appendFormat:@"%@\n", NSLocalizedString(@"LocationUnknown", nil)];
                
                
                [errorString appendFormat:@"%@\n", NSLocalizedString(@"AppWillQuit", nil)];
                
                
                shouldQuit = YES;
                
                
                break;
                
                
                
                
                
                // We shouldn't ever get an unknown error code, but just in case...
                
                
                //
                
                
            default:
                
                
                [errorString appendFormat:@"%@ %d\n", NSLocalizedString(@"GenericLocationError", nil), [error code]];
                
                
                shouldQuit = NO;
                
                
                break;
                
                
        }
        
        
    } else {
        
        
        // We handle all non-CoreLocation errors here
        
        
        // (we depend on localizedDescription for localization)
        
        
        [errorString appendFormat:@"Error domain: \"%@\" Error code: %d\n", [error domain], [error code]];
        
        
        [errorString appendFormat:@"Description: \"%@\"\n", [error localizedDescription]];
        
        
        shouldQuit = NO;
        
        
    }
    
    
    
    
    
    // TODO: Send the delegate the alert?
    
    
    if (shouldQuit) {
        
        
        // do nothing
        
        
    }
    
    
}





#pragma mark ---- singleton object methods ----





// See "Creating a Singleton Instance" in the Cocoa Fundamentals Guide for more info





+ (MyCLController *)sharedInstance {
    
    
    @synchronized(self) {
        
        
        if (sharedCLDelegate == nil) {
            
            
           // [[self alloc] init]; // assignment not done here
            
            
        }
        
        
    }
    
    
    return sharedCLDelegate;
    
    
}





+ (id)allocWithZone:(NSZone *)zone {
    
    
    @synchronized(self) {
        
        
        if (sharedCLDelegate == nil) {
            
            
            sharedCLDelegate = [super allocWithZone:zone];
            
            
            return sharedCLDelegate; // assignment and return on first allocation
            
            
        }
        
        
    }
    
    
    return nil; // on subsequent allocation attempts return nil
    
    
}





- (id)copyWithZone:(NSZone *)zone


{
    
    
    return self;
    
    
}




@end
