//
//  History.h
//  GPRSTest
//
//  Created by ElandApple02 on 13. 2. 4..
//  Copyright (c) 2013년 ElandApple02. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface History : NSManagedObject

@property float distance;
@property (nonatomic,strong) NSDate *inDateTime;
@property (nonatomic,strong) NSString *runedTime;
@property (nonatomic,strong) NSString *code;

@end
