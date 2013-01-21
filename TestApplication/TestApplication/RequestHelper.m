//
//  RequestHelper.m
//  TestApplication
//
//  Created by Dominik Schiller on 11.01.13.
//  Copyright (c) 2013 WiWi-Edv. All rights reserved.
//

#define APPDELEGATE ((TestAppDelegate*)[[UIApplication sharedApplication] delegate])

#import "RequestHelper.h"
#import <RestKit/RestKit.h>
#import "TestAppDelegate.h"

@implementation RequestHelper

@synthesize delegate;

#pragma mark - Singleton stuff

+(id)instance
{
  static dispatch_once_t pred;
  static RequestHelper *instance = nil;
  dispatch_once(&pred, ^{
    instance = [[RequestHelper alloc] init];
  });
  return instance;
}

- (void)dealloc
{
  abort();
}

#pragma mark - Requests

- (void)  GETdataWithUrl:(NSString*)urlPath {

  [[RKObjectManager sharedManager] getObjectsAtPath:urlPath parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
    RKLogInfo(@"Load complete: Table should refresh...");
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"LastUpdatedAt"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[self delegate] GETSuccess:operation withResult:mappingResult];
  } failure:^(RKObjectRequestOperation *operation, NSError *error) {
    RKLogError(@"Load failed with error: %@", error);
    [[self delegate] GETFailure:operation withError:error];
  }];

}

- (void) POSTdataWithUrl:(NSString*)urlPath data:(id)data {
  
  [[RKObjectManager sharedManager] postObject:data path:urlPath parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
    RKLogInfo(@"Load complete: Table should refresh...");
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"LastUpdatedAt"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[self delegate] POSTSuccess:operation withResult:mappingResult];
  } failure:^(RKObjectRequestOperation *operation, NSError *error) {
    RKLogError(@"Load failed with error: %@", error);
    [[self delegate] POSTFailure:operation withError:error];
  }];

}

- (void) PUTdataWithUrl:(NSString*)urlPath data:(id)data {
  
  [[RKObjectManager sharedManager] putObject:data path:urlPath parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
    RKLogInfo(@"Load complete: Table should refresh...");
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"LastUpdatedAt"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[self delegate] PUTSuccess:operation withResult:mappingResult];
  } failure:^(RKObjectRequestOperation *operation, NSError *error) {
    RKLogError(@"Load failed with error: %@", error);
    [[self delegate] PUTFailure:operation withError:error];
  }];
}

@end
