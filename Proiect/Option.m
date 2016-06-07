//
//  Option.m
//  Proiect
//
//  Created by webteam on 03/03/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "Option.h"
#import "PROOption.h"

@implementation Option

-(void)fillOptionWithOption:(Option *)option{
    self.answer = option.answer;
    self.isAnswer = option.isAnswer;
}

-(void)fillOptionWithPROOption:(PROOption *)option{
    self.answer = option.answer;
    self.isAnswer = option.isAnswer;
}

@end
