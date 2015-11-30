//
//  KGCommentListCell.h
//  Geekband
//
//  Created by sleepinge on 15/11/30.
//  Copyright © 2015年 sleepinge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KGCommentListCell : UITableViewCell

@property (nonatomic, retain) UILabel *userNameOfComment;
@property (nonatomic, retain) UILabel *textOfComment;
@property (nonatomic, retain) UIImageView *headImageOfComment;
@property (nonatomic, retain) UILabel *dateOfComment;

@end
