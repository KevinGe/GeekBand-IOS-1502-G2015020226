//
//  KGLocationParser.m
//  Geekband
//
//  Created by sleepinge on 15/11/30.
//  Copyright © 2015年 sleepinge. All rights reserved.
//

#import "KGLocationParser.h"

@implementation KGLocationParser

- (KGLocationModel *)parseJson:(NSData *)data {
    NSError *error = nil;
    id jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    if (error) {
        NSLog(@"KGLocationParser");
    } else {
        if ([[jsonDic class] isSubclassOfClass:[NSDictionary class]]) {
            KGLocationModel *model = [[KGLocationModel alloc]init];
            model.nameArray = [NSMutableArray array];
            model.addrArray = [NSMutableArray array];
            for (id addr in [jsonDic valueForKey:@"addrList"]) {
                [model.nameArray addObject:[addr valueForKey:@"admName"]];
                [model.addrArray addObject:[addr valueForKey:@"name"]];
            }
            return model;
        }
    }
    
    return nil;
}

@end

