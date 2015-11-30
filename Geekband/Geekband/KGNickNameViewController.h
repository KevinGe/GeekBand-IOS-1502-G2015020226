//
//  KGNickNameViewController.h
//  Geekband
//
//  Created by sleepinge on 15/11/30.
//  Copyright © 2015年 sleepinge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KGEditNickNameRequest.h"

@interface KGNickNameViewController : UIViewController<KGEditNickNameRequestDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nickNameTextField;
@property (nonatomic, weak) NSString *nickName;
- (IBAction)doneBarButtonClicked:(id)sender;

@end
