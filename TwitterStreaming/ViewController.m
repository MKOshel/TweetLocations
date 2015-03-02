//
//  ViewController.m
//  TwitterStreaming
//
//  Created by Oshel on 2/1/15.
//  Copyright (c) 2015 Oshel. All rights reserved.
//

#import "ViewController.h"
#import "RequestManager.h"
#import "MapUtils.h"
#import "Tweet+Utils.h"
#import "DBManager.h"

// in minutes
#define lifespanInterval 1

@interface ViewController ()
{
    RequestManager* manager;
    id request;
    //in order to cancel streaming
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupMapView];

    manager = [RequestManager sharedManager];
    manager.delegate = self;
    
    // Do any additional setup after loading the view, typically from a nib.
}



-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self getFeed];
    
    [self performSelector:@selector(removeLocations) withObject:nil afterDelay:lifespanInterval*60];
}

// init map view
-(void)setupMapView
{
    _mapV = [[MKMapView alloc]initWithFrame:self.view.frame];
    _mapV.delegate = self;
    [self.view addSubview:_mapV];
}


-(void)getFeed
{
   request = [manager getTwitterPublicFeed];
}

-(void)didGetDataFromTwitterFeed:(NSArray*)response
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //background process
    dispatch_queue_t main = dispatch_get_main_queue();
    //main process
    
    dispatch_async(queue,
                   ^{
                       MKAnnotationView* annotationView=  [MapUtils getAnnotationWithCoordinatesFromResponse:response];
                       
                       dispatch_async(main,
                                      ^{
                           [Tweet insertNewTweetFromResponse:response];
                           [[DBManager sharedDBmanager] saveData];

                           [_mapV addAnnotation:annotationView.annotation];
                       });
                   });

}

//called when no internet is available or an error has occurred when twitter api is called
-(void)didFailWithError:(NSString *)description
{
   [self placePinsFromLastSession];
}



-(void)placePinsFromLastSession
{
    NSArray* tweets = [Tweet getAllTweets];
    if (tweets == nil) {
        return;
    }
    for (Tweet* t in tweets) {
       MKAnnotationView* annView = [MapUtils getAnnotationWithCoordinatesFromTweet:t];
        [_mapV addAnnotation:annView.annotation];
        
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    //we must reuse the annotation to keep the memory as low as possible, same as with table view cells for example
        MKAnnotationView* pinView = (MKAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"pin"];

        return pinView;
}


-(void)removeLocations
{
 
    if ([Tweet coreDataHasEntriesForEntityName:@"Tweet"]) {
        [_mapV removeAnnotations:_mapV.annotations];
        [Tweet deleteAllTweets];
        
        UIAlertView* av = [[UIAlertView alloc]initWithTitle:nil message:@"Session has expired, please start over" delegate:nil cancelButtonTitle:@"Ok"  otherButtonTitles:nil, nil];
        [av show];
        [request cancel];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
