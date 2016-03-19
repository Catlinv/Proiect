//
//  PROOption.h
//  Proiect
//
//  Created by OctavF on 19/03/16.
//  Copyright © 2016 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PROOption : NSObject

@property (nonatomic, strong) NSString *answer;
@property (nonatomic, strong) NSNumber *isAnswer;


-(void)fillOptionWithOption:(PROOption *)option;

@end
