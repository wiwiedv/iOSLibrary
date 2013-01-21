//
//  NewTonerPopOverControllerViewController.h
//  TestApplication
//
//  Created by Dominik Schiller on 20.01.13.
//  Copyright (c) 2013 WiWi-Edv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestHelper.h"

@interface NewTonerPopOverController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDataSource, RequestHelperDelegate>

@property (nonatomic) NSMutableDictionary* tonerObject;
@property (nonatomic) NSDictionary *colorNamesToInt;
@property (nonatomic) CGSize popOverOriginalSize;
@property (nonatomic) UITextField *selectedTextField;

@property (nonatomic) IBOutlet UIPickerView* colorPicker;
@property (nonatomic) IBOutlet UITableView* tonerTable;

- (IBAction)doneButtonPressed:(id)sender;

@end
