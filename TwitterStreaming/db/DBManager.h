//
//  DBManager.h
//  Aviro
//
//  Created by dragos on 1/13/15.
//  Copyright (c) 2015 Mobile Kinetics. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DBManager : NSObject
@property ( strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property ( strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property ( strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

-(BOOL)saveData;
+(DBManager*)sharedDBmanager;
@end
