//
//  KGRegisterRequest.h
//  Geekband
//
//  Created by sleepinge on 15/11/30.
//  Copyright © 2015年 sleepinge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KGUserModel.h"

@class KGRegisterRequest;

@protocol KGRegisterRequestDeleage <NSObject>

- (void)registerRequestSuccess:(KGRegisterRequest *)request user:(KGUserModel *)user;
- (void)registerRequestFailed:(KGRegisterRequest *)request error:(NSError *)error;

@end

@interface KGRegisterRequest: NSObject<NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSURLConnection *urlConnection;
@property (nonatomic, strong) NSMutableData *receivedData;
@property (nonatomic, strong) id<KGRegisterRequestDeleage> delegate;

- (void)sendRegisterRequestWithUserName:(NSString *)userName email:(NSString *)email password:(NSString *)password gbid:(NSString *)gbid delegate:(id<KGRegisterRequestDeleage>)delegate;

@end
