//
//  PROLocationManager.m
//  Proiect
//
//  Created by webteam on 09/05/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "PROLocationManager.h"

@interface PROLocationManager () <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation PROLocationManager

static PROLocationManager *sharedInstance = nil;

+ (instancetype) sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [PROLocationManager new];
    });
    return sharedInstance;
}

#pragma mark - Lifecycle

- (instancetype)init {
    self = [super init];
    if (self) {
        self.locationManager = [CLLocationManager new];
        self.locationManager.delegate = self;
        [self requestPermission];
    }
    return self;
}

#pragma mark - Private Methods

- (void)requestPermission {
    switch ([CLLocationManager authorizationStatus]) {
        case kCLAuthorizationStatusNotDetermined:
            [self.locationManager requestWhenInUseAuthorization];
            break;
        case kCLAuthorizationStatusRestricted | kCLAuthorizationStatusDenied:
            NSLog(@"Enable Location plox");
        default:
            break;
    }
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
}












@end
