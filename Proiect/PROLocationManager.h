//
//  PROLocationManager.h
//  Proiect
//
//  Created by webteam on 09/05/16.
//  Copyright © 2016 user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#define PROLocationManagerInstance [PROLocationManager sharedInstance]

@protocol PROLocationManagerDelegate;

@interface PROLocationManager : NSObject

@property(weak, nonatomic) id<PROLocationManagerDelegate> delegate;

@end

@protocol PROLocationManagerDelegate <NSObject>

- (void) proLocationManager:(PROLocationManager *)locationManager sendLocations:(CLLocation *)location;

@end