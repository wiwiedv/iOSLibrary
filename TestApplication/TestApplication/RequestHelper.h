//
//  RequestHelper.h
//  TestApplication
//
//  Created by Dominik Schiller on 11.01.13.
//  Copyright (c) 2013 WiWi-Edv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MappingHelper.h"
#import <RestKit/RestKit.h>

@protocol RequestHelperDelegate <NSObject>

@required

- (void) GETSuccess:(RKObjectRequestOperation*)operation withResult:(RKMappingResult*) result;

- (void) GETFailure:(RKObjectRequestOperation*) operation withError:(NSError*) error;

- (void) POSTSuccess:(RKObjectRequestOperation*)operation withResult:(RKMappingResult*) result;

- (void) POSTFailure:(RKObjectRequestOperation*) operation withError:(NSError*) error;

- (void) PUTSuccess:(RKObjectRequestOperation*)operation withResult:(RKMappingResult*) result;

- (void) PUTFailure:(RKObjectRequestOperation*) operation withError:(NSError*) error;

@end

@interface RequestHelper : NSObject

{
  id <RequestHelperDelegate> delegate;
}

@property (retain) id delegate;

+ (RequestHelper*) instance;
- (void)   GETdataWithUrl:(NSString*)url;
- (void)   POSTdataWithUrl:(NSString*)urlPath data:(id)data;
- (void)   PUTdataWithUrl:(NSString*)urlPath data:(id)data;

@end
