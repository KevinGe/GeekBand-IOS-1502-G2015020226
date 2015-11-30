//
//  KGHeadImageViewController.m
//  Geekband
//
//  Created by sleepinge on 15/11/30.
//  Copyright © 2015年 sleepinge. All rights reserved.
//

#import "KGHeadImageViewController.h"
#import "KGEditImageRequest.h"
#import "KGGlobal.h"

@interface KGHeadImageViewController ()

@end

@implementation KGHeadImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)doneButtonClicked:(id)sender {
    KGEditImageRequest *request = [[KGEditImageRequest alloc]init];
    [request sendEditImageRequest:self.headImageView.image delegate:self];
}

- (void)editImageRequestSuccess:(KGEditImageRequest *)request {
    [KGGlobal shareGlobal].user.image = self.headImageView.image;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)editImageRequestFailed:(KGEditImageRequest *)request error:(NSError *)error {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)editHeadImageClicked:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                        destructiveButtonTitle:nil
                                             otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    [sheet showInView:self.tabBarController.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    self.pickerController = [[UIImagePickerController alloc]init];
    if (buttonIndex == 0) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            self.pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            self.pickerController.allowsEditing = NO;
            self.pickerController.delegate = self;
            [self.tabBarController presentViewController:self.pickerController animated:YES completion:nil];
        } else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误" message:@"无法获取照相机" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            return;
        }
    } else if (buttonIndex == 1) {
        self.pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        self.pickerController.delegate = self;
        [self.tabBarController presentViewController:self.pickerController animated:YES completion:nil];
    }
}

- (UIImage *)imageWithImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;   //返回的就是已经改变的图片
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    //    CGSize imageSize = image.size;
    //    imageSize.height = 625;
    //    imageSize.width = 413;
    //    image = [self imageWithImage:image scaleToSize:imageSize];
    
    self.headImageView.image = image;
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    //    if (self.pickerController.sourceType == UIImagePickerControllerSourceTypeCamera) {
    //        headImageController.headImageView.image = image;
    //        [picker dismissViewControllerAnimated:YES completion:nil];
    //    } else {
    //        [picker dismissViewControllerAnimated:YES completion:nil];
    //    }
}

@end