//
//  Question+CoreDataProperties.m
//  Proiect
//
//  Created by webteam on 03/03/16.
//  Copyright © 2016 user. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Question+CoreDataProperties.h"

@implementation Question (CoreDataProperties)

@dynamic name;
@dynamic type;
@dynamic longitude;
@dynamic extraInfo;
@dynamic latitude;
@dynamic isSolved;
@dynamic isUnlocked;
@dynamic options;

@end
