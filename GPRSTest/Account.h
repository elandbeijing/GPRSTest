//
//  Account.h
//  GPRSTest
//
//  Created by ElandApple02 on 13. 2. 4..
//  Copyright (c) 2013년 ElandApple02. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Account : NSManagedObject

@property (nonatomic,strong) NSString *sex;
@property float height;
@property float weight;

@end
