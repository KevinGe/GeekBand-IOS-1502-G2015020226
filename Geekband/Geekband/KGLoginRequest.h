//
//  KGLoginRequest.h
//  Geekband
//
//  Created by sleepinge on 15/11/30.
//  Copyright © 2015年 sleepinge. All rights reserved.
//

@class KGLoginRequest;

#import "KGUserModel.h"
#import <Foundation/Foundation.h>

@protocol KGLoginRequestDelegate <NSObject>

- (void)loginRequestSuccess:(KGLoginRequest *)request user:(KGUserModel *)user;
- (void)loginRequestFailed:(KGLoginRequest *)request error:(NSError *)error;

@end

@interface KGLoginRequest : NSObject<NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSURLConnection *urlConnection;
@property (nonatomic, strong) NSMutableData *receivedData;
@property (nonatomic, assign) id<KGLoginRequestDelegate> delegate;

- (void)sendLoginRequestWithEmail:(NSString *)email
                         password:(NSString *)password
                             gbid:(NSString *)gbid
                         delegate:(id<KGLoginRequestDelegate>)delegate;

@end
