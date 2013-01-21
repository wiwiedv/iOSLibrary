//
//  testViewController.m
//  TestApplication
//
//  Created by Dominik Schiller on 06.01.13.
//  Copyright (c) 2013 WiWi-Edv. All rights reserved.
//

#define APPDELEGATE ((TestAppDelegate*)[[UIApplication sharedApplication] delegate])
#import "TestAppDelegate.h"
#import "RootTableViewController.h"
#import "DetailTableViewController.h"
#import "Toner.h"
#import "DDBadgeViewCell.h"

@interface RootTableViewController ()

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation RootTableViewController

@synthesize dataArray;

- (void)viewDidLoad
{
  
  id tmpDel = [self.splitViewController.viewControllers lastObject];
  if([tmpDel class] != [DetailTableViewController class] || tmpDel == nil) {
    NSLog(@"Unable to set RootTableViewController.delegate");
  }
  else delegate = tmpDel;
  
  
  UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
  [refreshControl addTarget:self action:@selector(loadArticles)
           forControlEvents:UIControlEventValueChanged];
  self.refreshControl = refreshControl;
  [super viewDidLoad];
  [self loadArticles];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [dataArray count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  
  return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  switch (section) {
    case 0:
      return @"Toner";
      break;
    case 1:
      return @"Trommeln";
      break;
    default:
      return @"";
      break;
  }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if (delegate != nil) {
    Toner *t = [dataArray objectAtIndex:indexPath.row];
    [delegate selectionChanged:t];
  }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *simpleTableIdentifier = @"tonerCell";
  
  DDBadgeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
  
  if (cell == nil) {
    cell = [[DDBadgeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  }
  
  if (indexPath.section == 0) {
    Toner* toner = [dataArray objectAtIndex:indexPath.row];
    cell.summary = [toner name];
    if (toner.stock.intValue < 2) {
      [cell setBadgeColor:[UIColor colorWithRed:0.99 green:0.08 blue:0.34 alpha:0.5]];
    }
    else if (toner.stock.intValue < 4) {
      [cell setBadgeColor:[UIColor colorWithRed:0.93 green:0.93 blue:0 alpha:0.5]];
    }
    else {
      [cell setBadgeColor:[UIColor colorWithRed:0 green:0.79 blue:0.34 alpha:0.5]];
      
    }
    
    [cell setBadgeText:[NSString stringWithFormat:@"%@",[toner stock]]];
  }

  return cell;
}

#pragma mark - connection

- (void)loadArticles
{
  [[RequestHelper instance] setDelegate:self];
  [[RequestHelper instance] GETdataWithUrl:@"/api/tonerliste/"];
}

#pragma mark - requestHelper Delegate

-(void) GETSuccess:(RKObjectRequestOperation *)operation withResult:(RKMappingResult *)result {
  
  NSFetchRequest *getToner = [NSFetchRequest fetchRequestWithEntityName:@"Toner"];
  dataArray = [[RKManagedObjectStore defaultStore].mainQueueManagedObjectContext executeFetchRequest:getToner error:nil];
  [myTV reloadData];
  if ([self.refreshControl isRefreshing]) {
    [self.refreshControl endRefreshing];
  }
}

- (void) GETFailure:(RKObjectRequestOperation *)operation withError:(NSError *)error {
  NSLog(@"Error");
}

- (void) PUTSuccess:(RKObjectRequestOperation *)operation withResult:(RKMappingResult *)result {
  NSFetchRequest *getToner = [NSFetchRequest fetchRequestWithEntityName:@"Toner"];
  dataArray = [[RKManagedObjectStore defaultStore].mainQueueManagedObjectContext executeFetchRequest:getToner error:nil];
  [myTV reloadData];
}

- (void) PUTFailure:(RKObjectRequestOperation *)operation withError:(NSError *)error {
  NSLog(@"Put fail");
}

- (void) POSTSuccess:(RKObjectRequestOperation *)operation withResult:(RKMappingResult *)result {
  NSFetchRequest *getToner = [NSFetchRequest fetchRequestWithEntityName:@"Toner"];
  dataArray = [[RKManagedObjectStore defaultStore].mainQueueManagedObjectContext executeFetchRequest:getToner error:nil];
  [myTV reloadData];
}

- (void) POSTFailure:(RKObjectRequestOperation *)operation withError:(NSError *)error {
  
}

@end
