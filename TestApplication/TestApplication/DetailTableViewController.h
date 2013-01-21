//
//  DetailTableViewController.h
//  TestApplication
//
//  Created by Dominik Schiller on 18.01.13.
//  Copyright (c) 2013 WiWi-Edv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootTableViewController.h"
#import "Toner.h"
#import "Transaction.h"

@interface DetailTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, RootTableViewDelegate>

{
  IBOutlet UITableView* detailTable;
  Toner* toner;
  NSDateFormatter *dateFormatter;
  NSArray *transactionArray;
}

@end
