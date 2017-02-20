//
//  MessageCell.m
//  weiboTest
//
//  Created by haitao on 17/1/18.
//  Copyright © 2017年 Haitao.xue. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self createView];
    }
    return self;
}
-(void)createView
{
    _photoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
    _photoImageView.layer.cornerRadius = 30.0;
    _photoImageView.layer.masksToBounds = YES;
    _photoImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_photoImageView];

    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10+60+10 , 10, 80, 60)];
    _titleLabel.font = [UIFont systemFontOfSize:16.0];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_titleLabel];
}





















- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
