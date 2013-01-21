//
//  Toner.h
//  TestApplication
//
//  Created by Dominik Schiller on 18.01.13.
//  Copyright (c) 2013 WiWi-Edv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Transaction;

@interface Toner : NSManagedObject

@property (nonatomic, retain) NSNumber * color;
@property (nonatomic, retain) NSNumber * hidden;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * printer;
@property (nonatomic, retain) NSNumber * stock;
@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) NSSet *transactions;
@end

@interface Toner (CoreDataGeneratedAccessors)

- (void)addTransactionsObject:(Transaction *)value;
- (void)removeTransactionsObject:(Transaction *)value;
- (void)addTransactions:(NSSet *)values;
- (void)removeTransactions:(NSSet *)values;

@end
