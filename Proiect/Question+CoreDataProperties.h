//
//  Question+CoreDataProperties.h
//  Proiect
//
//  Created by webteam on 03/03/16.
//  Copyright © 2016 user. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Question.h"

NS_ASSUME_NONNULL_BEGIN

@interface Question (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *type;
@property (nullable, nonatomic, retain) NSNumber *longitude;
@property (nullable, nonatomic, retain) NSString *extraInfo;
@property (nullable, nonatomic, retain) NSNumber *latitude;
@property (nullable, nonatomic, retain) NSNumber *isSolved;
@property (nullable, nonatomic, retain) NSNumber *isUnlocked;
@property (nullable, nonatomic, retain) NSSet<Option *> *options;

@end

@interface Question (CoreDataGeneratedAccessors)

- (void)addOptionsObject:(Option *)value;
- (void)removeOptionsObject:(Option *)value;
- (void)addOptions:(NSSet<Option *> *)values;
- (void)removeOptions:(NSSet<Option *> *)values;

@end

NS_ASSUME_NONNULL_END
