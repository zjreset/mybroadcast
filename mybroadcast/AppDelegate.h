//
//  AppDelegate.h
//  mybroadcast
//
//  Created by runes on 12-12-5.
//  Copyright (c) 2012年 runes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IndexViewController.h"

@class Reachability;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    Reachability  *hostReach;
}
@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain) IndexViewController *indexViewController;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
