//
//  RequestManager.m
//  TwitterStreaming
//
//  Created by Oshel on 2/2/15.
//  Copyright (c) 2015 Oshel. All rights reserved.
//

#import "RequestManager.h"
#import "STTwitter.h"


@implementation RequestManager




//singleton
+(RequestManager*)sharedManager
{
    static dispatch_once_t once;
    static id manager;
    dispatch_once(&once, ^{
        manager = [[self alloc] init];
    });
    
    return manager;
}

-(id)getTwitterPublicFeed
{
    
    if (_twitter == nil) {
        _twitter = [STTwitterAPI twitterAPIWithOAuthConsumerKey:@"foPuzzIczwdQ3OoDBfrYg4Ngv"
                                                              consumerSecret:@"4NTX3naXyuMdBNnlL5VXp5EZwijjhgHYekbHdxTdiMvivgdZNw"
                                                                  oauthToken:@"2687239574-Q5FlCwWO1MfouOC8MzhboA7wPdJL1Ulv9q16RSB" oauthTokenSecret:@"mR2lwKIpyLEVTlSmJfZM8TCCBabKDdEpPSWHXDM5jwHcY"];
    }
    
    
 id request =  [_twitter postStatusesFilterUserIDs:nil
                       keywordsToTrack:@[@"me"]
                 locationBoundingBoxes:nil
                             delimited:nil
                         stallWarnings:nil
                         progressBlock:^(id response) {
                             
                             if ([response isKindOfClass:[NSDictionary class]] == NO) {
                                 NSLog(@"Invalid tweet (class %@): %@", [response class], response);
                                 return;
                             }
                             
                             printf("Processing...-----------------------------------------------------------------\n");

                            NSString* jsonResponse = [response valueForKey:@"coordinates"];
                            //NSLog(@"JSON RESPONSE CLASS ============ %@",[jsonResponse class]);
                             NSLog(@"JSON RESPONSE ===== %@",[jsonResponse valueForKey:@"coordinates"] );

                             [_delegate didGetDataFromTwitterFeed:[jsonResponse valueForKey:@"coordinates"]];
                                //to get the coordinates represented by an array
                             
                         } stallWarningBlock:nil errorBlock:^(NSError *error) {
                             NSLog(@"Stream error: %@", error.description);
                             [_delegate didFailWithError:error.description];
                        
                         }];
    
    return request;
        
}




@end
