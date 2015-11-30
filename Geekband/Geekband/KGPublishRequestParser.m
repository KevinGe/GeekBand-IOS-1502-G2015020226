//
//  KGPublishRequestParser.m
//  Geekband
//
//  Created by sleepinge on 15/11/30.
//  Copyright © 2015年 sleepinge. All rights reserved.
//

#import "KGPublishRequestParser.h"

@implementation KGPublishRequestParser

- (KGPublishModel *)parseJson:(NSData *)data {
    NSError *error = nil;
    id jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    if (error) {
        NSLog(@"Error in KGPublishRequestParser");
    } else {
        if ([[jsonDic class] isSubclassOfClass:[NSDictionary class]]) {
            id returnMessage = [jsonDic valueForKey:@"data"];
            id returnPic = [returnMessage valueForKey:@"pic_id"];
            if ([[returnPic class] isSubclassOfClass:[NSString class]]) {
                KGPublishModel *model = [[KGPublishModel alloc]init];
                model.picId = returnPic;
                return model;
            }
        }
    }
    
    return nil;
}

@end
