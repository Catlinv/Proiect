//
//  PROUserDefaults.m
//  Proiect
//
//  Created by OctavF on 19/03/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "PROUserDefaults.h"

NSString *const kPROUserDefaultsValueChangedNotification = @"kPROUserDefaultsValueChangedNotification";
NSString *const kPROUserDefaultsValueNameKey = @"kPROUserDefaultsValueNameKey";
NSString *const kPROUserDefaultsNewValueKey = @"kPROUserDefaultsNewValueKey";

NSString *const kPROScore = @"kPROScore";

@implementation PROUserDefaults

#pragma mark - Singleton implementation

static PROUserDefaults *sharedInstance = nil;

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        sharedInstance = [PROUserDefaults new];
    });
    return sharedInstance;
}

#pragma mark - Getters

- (NSInteger)score {
    return [PROUserDefaults integerForKey:kPROScore];
}

#pragma mark - Setters

- (void)setScore:(NSInteger)score {
    [PROUserDefaults saveInteger:score forKey:kPROScore];
}

#pragma mark - Class methods User Defaults

+ (void)saveBool:(BOOL)value forKey:(NSString *)key {
    if (!key) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //post the value changed notification
    NSDictionary *info = @{kPROUserDefaultsValueNameKey: key,
                           kPROUserDefaultsNewValueKey : [NSNumber numberWithBool:value]};
    [[NSNotificationCenter defaultCenter] postNotificationName:kPROUserDefaultsValueChangedNotification object:nil userInfo:info];
}

+ (BOOL)boolForKey:(NSString *)key {
    if (key) {
        return [[NSUserDefaults standardUserDefaults] boolForKey:key];
    } else {
        return NO;
    }
}

+ (void)saveInteger:(NSInteger)value forKey:(NSString *)key {
    if (!key) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setInteger:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //post the value changed notification
    NSDictionary *info = @{kPROUserDefaultsValueNameKey : key,
                           kPROUserDefaultsNewValueKey : [NSNumber numberWithInteger:value]};
    [[NSNotificationCenter defaultCenter] postNotificationName:kPROUserDefaultsValueChangedNotification object:nil userInfo:info];
}

+ (NSInteger)integerForKey:(NSString *)key {
    if (key) {
        return [[NSUserDefaults standardUserDefaults] integerForKey:key];
    } else {
        return 0;
    }
}

+ (void)saveFloat:(float)value forKey:(NSString *)key {
    if (!key) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setFloat:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //post the value changed notification
    NSDictionary *info = @{kPROUserDefaultsValueNameKey : key,
                           kPROUserDefaultsNewValueKey : [NSNumber numberWithFloat:value]};
    [[NSNotificationCenter defaultCenter] postNotificationName:kPROUserDefaultsValueChangedNotification object:nil userInfo:info];
}

+ (float)floatForKey:(NSString *)key {
    if (key) {
        return [[NSUserDefaults standardUserDefaults] floatForKey:key];
    } else {
        return 0.0;
    }
}

+ (void)saveObject:(NSObject *)object forKey:(NSString *)key {
    if (!key) {
        return;
    }
    if (object) {
        [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
    } else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //post the value changed notification
    NSDictionary *info = @{kPROUserDefaultsValueNameKey : key,
                           kPROUserDefaultsNewValueKey : object ? : [NSNull null]};
    [[NSNotificationCenter defaultCenter] postNotificationName:kPROUserDefaultsValueChangedNotification object:nil userInfo:info];
}

+ (NSObject *)objectForKey:(NSString *)key {
    if (key) {
        return [[NSUserDefaults standardUserDefaults] objectForKey:key];
    } else {
        return nil;
    }
}

@end
