//
//  KGViewDetailModel.h
//  Geekband
//
//  Created by sleepinge on 15/11/30.
//  Copyright © 2015年 sleepinge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KGViewDetailModel : NSObject

@property (nonatomic, strong) NSString *comment;
@property (nonatomic, strong) NSString *modified;

- (void)setValue:(id)value forUndefinedKey:(nonnull NSString *)key;

@end
