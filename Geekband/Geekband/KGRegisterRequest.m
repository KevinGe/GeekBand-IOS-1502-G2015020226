//
//  KGRegisterRequest.m
//  Geekband
//
//  Created by sleepinge on 15/11/30.
//  Copyright © 2015年 sleepinge. All rights reserved.
//


#import "KGRegisterRequest.h"
#import "BLMultipartForm.h"
#import "KGRegisterRequestParser.h"

@implementation KGRegisterRequest

- (void)sendRegisterRequestWithUserName:(NSString *)userName
                                  email:(NSString *)email
                               password:(NSString *)password
                                   gbid:(NSString *)gbid
                               delegate:(id<KGRegisterRequestDeleage>)delegate {
    [self.urlConnection cancel];
    
    self.delegate = delegate;
    NSString *urlString = @"http://moran.chinacloudapp.cn/moran/web/user/register";
    NSString *encodeString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:encodeString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    request.HTTPMethod = @"POST";
    request.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    request.timeoutInterval = 60;
    BLMultipartForm *form = [[BLMultipartForm alloc]init];
    [form addValue:userName forField:@"username"];
    [form addValue:email forField:@"email"];
    [form addValue:password forField:@"password"];
    [form addValue:gbid forField:@"gbid"];
    request.HTTPBody = [form httpBody];
    [request setValue:form.contentType forHTTPHeaderField:@"Content-Type"];
    self.urlConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
}

#pragma Mark NSURLConnectionDataDelegate

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
    NSString *string = [[NSString alloc]initWithData:self.receivedData encoding:NSUTF8StringEncoding];
    NSLog(@"received string %@", string);
    KGRegisterRequestParser *parser = [[KGRegisterRequestParser alloc]init];
    KGUserModel *user = [parser parseJson:self.receivedData];
    
    if ([_delegate respondsToSelector:@selector(registerRequestSuccess:user:)]) {
        [_delegate registerRequestSuccess:self user:user];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"error: %@", error);
    if ([_delegate respondsToSelector:@selector(registerRequestFailed:error:)]) {
        [_delegate registerRequestFailed:self error:error];
    }
}

@end