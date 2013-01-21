//
//  testAppDelegate.h
//  TestApplication
//
//  Created by Dominik Schiller on 06.01.13.
//  Copyright (c) 2013 WiWi-Edv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootTableViewController.h"
#import "DetailTableViewController.h"

@interface TestAppDelegate : UIResponder <UIApplicationDelegate>
{
  UISplitViewController *_splitViewController;
  RootTableViewController*_rootTableViewController;
  DetailTableViewController *_detailTableviewController;
}


@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, retain) IBOutlet UISplitViewController *splitViewController;
@property (nonatomic, retain) IBOutlet RootTableViewController *rootTableViewController;
@property (nonatomic, retain) IBOutlet DetailTableViewController *detailTableviewController;
@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end
