//
//  MyAnnotation.m
//  GPRSTest
//
//  Created by ElandApple02 on 13. 2. 2..
//  Copyright (c) 2013년 ElandApple02. All rights reserved.
//

#import "MyAnnotation.h"


@implementation MyAnnotation

- (id) initWithCoords:(CLLocationCoordinate2D) coords{
    
    self = [super init];
    
    if (self != nil) {
        
        _coordinate = coords;
        
    }
    
    return self;
    
}



@end
