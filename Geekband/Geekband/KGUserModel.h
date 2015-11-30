//
//  KGUserModel.h
//  Geekband
//
//  Created by sleepinge on 15/11/30.
//  Copyright © 2015年 sleepinge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface KGUserModel : NSObject

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *loginReturnMessage;
@property (nonatomic, copy) NSString *registerReturnMessage;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, strong) UIImage *image;

@end

