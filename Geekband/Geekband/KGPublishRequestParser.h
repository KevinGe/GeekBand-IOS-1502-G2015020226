//
//  KGPublishRequestParser.h
//  Geekband
//
//  Created by sleepinge on 15/11/30.
//  Copyright © 2015年 sleepinge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KGPublishModel.h"

@interface KGPublishRequestParser : NSObject

- (KGPublishModel *)parseJson:(NSData *)data;

@end
