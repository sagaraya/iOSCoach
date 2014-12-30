//
//  InstagramAPIClient.h
//  InstagramSample
//
//  Created by Keisei SHIGETA on 2014/12/28.
//  Copyright (c) 2014年 Keisei SHIGETA. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "PhotoCollectionViewController.h"

typedef void (^completeBlock_t)(NSArray *data);

@interface InstagramAPIClient : AFHTTPSessionManager

+ (instancetype)sharedClient;
- (void)invokeOAuth;
- (BOOL)hasAuthenticated;
- (void)getMyPhotoListWithCompleteBlock:(completeBlock_t)cBlock;

@end
