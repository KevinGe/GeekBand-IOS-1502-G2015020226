//
//  KGEditImageRequest.h
//  Geekband
//
//  Created by sleepinge on 15/11/30.
//  Copyright © 2015年 sleepinge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class KGEditImageRequest;

@protocol KGEditImageRequestDelegate<NSObject>

- (void)editImageRequestSuccess:(KGEditImageRequest *)request;
- (void)editImageRequestFailed:(KGEditImageRequest *)request error:(NSError *)error;

@end

@interface KGEditImageRequest : NSObject<NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSURLConnection *urlConnection;
@property (nonatomic, strong) NSMutableData *receivedData;
@property (nonatomic, strong) id<KGEditImageRequestDelegate> delegate;

- (void)sendEditImageRequest:(UIImage *)image delegate:(id<KGEditImageRequestDelegate>)delegate;

@end

