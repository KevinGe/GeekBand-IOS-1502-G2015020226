//
//  KGLoginRequestParser.h
//  Geekband
//
//  Created by sleepinge on 15/11/30.
//  Copyright © 2015年 sleepinge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KGUserModel.h"

@interface KGLoginRequestParser : NSObject

- (KGUserModel *)parseJson:(NSData *)data;

@end
