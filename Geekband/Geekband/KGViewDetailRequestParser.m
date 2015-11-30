//
//  KGViewDetailRequestParser.m
//  Geekband
//
//  Created by sleepinge on 15/11/30.
//  Copyright © 2015年 sleepinge. All rights reserved.
//

#import "KGViewDetailRequestParser.h"
#import "KGViewDetailModel.h"

@implementation KGViewDetailRequestParser

- (NSArray *)parseJson:(NSData *)data {
    NSError *error = nil;
    NSMutableArray *array = nil;
    
    id jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    if (error) {
        NSLog(@"KGViewDetailRequestParser");
    } else {
        if ([[jsonDic class]isSubclassOfClass:[NSDictionary class]]) {
            array = [[NSMutableArray alloc]init];
            id data = [jsonDic valueForKey:@"data"];
            for (id dic in data) {
                KGViewDetailModel *model = [[KGViewDetailModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [array addObject:model];
            }
        }
    }
    
    return array;
}

@end
