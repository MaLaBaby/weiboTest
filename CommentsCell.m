//
//  CommentsCell.m
//  weiboTest
//
//  Created by haitao on 17/1/19.
//  Copyright © 2017年 Haitao.xue. All rights reserved.
//

#import "CommentsCell.h"
#import "YYKit.h"

@implementation CommentsCell

#pragma mark - Accessor methods

- (void)setAvatarView:(UIImageView *)avatarView {
    avatarView.frame = CGRectMake(14, 12, 40, 40);
    avatarView.layer.cornerRadius = 20;
    avatarView.layer.masksToBounds = YES;
    _avatarView = avatarView;
    [self.contentView addSubview:_avatarView];
}

- (void)setContentLabel:(YYLabel *)contentLabel {
    contentLabel.frame = CGRectMake(62, 56, 0, 0);
    contentLabel.numberOfLines = 0;
    _contentLabel = contentLabel;
    [self.contentView addSubview:_contentLabel];
}

- (void)setNameLabel:(UILabel *)nameLabel {
    nameLabel.frame = CGRectMake(62, 10, 160, 21);
    nameLabel.font = [UIFont systemFontOfSize:13.0];
    nameLabel.textColor = [UIColor orangeColor];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    _nameLabel = nameLabel;
    [self.contentView addSubview:_nameLabel];
}

- (void)setTimeLabel:(UILabel *)timeLabel {
    timeLabel.frame = CGRectMake(62, 31, 217, 21);
    timeLabel.font = [UIFont systemFontOfSize:12.0];
    timeLabel.textColor = [UIColor colorWithRed:180.0/255.0 green:180.0/255.0 blue:180.0/255.0 alpha:1.0];
    _timeLabel = timeLabel;
    [self.contentView addSubview:_timeLabel];
}

#pragma mark - Size frame of view

- (void)adjustHeightForLabel:(YYLabel *)label {
    UIFont *font = [UIFont systemFontOfSize:14.0];
    UIColor *color = label.textColor;
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          font, NSFontAttributeName,
                                          color, NSForegroundColorAttributeName,
                                          nil];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:label.text attributes:attributesDictionary];
    CGRect rect = [string boundingRectWithSize:CGSizeMake(250.f, CGFLOAT_MAX) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) context:nil];
    label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y, rect.size.width, rect.size.height);
    // 调整行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:6];
    [string addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [label.text length])];
    label.attributedText = string;
    [label sizeToFit];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
