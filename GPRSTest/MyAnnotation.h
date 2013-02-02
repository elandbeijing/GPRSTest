//
//  MyAnnotation.h
//  GPRSTest
//
//  Created by ElandApple02 on 13. 2. 2..
//  Copyright (c) 2013년 ElandApple02. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MyAnnotation : NSObject<MKAnnotation>

@property (nonatomic,readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic,strong) NSString *subtitle;
@property (nonatomic,strong) NSString *title;

-(id) initWithCoords:(CLLocationCoordinate2D) coords;   
@end
