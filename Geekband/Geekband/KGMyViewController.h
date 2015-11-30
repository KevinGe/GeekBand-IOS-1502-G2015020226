
//
//  KGMyViewController.h
//  Geekband
//
//  Created by sleepinge on 15/11/30.
//  Copyright © 2015年 sleepinge. All rights reserved.
//

#import "KGMyViewController.h"
#import "KGGlobal.h"
#import "AppDelegate.h"
#import "KGHeadImageViewController.h"

@interface KGMyViewController ()

@end

@implementation KGMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:237 green:127/255.0f blue:74/255.0f alpha:1.0f];
    self.headImageView.layer.cornerRadius = self.headImageView.frame.size.width / 2.0f;
    self.headImageView.clipsToBounds = YES;
}

// need by reload everytime
- (void)viewDidAppear:(BOOL)animated {
    self.nickNameLabel.text = [KGGlobal shareGlobal].user.username;
    self.headImageView.image = [KGGlobal shareGlobal].user.image;
    self.emailLabel.text = [KGGlobal shareGlobal].user.email;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 2) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"确定注销吗?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *enterAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self dismissViewControllerAnimated:YES completion:nil];
            [KGGlobal shareGlobal].user = nil;
            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [appDelegate loadLoginView];
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:enterAction];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end