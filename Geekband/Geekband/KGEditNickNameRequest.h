//
//  KGEditNickNameRequest.h
//  Geekband
//
//  Created by sleepinge on 15/11/30.
//  Copyright © 2015年 sleepinge. All rights reserved.
//

#import <Foundation/Foundation.h>
@class KGEditNickNameRequest;

@protocol KGEditNickNameRequestDelegate <NSObject>

- (void)editNickNameRequestSuccess:(KGEditNickNameRequest *)request;
- (void)editNickNameRequestFailed:(KGEditNickNameRequest *)request error:(NSError *)error;

@end

@interface KGEditNickNameRequest : NSObject<NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSURLConnection *urlConnection;
@property (nonatomic, strong) NSMutableData *receivedData;
@property (nonatomic, strong) id<KGEditNickNameRequestDelegate> delegate;

- (void)sendEditNickNameRequest:(NSString *)nickName delegate:(id<KGEditNickNameRequestDelegate>)delegate;

@end

