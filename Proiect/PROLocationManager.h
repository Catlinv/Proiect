//
//  PROLocationManager.h
//  Proiect
//
//  Created by webteam on 09/05/16.
//  Copyright © 2016 user. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PROLocationManagerInstance [PROLocationManager sharedInstance]

@protocol PROLocationManagerDelegate;

@interface PROLocationManager : NSObject

@property(weak, nonatomic) id<PROLocationManagerDelegate> delegate;

- (void)startTracker;

+ (instancetype) sharedInstance;

@end

@protocol PROLocationManagerDelegate <NSObject>

- (void) proLocationManager:(PROLocationManager *)locationManager sendLocation:(CLLocation *)location;

@end