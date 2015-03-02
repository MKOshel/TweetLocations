//
//  ViewController.h
//  TwitterStreaming
//
//  Created by Oshel on 2/1/15.
//  Copyright (c) 2015 Oshel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OperationResultProtocol.h"
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController <OperationResultProtocol,MKMapViewDelegate>

@property(nonatomic,strong) MKMapView* mapV;

@end

