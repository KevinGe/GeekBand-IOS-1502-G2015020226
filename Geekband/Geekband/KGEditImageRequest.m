//
//  KGEditImageRequest.m
//  Geekband
//
//  Created by sleepinge on 15/11/30.
//  Copyright © 2015年 sleepinge. All rights reserved.
//

#import "KGEditImageRequest.h"
#import "BLMultipartForm.h"
#import "KGGlobal.h"

@implementation KGEditImageRequest

- (void)sendEditImageRequest:(UIImage *)image delegate:(id<KGEditImageRequestDelegate>)delegate {
    [self.urlConnection cancel];
    self.delegate = delegate;
    
    NSURL *url = [NSURL URLWithString:@"http://moran.chinacloudapp.cn/moran/web/user/avatar"];
    NSData *data = UIImageJPEGRepresentation(image, 0.1);
    BLMultipartForm *form = [[BLMultipartForm alloc]init];
    [form addValue:[KGGlobal shareGlobal].user.userId forField:@"user_id"];
    [form addValue:[KGGlobal shareGlobal].user.token forField:@"token"];
    [form addValue:data forField:@"data"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [form httpBodyForImage];
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
    NSString *result = [[NSString alloc]initWithData:self.receivedData encoding:NSUTF8StringEncoding];
    NSLog(@"%@", result);
    if ([_delegate respondsToSelector:@selector(editImageRequestSuccess:)]) {
        [_delegate editImageRequestSuccess:self];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Error: %@", error);
    if ([_delegate respondsToSelector:@selector(editImageRequestFailed:error:)]) {
        [_delegate editImageRequestFailed:self error:error];
    }
}

@end
