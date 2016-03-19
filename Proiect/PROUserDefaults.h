//
//  PROUserDefaults.h
//  Proiect
//
//  Created by OctavF on 19/03/16.
//  Copyright © 2016 user. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PROUserDefaultsInstance [PROUserDefaults sharedInstance]

extern NSString *const kPROUserDefaultsValueChangedNotification;
extern NSString *const kPROUserDefaultsValueNameKey;
extern NSString *const kPROUserDefaultsNewValueKey;

extern NSString *const kPROScore;

@interface PROUserDefaults : NSObject

@property (nonatomic,assign) NSInteger score;

+ (instancetype) sharedInstance;


+ (void)saveBool:(BOOL)value forKey:(NSString *)key;
+ (BOOL)boolForKey:(NSString *)key;

+ (void)saveInteger:(NSInteger)value forKey:(NSString *)key;
+ (NSInteger)integerForKey:(NSString *)key;

+ (void)saveFloat:(float)value forKey:(NSString *)key;
+ (float)floatForKey:(NSString *)key;

+ (void)saveObject:(NSObject *)object forKey:(NSString *)key;
+ (NSObject *)objectForKey:(NSString *)key;

@end
