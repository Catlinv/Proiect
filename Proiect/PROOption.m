//
//  PROOption.m
//  Proiect
//
//  Created by OctavF on 19/03/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "PROOption.h"

@implementation PROOption

-(void)fillOptionWithOption:(PROOption *)option{
    self.answer = option.answer;
    self.isAnswer = option.isAnswer;
}

+ (instancetype)optionWithDictionary:(NSDictionary *)dictionar{
    PROOption *optiune = [PROOption new];
    
    optiune.answer = [dictionar valueForKey:@"answer"];
    optiune.isAnswer = [dictionar valueForKey:@"isAnswer"];
    return optiune;
}

@end
