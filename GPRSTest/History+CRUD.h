//
//  History+CRUD.h
//  GPRSTest
//
//  Created by ElandApple02 on 13. 2. 4..
//  Copyright (c) 2013년 ElandApple02. All rights reserved.
//

#import "History.h"

@interface History (CRUD)


+(History *)historyWithCode:(NSString *)code inManagedObjectContext:(NSManagedObjectContext *)context;
+(NSArray *)historysInManagedObjectContext:(NSManagedObjectContext *)context;
+(void)deleteSection:(History *)history inManagedObjectContext:(NSManagedObjectContext *)context;
@end
