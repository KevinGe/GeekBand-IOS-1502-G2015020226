//
//  KGNickNameViewController.m
//  Geekband
//
//  Created by sleepinge on 15/11/30.
//  Copyright © 2015年 sleepinge. All rights reserved.
//

#import "KGNickNameViewController.h"
#import "KGGlobal.h"

@implementation KGNickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)doneBarButtonClicked:(id)sender {
    KGEditNickNameRequest *request = [[KGEditNickNameRequest alloc]init];
    [request sendEditNickNameRequest:self.nickNameTextField.text delegate:self];
}

- (void)editNickNameRequestSuccess:(KGEditNickNameRequest *)request {
    [KGGlobal shareGlobal].user.username = self.nickNameTextField.text;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)editNickNameRequestFailed:(KGEditNickNameRequest *)request error:(NSError *)error {
    [self.navigationController popViewControllerAnimated:YES];
}

@end

