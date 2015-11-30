//
//  KGGlobal.h
//  Geekband
//
//  Created by sleepinge on 15/11/27.
//  Copyright © 2015年 sleepinge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KGUserModel.h"

@interface KGGlobal : NSObject

@property (nonatomic, strong)KGUserModel *user;

+ (KGGlobal *)shareGlobal;

@end
