//
//  KGPublishRequest.m
//  Geekband
//
//  Created by sleepinge on 15/11/30.
//  Copyright © 2015年 sleepinge. All rights reserved.
//

#import "KGPublishRequest.h"
#import "BLMultipartForm.h"
#import "KGPublishRequestParser.h"
#import "KGPublishModel.h"

@implementation KGPublishRequest

- (void)sendPublishRequestWithUserId:(NSString *)userId
                               token:(NSString *)token
                           longitude:(NSString *)longitude
                            latitude:(NSString *)latitude
                               title:(NSString *)title
                                data:(NSData *)data
                            location:(NSString *)location
                            delegate:(id<KGPublishRequestDelegate>)delegate {
    [self.urlConnection cancel];
    self.delegate = delegate;
    
    NSString *urlString = @"http://moran.chinacloudapp.cn/moran/web/picture/create";
    NSString *encodedURLString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:encodedURLString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    request.HTTPMethod = @"POST";
    request.timeoutInterval = 60;
    request.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    
    BLMultipartForm *form = [[BLMultipartForm alloc]init];
    [form addValue:token forField:@"token"];
    [form addValue:userId forField:@"user_id"];
    [form addValue:data forField:@"data"];
    [form addValue:title forField:@"title"];
    [form addValue:location forField:@"location"];
    [form addValue:longitude forField:@"longitude"];
    [form addValue:latitude forField:@"latitude"];
    [form addValue:location forField:@"addr"];
    
    request.HTTPBody = [form httpBody];
    [request setValue:form.contentType forHTTPHeaderField:@"Content-Type"];
    self.urlConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if (httpResponse.statusCode == 200) {
        self.receivedData = [NSMutableData data];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    if ([_delegate respondsToSelector:@selector(requestSuccess:picId:)]) {
        KGPublishRequestParser *parser = [[KGPublishRequestParser alloc]init];
        KGPublishModel *model = [parser parseJson:self.receivedData];
        [_delegate requestSuccess:self picId:model.picId];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    if ([_delegate respondsToSelector:@selector(requestFailed:error:)]) {
        [_delegate requestFailed:self error:error];
    }
}

@end

