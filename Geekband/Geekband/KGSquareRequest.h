//
//  KGSquareRequest.h
//  Geekband
//
//  Created by sleepinge on 15/11/30.
//  Copyright © 2015年 sleepinge. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "KGSquareModel.h"

@class KGSquareRequest;

@protocol KGSquareRequestDelegate <NSObject>

- (void)squareRequestSuccess:(KGSquareRequest *)request dictionary:(NSDictionary *)dictionary;
- (void)squareRequestSuccess:(KGSquareRequest *)request squareModel:(KGSquareModel *)squareModel;
- (void)squareRequestFailed:(KGSquareRequest *)request error:(NSError *)error;

@end

@interface KGSquareRequest : NSObject<NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSURLConnection *urlConnection;
@property (nonatomic, strong) NSMutableData *receivedData;
@property (nonatomic, assign) id<KGSquareRequestDelegate> delegate;

- (void)sendSquareRequestWithParamter:(NSDictionary *)paramDic delegate:(id<KGSquareRequestDelegate>)delegate;

@end
