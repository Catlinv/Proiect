//
//  CoreDataManager.m
//  Proiect
//
//  Created by webteam on 03/03/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "CoreDataManager.h"
#import <CoreData/CoreData.h>
#import "Question.h"
#import "Option.h"

@interface CoreDataManager ()

@property (nonatomic, strong) NSManagedObjectContext        *managedObjectContext;
@property (nonatomic, strong) NSManagedObjectModel          *managedObjectModel;
@property (nonatomic, strong) NSPersistentStoreCoordinator  *persistentStoreCoordinator;

@property (nonatomic, assign) BOOL                          shouldStopCurrentRequest;

@end

@implementation CoreDataManager

static CoreDataManager *sharedInstance;

+ (CoreDataManager *)sharedInstance {
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CoreDataManager alloc] init];
    });
    return sharedInstance;
}

- (void)setDelegate:(id<CoreDataManagerDelegate>)delegate {
    _delegate = delegate;
    self.shouldStopCurrentRequest = YES;
}

#pragma mark - Public methods

- (void)requestQuestionsAsync {
    __weak CoreDataManager *weakSelf = self;
    
    // Initialize Fetch Request
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Question"];
    
    // Add Sort Descriptors
    [fetchRequest setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"isUnlocked" ascending:NO]]];
    
    // Initialize Asynchronous Fetch Request
    NSAsynchronousFetchRequest *asynchronousFetchRequest = [[NSAsynchronousFetchRequest alloc] initWithFetchRequest:fetchRequest completionBlock:^(NSAsynchronousFetchResult *result) {
        if (!weakSelf.shouldStopCurrentRequest) {
            dispatch_async(dispatch_get_main_queue(), ^{
                // Process Asynchronous Fetch Result
                [weakSelf processAsynchronousFetchResult:result];
            });
        }
    }];
    
    self.shouldStopCurrentRequest = NO;
    // Execute Asynchronous Fetch Request
    [self.managedObjectContext performBlock:^{
        // Execute Asynchronous Fetch Request
        NSError *asynchronousFetchRequestError = nil;
        [weakSelf.managedObjectContext executeRequest:asynchronousFetchRequest error:&asynchronousFetchRequestError];
        
        if (asynchronousFetchRequestError) {
            NSLog(@"Unable to execute asynchronous fetch result.");
            NSLog(@"%@, %@", asynchronousFetchRequestError, asynchronousFetchRequestError.localizedDescription);
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(coreDataManagerDidFailDueToErrorCode:)]) {
                [self.delegate coreDataManagerDidFailDueToErrorCode:asynchronousFetchRequestError];
            }
        }
    }];
}

- (void)updateDatabaseState {
    [self saveContext];
}

#pragma mark - Private methods

- (Question *)createQuestionWith:(Question *)question {
    Question *newQuest = [NSEntityDescription insertNewObjectForEntityForName:@"Question" inManagedObjectContext:self.managedObjectContext];
    
    [newQuest fillQuestionWithQuestion:question];
    
    [self saveContext];
    
    return newQuest;
}
//Replace here with Option
- (Option *)createOption:(Option *)option {
    Option *newOption = [NSEntityDescription insertNewObjectForEntityForName:@"Option" inManagedObjectContext:self.managedObjectContext];
    
    [newOption fillOptionWithOption:option];
    
    [self saveContext];
    
    return newOption;
}

- (void)deleteQuestion:(Question *)question {
    NSArray *optionsArray = [question.options allObjects];
     
     for (Option *opt in optionsArray) {
         [self.managedObjectContext deleteObject:opt];
     }
     [self.managedObjectContext deleteObject:question];
     [self saveContext];
    
}

- (void)processAsynchronousFetchResult:(NSAsynchronousFetchResult *)asynchronousFetchResult {
    if (asynchronousFetchResult.finalResult) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(coreDataManagerDidRetreiveResults:)]) {
            [self.delegate coreDataManagerDidRetreiveResults:asynchronousFetchResult.finalResult];
        }
    }
}

- (void)saveContext {
    NSError *error;
    [self.managedObjectContext save:&error];
    
    if (error) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(coreDataManagerDidFailDueToErrorCode:)]) {
            [self.delegate coreDataManagerDidFailDueToErrorCode:error];
        }
    }
}

#pragma mark - Core Data stack

- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    
    return _managedObjectContext;
}


- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    return _managedObjectModel;
}


- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Question.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
