//
//  NSObject_Coaster_AppFunctions.h
//  PanPractice
//
//  Created by Amanda Harman on 3/22/17.
//  Copyright © 2017 Amanda Harman. All rights reserved.
//


#import "Coaster+AppFunctions.h"
#import "CoreDataHelper.h"


@implementation Coaster (AppFunctions)


+ (NSArray *)fetchAllCoasters {
  NSFetchRequest *fetchRequest = [Coaster fetchRequest];
  
  NSError *error = nil;
  NSArray *objects = [[[CoreDataHelper sharedHelper] getManagedObjectContext] executeFetchRequest:fetchRequest error:&error];
  
  if (objects && objects.count) {
    
    return objects;
  }
  
  return NULL;
}

+ (void)saveCoasterWithJSONDictionary:(NSDictionary *)jsonDictionary{
  if (jsonDictionary.count == 0) {
    return;
  }
  
  NSManagedObjectContext *managedObjectContext = [[CoreDataHelper sharedHelper] getManagedObjectContext];
  
  Coaster *coaster = [NSEntityDescription insertNewObjectForEntityForName: @"Coaster" inManagedObjectContext:managedObjectContext];
  
  for (id key in jsonDictionary){
    id value = jsonDictionary[key];
    [coaster setValue:value forKey:key];
  }
  
  [[CoreDataHelper sharedHelper] saveContext];
  
}

@end
