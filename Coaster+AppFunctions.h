//
//  Coaster+AppFunctions.h
//  PanPractice
//
//  Created by Amanda Harman on 3/22/17.
//  Copyright © 2017 Amanda Harman. All rights reserved.
//

#import "Coaster+CoreDataClass.h"

@interface Coaster (AppFunctions)

+ (NSArray *)fetchAllCoasters;
+ (void)saveCoasterWithJSONDictionary:(NSDictionary *)jsonDictionary;

@end
