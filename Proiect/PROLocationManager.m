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
        [self determinePermissionForAuthorisationStatus:[CLLocationManager authorizationStatus]];
    }
    return self;
}

#pragma mark - Public Methods

- (void)startTracker {
    switch ([CLLocationManager authorizationStatus]) {
        case kCLAuthorizationStatusRestricted:
        case kCLAuthorizationStatusDenied:
            NSLog(@"Enable Location plox");
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        case kCLAuthorizationStatusAuthorizedAlways:
            [self.locationManager startUpdatingLocation];
            break;
        default:
            break;
    }
}

#pragma mark - Private Methods

- (void)determinePermissionForAuthorisationStatus:(CLAuthorizationStatus)status{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            [self.locationManager requestWhenInUseAuthorization];
            break;
        case kCLAuthorizationStatusRestricted:
        case kCLAuthorizationStatusDenied:
            NSLog(@"Enable Location plox");
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        case kCLAuthorizationStatusAuthorizedAlways:
            [self.locationManager startUpdatingLocation];
            break;
        default:
            break;
    }
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    [self determinePermissionForAuthorisationStatus:status];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    if (self.delegate /*&& [self.delegate respondsToSelector:@selector(proLocationManager:sendLocations:)]*/) {
        [self.delegate proLocationManager:self sendLocation:[locations lastObject]];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Locatia nu a putut fi determinata");
}










@end
