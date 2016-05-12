//
//  PROUtils.m
//  Proiect
//
//  Created by webteam on 12/05/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "PROUtils.h"

#define kDeg2RadFactor M_PI / 180.0
#define kEarthRadius 6367444

@implementation PROUtils

+ (double)getAirDistancePointA:(CLLocationCoordinate2D)pointA pointB:(CLLocationCoordinate2D)pointB {
    if ((pointA.longitude == 0.0 && pointA.latitude == 0.0) || (pointB.longitude == 0.0 && pointB.latitude == 0.0)) {
        return -1;
    }
    
    // Convert degrees to radians
    const double pA_long_RAD = (pointA.longitude * kDeg2RadFactor);
    const double pA_lat_RAD = (pointA.latitude * kDeg2RadFactor);
    const double pB_long_RAD = (pointB.longitude * kDeg2RadFactor);
    const double pB_lat_RAD = (pointB.latitude * kDeg2RadFactor);
    
    /*
     * Side a and b are the angles from the pole to the latitude (=> 90 -
     * latitude). Gamma is the angle between the longitudes measured at the
     * pole. The missing side c can be calculated with the given sides a and
     * b and the angle gamma. Therefore the spherical law of cosines is
     * used.
     */
    const double cosb = cos(M_PI_2 - pA_lat_RAD);
    const double cosa = cos(M_PI_2 - pB_lat_RAD);
    const double cosGamma = cos(pB_long_RAD - pA_long_RAD);
    const double sina = sin(M_PI_2 - pA_lat_RAD);
    const double sinb = sin(M_PI_2 - pB_lat_RAD);
    
    /*
     * Law of cosines for the sides (Spherical trigonometry) cos(c) = cos(a)
     * * cos(b) + sin(a) * sin(b) * cos(Gamma)
     */
    double cosc = cosa * cosb + sina * sinb * cosGamma;
    
    // Limit the cosine from 0 to 180 degrees.
    if (cosc < -1) {
        cosc = -1;
    }
    if (cosc > 1) {
        cosc = 1;
    }
    
    // Calculate the angle in radians for the distance
    const double side_c = acos(cosc);
    
    // return the length in meter by multiplying the angle with
    // the standard sphere radius.
    const double result = MAX(0.0, kEarthRadius * side_c);
    
    return result;
}


@end
