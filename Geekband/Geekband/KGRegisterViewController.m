//
//  KGRegisterViewController.m
//  Geekband
//
//  Created by sleepinge on 15/11/27.
//  Copyright © 2015年 sleepinge. All rights reserved.
//

#import "KGRegisterViewController.h"
#import "KGRegisterRequest.h"

@interface KGRegisterViewController () <UITextFieldDelegate, KGRegisterRequestDeleage>

@property (nonatomic, strong) KGRegisterRequest *registerRequest;

@end

@implementation KGRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.registerButton.layer.cornerRadius = 5.0;
    self.registerButton.clipsToBounds = YES;
    
    self.userNameTextField.delegate = self;
    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.confirmPasswordTextField.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma Mark Event Handler
- (void)registerHandle {
    NSString *userName = self.userNameTextField.text;
    NSString *email = self.emailTextField.text;
    NSString *password = self.passwordTextField.text;
    NSString *gbid = @"G2015020226";
    self.registerRequest = [[KGRegisterRequest alloc]init];
    [self.registerRequest sendRegisterRequestWithUserName:userName email:email password:password gbid:gbid delegate:self];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    // restore postion of view
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    return YES;
}

- (IBAction)registerButtonClicked:(id)sender {
    NSString *userName = self.userNameTextField.text;
    NSString *email = self.emailTextField.text;
    NSString *password = self.passwordTextField.text;
    NSString *confirmPassword = self.confirmPasswordTextField.text;
    
    NSString *gbid = @"G2015020226";
    
    if ([userName length] == 0 ||
        [email length] == 0 ||
        [password length] == 0 ||
        [confirmPassword length] == 0) {
        [self showErrorMessage:@"用户名，邮箱，密码不能为空！"];
    } else if (![self isValidEmail:email]) {
        [self showErrorMessage:@"邮箱格式有误！"];
    } else if (![self isValidPassword:password]) {
        [self showErrorMessage:@"密码格式有误，应为6-20位数字或字母"];
    } else if (![password isEqualToString:confirmPassword]) {
        [self showErrorMessage:@"两次输入个密码不一致，请重新输入"];
    } else {
        [self registerHandle];
    }
}

- (IBAction)loginButtonClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)touchDownAction:(id)sender {
    [self.userNameTextField resignFirstResponder];
    [self.emailTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.confirmPasswordTextField resignFirstResponder];
    
    // restore postion of view
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    CGRect frame = self.registerButton.frame;
    int offset = frame.origin.y + 36 - (self.view.frame.size.height - 216); //keyboard height = 216
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    if (offset > 0) {
        self.view.frame = CGRectMake(0, -offset, self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
    }
}

#pragma Mark KGRegisterRequestDeleage

- (void)registerRequestSuccess:(KGRegisterRequest *)request user:(KGUserModel *)user {
    if ([user.registerReturnMessage isEqualToString:@"Register success"]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil
                                                       message:@"注册成功，请登录"
                                                      delegate:self
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil];
        [alert show];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)registerRequestFailed:(KGRegisterRequest *)request error:(NSError *)error {
    NSLog(@"注册错误原因：%@", error);
}

#pragma Mark Private Methods
- (void)showErrorMessage:(NSString *)msg {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}

- (BOOL)isValidEmail:(NSString *)email {
    NSString *emailRegex = @"^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

- (BOOL)isValidPassword:(NSString *)password {
    NSString *passwordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwordRegex];
    return [passwordTest evaluateWithObject:password];
}

@end
