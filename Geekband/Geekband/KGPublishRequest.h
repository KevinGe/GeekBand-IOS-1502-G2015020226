//
//  KGPublishRequest.h
//  Geekband
//
//  Created by sleepinge on 15/11/30.
//  Copyright © 2015年 sleepinge. All rights reserved.
//


#import <Foundation/Foundation.h>

@class KGPublishRequest;

@protocol KGPublishRequestDelegate <NSObject>

- (void)requestSuccess:(KGPublishRequest *)request picId:(NSString *)picId;
- (void)requestFailed:(KGPublishRequest *)request error:(NSError *)error;

@end

@interface KGPublishRequest : NSObject <NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSURLConnection *urlConnection;
@property (nonatomic, strong) NSMutableData *receivedData;
@property (nonatomic, assign) id<KGPublishRequestDelegate> delegate;

- (void)sendPublishRequestWithUserId:(NSString *)userId
                               token:(NSString *)token
                           longitude:(NSString *)longitude
                            latitude:(NSString *)latitude
                               title:(NSString *)title
                                data:(NSData *)data
                            location:(NSString *)location
                            delegate:(id<KGPublishRequestDelegate>)delegate;

@end

