//
//  KGRegisterViewController.h
//  Geekband
//
//  Created by sleepinge on 15/11/27.
//  Copyright © 2015年 sleepinge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KGRegisterViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

- (IBAction)registerButtonClicked:(id)sender;
- (IBAction)loginButtonClicked:(id)sender;
- (IBAction)touchDownAction:(id)sender;



@end
