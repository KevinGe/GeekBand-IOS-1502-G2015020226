//
//  KGHeadImageViewController.h
//  Geekband
//
//  Created by sleepinge on 15/11/30.
//  Copyright © 2015年 sleepinge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KGEditImageRequest.h"

@interface KGHeadImageViewController : UIViewController<KGEditImageRequestDelegate, UIImagePickerControllerDelegate>
- (IBAction)doneButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (strong, nonatomic) UIImagePickerController *pickerController;
- (IBAction)editHeadImageClicked:(id)sender;

@end