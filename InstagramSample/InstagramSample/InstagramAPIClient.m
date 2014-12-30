//
//  InstagramAPIClient.m
//  InstagramSample
//
//  Created by Keisei SHIGETA on 2014/12/28.
//  Copyright (c) 2014年 Keisei SHIGETA. All rights reserved.
//

#import "InstagramAPIClient.h"
#import <SimpleAuth.h>

@interface InstagramAPIClient()
@property (nonatomic) NSString *accessToken;
@property (nonatomic) NSString *userId;
@end


@implementation InstagramAPIClient

static NSString *const kOauthClientId = @"2c66e10662664af681be6b8ca56c4221"; //InstagramAPIのクライアントID
static NSString *const kOauthRedirectUrl = @"http://instagram.local/callback";

+ (instancetype)sharedClient
{
    //シングルトン
    //詳しくは http://www.toyship.org/archives/1770
    static InstagramAPIClient *client;
    static dispatch_once_t once;
    dispatch_once( &once, ^{
        client = [[super manager] init];
        //client.requestSerializer = [AFHTTPRequestSerializer serializer];
        //[client.requestSerializer setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
        //[client.requestSerializer setValue:[Util userAgent] forHTTPHeaderField:@"User-Agent"];
        [client initOAuthSetting];
    });
    return client;
}

# pragma mark - private method
- (void)initOAuthSetting
{
    SimpleAuth.configuration[@"instagram"] = @{ @"client_id": kOauthClientId,
                                                SimpleAuthRedirectURIKey: kOauthRedirectUrl };
}


# pragma mark - public method
- (void)invokeOAuth
{
    [SimpleAuth authorize:@"instagram" completion:^(id responseObject, NSError *error) {
        if (!error) {
            self.accessToken = [responseObject valueForKeyPath:@"credentials.token"];
            self.userId = [responseObject valueForKey:@"uid"];
        }
    }];
}

- (BOOL)hasAuthenticated
{
    return _accessToken.length > 0 ? YES : NO;
}


- (void)getMyPhotoListWithCompleteBlock:(completeBlock_t)cBlock
{
    NSDictionary *params = @{@"access_token":_accessToken};
    NSString *url = [NSString stringWithFormat:@"https://api.instagram.com/v1/users/%@/media/recent", _userId];

    [self GET:url
   parameters:params
      success:^(NSURLSessionDataTask *task, id responseObject) {
          //AFNetworkingが勝手にJSON形式のレスポンスをパースしてくれる
          NSLog(@"responseObject: %@", responseObject);
          NSArray *data = responseObject[@"data"];
          cBlock(data);
   }
      failure:^(NSURLSessionDataTask *task, NSError *error) {
          NSLog(@"Error: %@", error);
          cBlock(nil);
      }];
}

@end
