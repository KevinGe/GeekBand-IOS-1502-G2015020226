//
//  KGEditNickNameRequest.m
//  Geekband
//
//  Created by sleepinge on 15/11/30.
//  Copyright © 2015年 sleepinge. All rights reserved.
//

#import "KGEditNickNameRequest.h"
#import "BLMultipartForm.h"
#import "KGGlobal.h"

@implementation KGEditNickNameRequest

- (void)sendEditNickNameRequest:(NSString *)nickName delegate:(id<KGEditNickNameRequestDelegate>)delegate {
    [self.urlConnection cancel];
    self.delegate = delegate;
    
    NSURL *url = [NSURL URLWithString:@"http://moran.chinacloudapp.cn/moran/web/user/rename"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    request.HTTPMethod = @"POST";
    BLMultipartForm *form = [[BLMultipartForm alloc]init];
    [form addValue:[KGGlobal shareGlobal].user.userId forField:@"user_id"];
    [form addValue:[KGGlobal shareGlobal].user.token forField:@"token"];
    [form addValue:nickName forField:@"new_name"];
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
    NSString *string = [[NSString alloc]initWithData:self.receivedData encoding:NSUTF8StringEncoding];
    NSLog(@"rename data string %@", string);
    if ([_delegate respondsToSelector:@selector(editNickNameRequestSuccess:)]) {
        [_delegate editNickNameRequestSuccess:self];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Error: %@", error);
    if ([_delegate respondsToSelector:@selector(editNickNameRequestFailed:error:)]) {
        [_delegate editNickNameRequestFailed:self error:error];
    }
}

@end