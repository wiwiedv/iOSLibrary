//
//  testViewController.h
//  TestApplication
//
//  Created by Dominik Schiller on 06.01.13.
//  Copyright (c) 2013 WiWi-Edv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestHelper.h"
#import "Toner.h"

@protocol RootTableViewDelegate <NSObject>

@required

- (void)selectionChanged:(Toner*)selectedToner;

@end

@interface RootTableViewController : UITableViewController <RequestHelperDelegate>

{
  IBOutlet UITableView *myTV;
  id <RootTableViewDelegate> delegate;
}


@end
