//
//  Tweet.h
//  TwitterStreaming
//
//  Created by dragos on 2/4/15.
//  Copyright (c) 2015 Oshel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Tweet : NSManagedObject

@property (nonatomic, retain) NSNumber * tweetLatitude;
@property (nonatomic, retain) NSNumber * tweetLongitude;
@property (nonatomic, retain) NSString * tweetOwner; // this is not used , it's declared just in case 

@end
