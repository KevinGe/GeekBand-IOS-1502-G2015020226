//
//  KGLoginRequestParser.m
//  Geekband
//
//  Created by sleepinge on 15/11/30.
//  Copyright © 2015年 sleepinge. All rights reserved.
//

#import "KGLoginRequestParser.h"

@implementation KGLoginRequestParser

- (KGUserModel *)parseJson:(NSData *)data {
    NSError *error = nil;
    id jsonDic = [NSJSONSerialization JSONObjectWithData:data
                                                 options:NSJSONReadingAllowFragments
                                                   error:&error];
    if (error) {
        NSLog(@"Error in KGLoginRequestParser.parseJson");
    } else {
        if ([[jsonDic class] isSubclassOfClass:[NSDictionary class]]) {
            KGUserModel *user = [[KGUserModel alloc]init];
            id returnMessage = [jsonDic valueForKey:@"message"];
            if ([[returnMessage class] isSubclassOfClass:[NSString class]]) {
                user.loginReturnMessage = returnMessage;
            }
            id data = [jsonDic valueForKey:@"data"];
            if ([[data class] isSubclassOfClass:[NSDictionary class]]) {
                id userId = [data valueForKey:@"user_id"];
                if ([[userId class] isSubclassOfClass:[NSString class]]) {
                    user.userId = userId;
                }
                
                id token = [data valueForKey:@"token"];
                if ([[token class] isSubclassOfClass:[NSString class]]) {
                    user.token = token;
                }
                
                id userName = [data valueForKey:@"user_name"];
                if ([[userName class] isSubclassOfClass:[NSString class]]) {
                    user.username = userName;
                }
            }
            return user;
        }
    }
    
    return nil;
}

@end
