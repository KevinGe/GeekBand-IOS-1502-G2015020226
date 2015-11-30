//
//  KGViewDetailRequest.h
//  Geekband
//
//  Created by sleepinge on 15/11/30.
//  Copyright © 2015年 sleepinge. All rights reserved.
//


#import <Foundation/Foundation.h>

@class KGViewDetailRequest;

@protocol KGViewDetailRequestDelegate <NSObject>

- (void)viewDetailRequestSuccess:(KGViewDetailRequest *)request data:(NSArray *)data;
- (void)viewDetailRequestFailed:(KGViewDetailRequest *)request error:(NSError *)error;

@end

@interface KGViewDetailRequest : NSObject <NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSURLConnection *urlConnection;
@property (nonatomic, strong) NSMutableData *receivedData;
@property (nonatomic, assign) id<KGViewDetailRequestDelegate> delegate;

- (void)sendViewDetailRequest:(NSDictionary *)paramDic delegate:(id<KGViewDetailRequestDelegate>) delegate;

@end
