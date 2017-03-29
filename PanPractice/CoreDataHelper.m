//
//  CoreDataHelper.m
//  PanPractice
//
//  Created by James Smith on 1/20/17.
//  Copyright © 2017 New Potato Technologies, Inc. All rights reserved.
//

#import "CoreDataHelper.h"

@interface CoreDataHelper()

@property (nonatomic, strong) NSDateFormatter *jsonDateFormatter;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSManagedObjectContext *testingContext;

@end

@implementation CoreDataHelper

+ (CoreDataHelper *)sharedHelper {
  static CoreDataHelper *sharedHelper = NULL;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedHelper = [[self alloc] init];
  });
  
  return sharedHelper;
}

- (instancetype)init {
  self = [super init];
  
  if (self) {
  }
  
  return self;
}

- (NSURL *)applicationDocumentsDirectory {
  return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSDateFormatter *)getJSONDateFormatter {

  if (!self.jsonDateFormatter) {
    self.jsonDateFormatter = [[NSDateFormatter alloc] init];
    [self.jsonDateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    [self.jsonDateFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"]];
    [self.jsonDateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
  }
  
  return self.jsonDateFormatter;
}

- (NSManagedObjectContext *)getManagedObjectContext {

  if (self.isTesting) {
    if (self.testingContext) {
      return self.testingContext;
    }

    self.testingContext = [self managedObjectContextForTesting];
    return self.testingContext;
  }

  if (self.managedObjectContext) {
    return self.managedObjectContext;
  }

  self.managedObjectContext = [self managedObjectContextForApp];
  return self.managedObjectContext;
}

- (NSManagedObjectContext *)managedObjectContextForApp {
  NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"PanPractice" withExtension:@"momd"];
  NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
  NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
  NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"PanPractice.sqlite"];
  NSError *error = nil;
  NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption:@(YES), NSInferMappingModelAutomaticallyOption:@(YES)};
  
  if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
#if DEBUG
    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    abort();
#endif
  }
  
  NSManagedObjectContext *managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
  [managedObjectContext setPersistentStoreCoordinator:persistentStoreCoordinator];
  
  return managedObjectContext;
}

- (NSManagedObjectContext *)managedObjectContextForTesting {
  NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"PanPractice" withExtension:@"momd"];
  NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
  NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
  [persistentStoreCoordinator addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:nil options:nil error:NULL];
  NSManagedObjectContext *testingContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
  testingContext.persistentStoreCoordinator = persistentStoreCoordinator;
  
  return testingContext;
}

- (void)resetTestingContext {
  self.testingContext = nil;
}

- (void)saveContext {
  NSManagedObjectContext *managedObjectContext;
  
  if (self.isTesting) {
    managedObjectContext = self.testingContext;
  } else {
    managedObjectContext = self.managedObjectContext;
  }
  
  if (managedObjectContext != nil) {
    NSError *error = nil;
    
    if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
#if DEBUG
      NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
      abort();
#endif
    }
  }
}

@end
