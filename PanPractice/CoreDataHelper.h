//
//  CoreDataHelper.h
//  BrioApp
//
//  Created by James Smith on 1/20/17.
//  Copyright © 2017 New Potato Technologies, Inc. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>

@interface CoreDataHelper : NSObject

@property (nonatomic, assign) BOOL isTesting;

+ (CoreDataHelper *)sharedHelper;

- (NSDateFormatter *)getJSONDateFormatter;
- (NSManagedObjectContext *)getManagedObjectContext;
- (void)resetTestingContext;
- (void)saveContext;

@end
