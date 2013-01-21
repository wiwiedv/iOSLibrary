//
//  DetailTableViewController.m
//  TestApplication
//
//  Created by Dominik Schiller on 18.01.13.
//  Copyright (c) 2013 WiWi-Edv. All rights reserved.
//

#import "DetailTableViewController.h"

@interface DetailTableViewController ()

@end

@implementation DetailTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
  }
  return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-YYYYY"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  // Return the number of sections.
  return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  // Return the number of rows in the section.
  return toner.transactions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"detailCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
  Transaction* ta = [transactionArray objectAtIndex:indexPath.row];
  NSDate* taDate = [NSDate dateWithTimeIntervalSince1970:ta.date.intValue];

  [cell.textLabel setText:[NSString stringWithFormat:@"Date: %@, Action: %@, User: %@, Reason: %@",  [dateFormatter stringFromDate:taDate], ta.action, ta.user, ta.reason]];
  
    return cell;
}

-(void)selectionChanged:(Toner *)selectedToner {
  toner = selectedToner;
  transactionArray = [[toner.transactions allObjects] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO]]];
  [detailTable reloadData];
  
  [[RequestHelper instance] setDelegate:self];
  [[RequestHelper instance] GETdataWithUrl:[NSString stringWithFormat:@"/api/tonerliste/toner/%@", toner.id]];
  
  [detailTable reloadData];
}

#pragma mark - Requesthelper delegate

-(void) GETSuccess:(RKObjectRequestOperation *)operation withResult:(RKMappingResult *)result {
  transactionArray = [[toner.transactions allObjects] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO]]];
  [detailTable reloadData];
}

- (void) GETFailure:(RKObjectRequestOperation *)operation withError:(NSError *)error {
  transactionArray = [[toner.transactions allObjects] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO]]];
  [detailTable reloadData];
}

- (void) PUTSuccess:(RKObjectRequestOperation *)operation withResult:(RKMappingResult *)result {
  
}

- (void) PUTFailure:(RKObjectRequestOperation *)operation withError:(NSError *)error {
  NSLog(@"Put fail");
}

- (void) POSTSuccess:(RKObjectRequestOperation *)operation withResult:(RKMappingResult *)result {
}

- (void) POSTFailure:(RKObjectRequestOperation *)operation withError:(NSError *)error {
  
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
