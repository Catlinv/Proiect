//
//  PRODataGatherer.m
//  Proiect
//
//  Created by webteam on 18/05/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "PRODataGatherer.h"
#import "PROQuestion.h"
#import "CoreDataManager.h"

#define kFileName @"QuestionDataSet"

@interface PRODataGatherer () <CoreDataManagerDelegate>

@property (strong, nonatomic, readwrite) NSArray <PROQuestion *> *questionsArray;

@property (nonatomic, copy) void (^successCompletionBlock)(NSArray<Question *> *);
@property (nonatomic, copy) void (^failureCompletionBlock)();

@end

@implementation PRODataGatherer

static PRODataGatherer *sharedInstance;

+ (PRODataGatherer *)sharedInstance {
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[PRODataGatherer alloc] init];
    });
    return sharedInstance;
}

//TODO: (CS) Erase Array after fixing CoreData

#pragma mark - Public Methods

- (void)fillCoreData {
    __weak PRODataGatherer *welf = self;
    self.failureCompletionBlock = ^(){
        NSString *filePath =[[NSBundle mainBundle] pathForResource:kFileName ofType:@"plist"];
        NSMutableDictionary *plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
        NSArray *value = [plistDict objectForKey:@"QuestionsArray"];
        NSMutableArray *auxArray = [NSMutableArray new];
        for (NSDictionary *question in value)
        {
            PROQuestion *aux = [PROQuestion questionWithDictionary:question] ;
            
            [auxArray addObject:aux];
        }
        [CoreDataManagerInstance addQuestions:auxArray];
        welf.questionsArray = auxArray;
    };
    
    [CoreDataManagerInstance setDelegate:self];
    [CoreDataManagerInstance requestQuestionsAsync];
}

- (void)fillQuestions{
    __weak PRODataGatherer *welf = self;
    self.successCompletionBlock = ^(NSArray<Question *> *resultsArray){
        NSMutableArray <PROQuestion *> *auxArray = [NSMutableArray new];
        for (Question *question in resultsArray) {
            [auxArray addObject:[PROQuestion convertQuestionToPROQuestion:question]];
        }
        //TODO: (CS) MAKE ANOTHER FUCKING DELEGATE FML AT HOME (at least try)
        //Hints: ViewController is the delegate
        welf.questionsArray = auxArray;
        
        if (welf.delegate && [welf.delegate respondsToSelector:@selector(dataGathererDidFinishFilling:)]) {
            [welf.delegate dataGathererDidFinishFilling:welf];
        }
    };
    [CoreDataManagerInstance setDelegate:self];
    [CoreDataManagerInstance requestQuestionsAsync];
}

#pragma mark - CoreDataManagerDelegate

- (void)coreDataManagerDidFailDueToErrorCode:(NSError *)error{
    if (self.failureCompletionBlock)
        self.failureCompletionBlock();
}

- (void)coreDataManagerDidRetreiveResults:(NSArray<Question *> *)resultsArray{
    if (resultsArray.count != 0) {
        if (self.successCompletionBlock)
            self.successCompletionBlock(resultsArray);
    }
    else {
        if (self.failureCompletionBlock)
            self.failureCompletionBlock();
    }
}


















@end
