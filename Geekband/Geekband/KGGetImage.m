//
//  KGGetImage.m
//  Geekband
//
//  Created by sleepinge on 15/11/30.
//  Copyright © 2015年 sleepinge. All rights reserved.
//

#import "KGGetImage.h"
#import "KGGlobal.h"

@implementation KGGetImage

- (void)sendGetImageRequest {
    [self.urlConnection cancel];
    
    
    NSString *urlString = @"http://moran.chinacloudapp.cn/moran/web/user/show";
    urlString = [NSString stringWithFormat:@"%@?user_id=%@", urlString, [KGGlobal shareGlobal].user.userId];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    request.HTTPMethod = @"GET";
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
    [KGGlobal shareGlobal].user.image = [[UIImage alloc]initWithData:self.receivedData];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Error: %@", error);
}

@end
