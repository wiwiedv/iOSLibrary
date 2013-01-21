//
//  NewTonerPopOverControllerViewController.m
//  TestApplication
//
//  Created by Dominik Schiller on 20.01.13.
//  Copyright (c) 2013 WiWi-Edv. All rights reserved.
//

#import "Toner.h"
#import "NewTonerPopOverController.h"
#import "DescriptionTextfieldCell.h"

#define NameTextFieldTag  90
#define ModelTextFieldTag 91
#define ColorTextFieldTag 92

@interface NewTonerPopOverController ()

@end

@implementation NewTonerPopOverController

@synthesize popOverOriginalSize, colorNamesToInt, selectedTextField, colorPicker, tonerObject;

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
    [colorPicker selectRow:0 inComponent:0 animated:YES];
    colorNamesToInt = @{  @"Schwarz" : [NSNumber numberWithInt:1],
                          @"Magenta" : [NSNumber numberWithInt:2],
                          @"Cyan" : [NSNumber numberWithInt:3],
                          @"Gelb" : [NSNumber numberWithInt:4],
                          @"Universal" : [NSNumber numberWithInt:5],
    };
    tonerObject = [[NSMutableDictionary alloc] init];
}

- (void)viewDidAppear:(BOOL)animated {
  popOverOriginalSize = self.contentSizeForViewInPopover;
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
  return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"descriptonTextFieldCell";
  DescriptionTextfieldCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
  
  switch (indexPath.row) {
    case 0:
      [cell.description setText:@"Name"];
      [cell.textField setTag:NameTextFieldTag];
      break;
    case 1:
      [cell.description setText:@"Druckermodell"];
      [cell.textField setTag:ModelTextFieldTag];
      break;
    case 2:
      [cell.description setText:@"Farbe"];
      [cell.textField setTag:ColorTextFieldTag];
      break;
    default:
      break;
  }
  
  [cell.textField setDelegate:self];
  
  return cell;
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

#pragma mark - buttons

- (IBAction)doneButtonPressed:(id)sender {
  
  Toner *tmpToner = [[RKManagedObjectStore defaultStore].mainQueueManagedObjectContext insertNewObjectForEntityForName:@"Toner"];
  [tmpToner setName:[tonerObject objectForKey:@"name"]];
  [tmpToner setPrinter:[tonerObject objectForKey:@"printer"]];
  [tmpToner setColor:[tonerObject objectForKey:@"color"]];
  
  NSLog(@"%@", tonerObject);
  [[RequestHelper instance] setDelegate:self];
  [[RequestHelper instance] POSTdataWithUrl:@"/api/tonerliste/toners" data:tmpToner];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark - Pickerview delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
  return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
  return [[colorNamesToInt allKeys] count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
  return [[colorNamesToInt allKeys] objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
  [selectedTextField setText:[[colorNamesToInt allKeys] objectAtIndex:row]];
  
  switch (selectedTextField.tag) {
    case ColorTextFieldTag:
      [tonerObject setObject:[colorNamesToInt objectForKey:selectedTextField.text] forKey:@"color"];
      break;
    default:
      break;
  }
  [self dismissColorPicker];
  
}

- (void) showColorPicker {
  [self.colorPicker setHidden:NO];
  [self setContentSizeForViewInPopover:CGSizeMake(self.popOverOriginalSize.width, self.popOverOriginalSize.height+240)];
}

- (void) dismissColorPicker {
  [self setContentSizeForViewInPopover:self.popOverOriginalSize];
  [self.colorPicker setHidden:YES];
}

#pragma mark - Textfield delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
  
  selectedTextField = textField;
  
  if (textField.tag == ColorTextFieldTag) {
    [self showColorPicker];
    [textField resignFirstResponder];
  }
  else {
    [self dismissColorPicker];
  }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
  switch (textField.tag) {
    case NameTextFieldTag:
      [tonerObject setObject:textField.text forKey:@"name"];
      break;
    case ModelTextFieldTag:
      [tonerObject setObject:textField.text forKey:@"printer"];
      break;
    default:
      break;
  }
}

#pragma mark - requesthelper delegate

- (void) GETSuccess:(RKObjectRequestOperation *)operation withResult:(RKMappingResult *)result {
  
}

- (void) GETFailure:(RKObjectRequestOperation *)operation withError:(NSError *)error {
  
}

- (void)POSTSuccess:(RKObjectRequestOperation *)operation withResult:(RKMappingResult *)result {
  
}

- (void)POSTFailure:(RKObjectRequestOperation *)operation withError:(NSError *)error {
  
}

- (void) PUTSuccess:(RKObjectRequestOperation *)operation withResult:(RKMappingResult *)result {
  
}

- (void) PUTFailure:(RKObjectRequestOperation *)operation withError:(NSError *)error {
  
}

@end
