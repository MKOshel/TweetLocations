//
//  MapUtils.h
//  TwitterStreaming
//
//  Created by Oshel on 2/4/15.
//  Copyright (c) 2015 Oshel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "Tweet+Utils.h"

@interface MapUtils : NSObject
+(MKAnnotationView*)getAnnotationWithCoordinatesFromResponse:(NSArray*)response;
+(MKAnnotationView*)getAnnotationWithCoordinatesFromTweet:(Tweet*)tweet;

@end
