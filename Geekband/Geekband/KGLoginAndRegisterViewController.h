//
//  Header.h
//  Geekband
//
//  Created by sleepinge on 15/11/27.
//  Copyright © 2015年 sleepinge. All rights reserved.
//

#import "KGLoginAndRegisterViewController.h"
#import "AppDelegate.h"
#import "KGGlobal.h"
#import "KGGetImage.h"

@interface KGLoginAndRegisterViewController ()

@end

@implementation KGLoginAndRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;
    
    self.emailTextField.text = @"joeyu@live.cn";
    self.passwordTextField.text = @"123456";
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

- (IBAction)loginButtonClicked:(id)sender {
    NSString *userName = self.emailTextField.text;
    NSString *password = self.passwordTextField.text;
    
    if (([userName length] == 0) || [password length] == 0) {
        [self showErrorMessage:@"邮箱和密码不能为空"];
    } else {
        [self loginHandle];
    }
}

- (void)showErrorMessage:(NSString *)msg {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}

- (void)loginHandle {
    NSString *email = self.emailTextField.text;
    NSString *password = self.passwordTextField.text;
    NSString *gbid = @"G2015020226";
    
    self.loginRequest = [[KGLoginRequest alloc]init];
    [self.loginRequest sendLoginRequestWithEmail:email password:password gbid:gbid delegate:self];
}

- (IBAction)touchDownAction:(id)sender {
    [self.emailTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)loginRequestSuccess:(KGLoginRequest *)request user:(KGUserModel *)user {
    if ([user.loginReturnMessage isEqualToString:@"Login success"]) {
        NSLog(@"登录成功，现在转换页面");
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [KGGlobal shareGlobal].user = user;
        [KGGlobal shareGlobal].user.email = self.emailTextField.text;
        KGGetImage *getImage = [[KGGetImage alloc]init];
        [getImage sendGetImageRequest];
        [appDelegate loadMainViewWithController:self];
    } else {
        NSLog(@"服务器错误:%@", user.loginReturnMessage);
    }
}

- (void)loginRequestFailed:(KGLoginRequest *)request error:(NSError *)error {
    NSLog(@"登录错误原因：%@", error);
}

@end
