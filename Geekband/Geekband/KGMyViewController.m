//
//  KGMyViewController.m
//  Geekband
//
//  Created by sleepinge on 15/11/30.
//  Copyright © 2015年 sleepinge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KGMyViewController : UITableViewController<UIActionSheetDelegate, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;

@end
