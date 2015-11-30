//
//  KGCommentListCell.m
//  Geekband
//
//  Created by sleepinge on 15/11/30.
//  Copyright © 2015年 sleepinge. All rights reserved.
//

#import "KGCommentListCell.h"

@interface KGCommentListCell(){
    CGFloat _cellWidth;
}

@end

@implementation KGCommentListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _cellWidth = [UIScreen mainScreen].bounds.size.width;
        
        _headImageOfComment = [[UIImageView alloc]initWithFrame:CGRectMake(12, 10, 40, 40)];
        _headImageOfComment.backgroundColor = [UIColor blueColor];
        _headImageOfComment.layer.cornerRadius = 20;
        [self.contentView addSubview:_headImageOfComment];
        
        _userNameOfComment = [[UILabel alloc]initWithFrame:CGRectMake(12+60+9, 7, _cellWidth-24-60-18-100, 18)];
        _userNameOfComment.textColor = [UIColor blueColor];
        _userNameOfComment.font = [UIFont fontWithName:@"Heiti SC" size:14];
        [self.contentView addSubview:_userNameOfComment];
        
        _textOfComment = [[UILabel alloc]initWithFrame:CGRectMake(12+60+9, 30, _cellWidth-24-60-18, 18)];
        _textOfComment.textColor = [UIColor blueColor];
        _textOfComment.font = [UIFont fontWithName:@"Heiti SC" size:14];
        [self.contentView addSubview:_textOfComment];
        
        _dateOfComment = [[UILabel alloc]initWithFrame:CGRectMake(_cellWidth-90-24, 7, 90, 18)];
        _dateOfComment.textColor = [UIColor blueColor];
        _dateOfComment.font = [UIFont fontWithName:@"Heiti SC" size:14];
        [self.contentView addSubview:_dateOfComment];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
