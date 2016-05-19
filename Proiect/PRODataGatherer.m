//
//  PRODataGatherer.m
//  Proiect
//
//  Created by webteam on 18/05/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "PRODataGatherer.h"
#import "PROQuestion.h"

#define kFileName @"QuestionDataSet"

@implementation PRODataGatherer


//TODO: (CS) Erase Array after fixing CoreData
static NSArray <PROQuestion *> *questionsArray = nil;

#pragma mark - Public Methods

+ (void)fillCoreData {
    NSString *filePath =[[NSBundle mainBundle] pathForResource:kFileName ofType:@"plist"];
    NSMutableDictionary *plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    NSArray *value = [plistDict objectForKey:@"QuestionsArray"];
    NSMutableArray *auxArray = [NSMutableArray new];
    for (NSDictionary *question in value)
    {
        PROQuestion *aux = [PROQuestion questionWithDictionary:question] ;
        
        [auxArray addObject:aux];
    }
    questionsArray = auxArray;
}

+ (NSArray<PROQuestion *> *)getQuestionsArray {
    return questionsArray;
}

@end
