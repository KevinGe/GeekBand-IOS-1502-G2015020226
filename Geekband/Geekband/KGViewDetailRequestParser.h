//
//  KGViewDetailRequestParser.h
//  Geekband
//
//  Created by sleepinge on 15/11/30.
//  Copyright © 2015年 sleepinge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KGViewDetailRequestParser : NSObject

- (NSArray *)parseJson:(NSData *)data;

@end

