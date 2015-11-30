//
//  KGLocationParser.h
//  Geekband
//
//  Created by sleepinge on 15/11/30.
//  Copyright © 2015年 sleepinge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KGLocationModel.h"

@interface KGLocationParser : NSObject

- (KGLocationModel *)parseJson:(NSData *)data;

@end

