//
//  PROUtils.h
//  Proiect
//
//  Created by webteam on 12/05/16.
//  Copyright © 2016 user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface PROUtils : NSObject

/**
 * Returns the distance between the two given spheric coordinate pairs
 * (pointA long, pointA lat) and (pointB long, pointB lat). The distance
 * will be delivered in meter considering that the earth is a sphere with a
 * predefined radius.
 * <p>
 * The distance is calculated according to the spheric trigonometry. The
 * accuracy of the distance is about 200 to 250 ppm if the distance is less
 * than 200 km. This is a maximum of 2,5 meter failure in 1 km.
 *
 * @param pointA first coordinate
 * @param pointB second coordinate
 * @return distance on surface in meter
 */

+ (double)getAirDistancePointA:(CLLocationCoordinate2D)pointA pointB:(CLLocationCoordinate2D)pointB;

@end
