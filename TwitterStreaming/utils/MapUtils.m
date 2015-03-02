//
//  MapUtils.m
//  TwitterStreaming
//
//  Created by Oshel on 2/4/15.
//  Copyright (c) 2015 Oshel. All rights reserved.
//

#import "MapUtils.h"

@implementation MapUtils

+(MKAnnotationView*)getAnnotationWithCoordinatesFromResponse:(NSArray*)response
{
    if ([response isKindOfClass:[NSNull class]]) {
        return nil;
    }
    if (response.count == 0) {
        return nil;
    }
    
//    NSData* coordinatesData = [response dataUsingEncoding:NSUTF8StringEncoding];
//    NSError* error;
//    NSDictionary* coordinates = [NSJSONSerialization JSONObjectWithData:coordinatesData options:NSJSONReadingMutableContainers error:&error];
    
    NSNumber *latitude = [response firstObject];
    NSNumber* longitude = response[1];
    
    CLLocationCoordinate2D tweetCoordinate;
    tweetCoordinate.latitude = longitude.doubleValue;
    tweetCoordinate.longitude = latitude.doubleValue;
    
    MKPointAnnotation* point = [[MKPointAnnotation alloc]init];
    point.coordinate = tweetCoordinate;
    
    MKAnnotationView* view = [[MKAnnotationView alloc]initWithAnnotation:point reuseIdentifier:@"pin"];
    
    return view;
    
}

+(MKAnnotationView*)getAnnotationWithCoordinatesFromTweet:(Tweet*)tweet
{
    CLLocationCoordinate2D tweetCoordinate;
    tweetCoordinate.latitude = tweet.tweetLongitude.doubleValue;
    tweetCoordinate.longitude = tweet.tweetLatitude.doubleValue;
    
    MKPointAnnotation* point = [[MKPointAnnotation alloc]init];
    point.coordinate = tweetCoordinate;
    
    MKAnnotationView* view = [[MKAnnotationView alloc]initWithAnnotation:point reuseIdentifier:@"pin"];
    
    return view;
}


@end
