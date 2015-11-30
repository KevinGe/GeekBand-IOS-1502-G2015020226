//
//  KGGlobal.m
//  Geekband
//
//  Created by sleepinge on 15/11/27.
//  Copyright © 2015年 sleepinge. All rights reserved.
//

#import "KGGlobal.h"

static KGGlobal *global = nil;

@implementation KGGlobal

+ (KGGlobal *)shareGlobal {
    if (global == nil) {
        global = [[KGGlobal alloc]init];
    }
    return global;
}

@end
