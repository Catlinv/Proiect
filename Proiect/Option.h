//
//  Option.h
//  Proiect
//
//  Created by webteam on 03/03/16.
//  Copyright © 2016 user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Option : NSManagedObject

-(void)fillOptionWithOption:(Option *)option;

@end

NS_ASSUME_NONNULL_END

#import "Option+CoreDataProperties.h"
