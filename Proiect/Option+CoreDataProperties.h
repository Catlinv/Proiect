//
//  Option+CoreDataProperties.h
//  Proiect
//
//  Created by webteam on 03/03/16.
//  Copyright © 2016 user. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Option.h"

NS_ASSUME_NONNULL_BEGIN

@interface Option (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *answer;
@property (nullable, nonatomic, retain) NSNumber *isAnswer;

@end

NS_ASSUME_NONNULL_END
