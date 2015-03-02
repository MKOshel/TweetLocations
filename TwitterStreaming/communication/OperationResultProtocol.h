//
//  OperationResultProtocol.h
//  TwitterStreaming
//
//  Created by Oshel on 2/4/15.
//  Copyright (c) 2015 Oshel. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OperationResultProtocol <NSObject>
@required
-(void)didGetDataFromTwitterFeed:(NSArray*)response;
@optional
-(void)didFailWithError:(NSString*)description;
@end
