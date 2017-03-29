//
//  Coaster+CoreDataProperties.h
//  PanPractice
//
//  Created by Amanda Harman on 3/29/17.
//  Copyright © 2017 Amanda Harman. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Coaster+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Coaster (CoreDataProperties)

+ (NSFetchRequest<Coaster *> *)fetchRequest;

@property (nonatomic) float fontSize;
@property (nullable, nonatomic, copy) NSString *image;
@property (nonatomic) float rotation;

@end

NS_ASSUME_NONNULL_END
