//
//  MappingHelper.m
//  TestApplication
//
//  Created by Dominik Schiller on 11.01.13.
//  Copyright (c) 2013 WiWi-Edv. All rights reserved.
//

#import "MappingHelper.h"



@implementation Mapping

@synthesize keyMapping, mappingName, identificationAttributes;

- (id) initWithKeyMapping:(NSDictionary*)kM andMappingName:(NSString*)mn identificationAttributes:(NSArray*)ia{
  if (self = [super init]) {
    keyMapping = kM;
    mappingName = mn;
    identificationAttributes = ia;
  }
  return self;
}

@end


@implementation MappingHelper
//static Mapping* tonerObjectMapping;
+ (Mapping *)tonerMapping { return  [[Mapping alloc] initWithKeyMapping: @{
                                     @"id" : @"id",
                                     @"name" : @"name",
                                     @"type" : @"type",
                                     @"color" : @"color",
                                     @"printer" : @"printer",
                                     @"stock" : @"stock",
                                     @"hidden" : @"hidden"
                                     }
                                               andMappingName:@"" identificationAttributes:@[@"id"]]; }

//static Mapping* transactionMapping;
+ (Mapping *)transactionMapping { return [[Mapping alloc] initWithKeyMapping:@{
                                          @"date" : @"date",
                                          @"id" : @"id",
                                          @"user" : @"user",
                                          @"reason" : @"reason",
                                          @"item" : @"item",
                                          @"action" : @"action"
                                          }
                                          andMappingName:@"transactions" identificationAttributes:@[@"id"]]; }

@end

