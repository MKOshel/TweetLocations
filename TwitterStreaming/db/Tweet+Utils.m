//
//  Tweet+Utils.m
//  TwitterStreaming
//
//  Created by dragos on 2/4/15.
//  Copyright (c) 2015 Oshel. All rights reserved.
//

#import "Tweet+Utils.h"
#import "DBManager.h"

@implementation Tweet (Utils)

+(Tweet*)insertNewTweetFromResponse:(NSArray*)response
{
    if ([response isKindOfClass:[NSNull class]]) {
        return nil;
    }
    if (response.count == 0) {
        return nil;
    }
    
    NSManagedObjectContext* context = [DBManager sharedDBmanager].managedObjectContext;
    
    Tweet* t = [NSEntityDescription insertNewObjectForEntityForName:@"Tweet" inManagedObjectContext:context];
    t.tweetLatitude = response[0];
    t.tweetLongitude = response[1];
    

    return t;
}


+(NSArray*)getAllTweets
{
    NSManagedObjectContext* context = [DBManager sharedDBmanager].managedObjectContext;
    
    NSFetchRequest* request = [[NSFetchRequest alloc]init];
    [request setEntity:[NSEntityDescription entityForName:@"Tweet" inManagedObjectContext:context]];
    
    NSError* e;
    NSArray* tweets = [context executeFetchRequest:request error:&e];
    
    if (tweets == nil || tweets.count == 0) {
        return nil;
    }
    
    return tweets;
}


+(void)deleteAllTweets
{
    NSManagedObjectContext* context = [DBManager sharedDBmanager].managedObjectContext;
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Tweet" inManagedObjectContext:context]];
    [request setIncludesPropertyValues:NO]; //get only the id of the tweet
    
    NSError * error;
    NSArray * tweets = [context executeFetchRequest:request error:&error];
    //error handling goes here
    for (NSManagedObject * t in tweets) {
        [context deleteObject:t];
    }
    
    [context save:&error];
}

+(BOOL)coreDataHasEntriesForEntityName:(NSString *)entityName {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSManagedObjectContext* context = [DBManager sharedDBmanager].managedObjectContext;
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
    
    [request setEntity:entity];
    [request setFetchLimit:1000];
    
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    if (!results) {
        NSLog(@"Fetch error: %@", error);
        abort();
    }
    if ([results count] == 0) {
        return NO;
    }
    
    NSLog(@"TWEET COUNT === %d",results.count);
    
    return YES;
}


@end
