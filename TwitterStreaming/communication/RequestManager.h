//
//  RequestManager.h
//  TwitterStreaming
//
//  Created by Oshel on 2/2/15.
//  Copyright (c) 2015 Oshel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OperationResultProtocol.h"
#import "STTwitter.h"

@interface RequestManager : NSObject 

-(id)getTwitterPublicFeed;
+(RequestManager*)sharedManager;

@property (nonatomic,strong) STTwitterAPI* twitter;
@property id <OperationResultProtocol> delegate;

@end
