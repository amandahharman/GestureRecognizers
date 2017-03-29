//
//  Coaster+CoreDataProperties.m
//  PanPractice
//
//  Created by Amanda Harman on 3/29/17.
//  Copyright © 2017 Amanda Harman. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Coaster+CoreDataProperties.h"

@implementation Coaster (CoreDataProperties)

+ (NSFetchRequest<Coaster *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Coaster"];
}

@dynamic fontSize;
@dynamic image;
@dynamic rotation;

@end
