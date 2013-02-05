//
//  History+CRUD.m
//  GPRSTest
//
//  Created by ElandApple02 on 13. 2. 4..
//  Copyright (c) 2013년 ElandApple02. All rights reserved.
//

#import "History+CRUD.h"

@implementation History (CRUD)



+(History *)historyWithCode:(NSString *)code inManagedObjectContext:(NSManagedObjectContext *)context
{
    History *history;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"History"];
    request.predicate = [NSPredicate predicateWithFormat:@"code = %@",code];
    
    NSError *error = nil;
    NSArray *historys = [context executeFetchRequest:request error:&error];
    
    if(!historys || historys.count > 1){
        // error
    }else if(!historys.count){
        history = [NSEntityDescription insertNewObjectForEntityForName:@"History" inManagedObjectContext:context];
        history.code = code;
        NSLog(@"history entity is saved! Code:%@", code);
    }else {
        history = [historys lastObject];
    }
    
    return history;
}

+(NSArray *)historysInManagedObjectContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *requst = [NSFetchRequest fetchRequestWithEntityName:@"History"];
    NSArray *historys = [context executeFetchRequest:requst error:nil];
    return historys;
}

+(void)deletehistory:(History *)history inManagedObjectContext:(NSManagedObjectContext *)context
{
    [context deleteObject:history];
}
@end
