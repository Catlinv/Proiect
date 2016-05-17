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
@property (strong, nonatomic) CLLocation *bestLocation;
@property (strong, nonatomic) NSTimer *timer;

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
        [self setupLocationManager];
        [self determinePermissionForAuthorisationStatus:[CLLocationManager authorizationStatus]];
    }
    return self;
}

#pragma mark - Setters

- (void)setDelegate:(id<PROLocationManagerDelegate>)delegate {
    _delegate = delegate;
    
    if (delegate)
        [self setupTimer];
    else
        [self stopTracker];
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

//TODO: (CS) Add stop tracker but only stop timer

- (void)stopTracker{
    if ([self.timer isValid]){
        [self.timer invalidate];
    }
    self.timer = nil;
}

#pragma mark - Private Methods

- (void)setupTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:kRefreshRateInSeconds target:self selector:@selector(sendBestLocation:) userInfo:nil repeats:YES];
    [self.timer fire];
}

- (void)setupLocationManager {
    self.locationManager = [CLLocationManager new];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    self.locationManager.delegate = self;
}

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

- (void)sendBestLocation:(NSTimer *)timer{
    if (self.delegate /*&& [self.delegate respondsToSelector:@selector(proLocationManager:sendLocations:)]*/) {
        [self.delegate proLocationManager:self sendLocation:self.bestLocation];
    }
    self.bestLocation = nil;
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    [self determinePermissionForAuthorisationStatus:status];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    
    
    double bestAcc = (self.bestLocation) ? self.bestLocation.horizontalAccuracy : 15000.0;
    for (int i = 0; i < locations.count; i++)
        if (locations[i].horizontalAccuracy < bestAcc)
        {
            self.bestLocation = locations[i];
            bestAcc = locations[i].horizontalAccuracy;
        }
        
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Locatia nu a putut fi determinata");
}










@end
