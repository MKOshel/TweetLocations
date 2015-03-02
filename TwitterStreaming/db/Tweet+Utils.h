//
//  Tweet+Utils.h
//  TwitterStreaming
//
//  Created by dragos on 2/4/15.
//  Copyright (c) 2015 Oshel. All rights reserved.
//

#import "Tweet.h"

//category on tweet , helper interface
@interface Tweet (Utils)

+(Tweet*)insertNewTweetFromResponse:(NSArray*)response;
+(NSArray*)getAllTweets;
+(BOOL)coreDataHasEntriesForEntityName:(NSString *)entityName;
+(void)deleteAllTweets;

@end
