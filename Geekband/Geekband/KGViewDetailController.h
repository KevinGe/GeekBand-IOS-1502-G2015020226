//
//  KGViewDetailController.h
//  Geekband
//
//  Created by sleepinge on 15/11/30.
//  Copyright © 2015年 sleepinge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KGViewDetailRequest.h"

@interface KGViewDetailController : UIViewController<UITableViewDataSource, UITableViewDelegate, KGViewDetailRequestDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *photoImage;
@property (nonatomic, copy) NSString *pic_id;
@property (nonatomic, copy) NSString *pic_url;
@property (nonatomic, copy) NSArray *commentArrary;

@end

