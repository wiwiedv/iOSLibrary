//
//  Transaction.h
//  TestApplication
//
//  Created by Dominik Schiller on 18.01.13.
//  Copyright (c) 2013 WiWi-Edv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Toner;

@interface Transaction : NSManagedObject

@property (nonatomic, retain) NSNumber * action;
@property (nonatomic, retain) NSNumber * date;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSNumber * item;
@property (nonatomic, retain) NSString * reason;
@property (nonatomic, retain) NSString * user;
@property (nonatomic, retain) Toner *toner;

@end
