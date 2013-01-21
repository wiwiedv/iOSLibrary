//
//  MappingHelper.h
//  TestApplication
//
//  Created by Dominik Schiller on 11.01.13.
//  Copyright (c) 2013 WiWi-Edv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Mapping : NSObject

@property (nonatomic, strong) NSDictionary *keyMapping;
@property (nonatomic, strong) NSArray *identificationAttributes;
@property (nonatomic, strong) NSString *mappingName;


- (id) initWithKeyMapping:(NSDictionary*)kM andMappingName:(NSString*)mn identificationAttributes:(NSArray*)ia;

@end

@interface MappingHelper : NSObject

{
  
}

+ (Mapping*)tonerMapping;
+ (Mapping*)transactionMapping;

@end
