    //
//  KGLoginAndRegisterViewController.m
//  Geekband
//
//  Created by sleepinge on 15/11/27.
//  Copyright © 2015年 sleepinge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KGLoginRequest.h"
#import "KGUserModel.h"

@interface KGLoginAndRegisterViewController : UIViewController<UITextFieldDelegate, KGLoginRequestDelegate>

@property (nonatomic, strong) KGLoginRequest *loginRequest;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
- (IBAction)loginButtonClicked:(id)sender;
- (IBAction)touchDownAction:(id)sender;

@end