//
//  KGRegisterRequestParser.m
//  Geekband
//
//  Created by sleepinge on 15/11/30.
//  Copyright © 2015年 sleepinge. All rights reserved.
//

#import "KGRegisterRequestParser.h"

@implementation KGRegisterRequestParser

- (KGUserModel *)parseJson:(NSData *)data {
    NSError *error = nil;
    id jsonDic = [NSJSONSerialization JSONObjectWithData:data
                                                 options:NSJSONReadingAllowFragments
                                                   error:&error];
    if (error) {
        NSLog(@"parse is not work!");
    } else {
        if ([[jsonDic class] isSubclassOfClass:[NSDictionary class]]) {
            id returnMessage = [jsonDic valueForKey:@"message"];
            if ([[returnMessage class] isSubclassOfClass:[NSString class]]) {
                KGUserModel *user = [[KGUserModel alloc]init];
                user.registerReturnMessage = returnMessage;
                return user;
            }
        }
    }
    
    return nil;
}

@end
