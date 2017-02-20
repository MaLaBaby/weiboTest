//
//  mineCell.m
//  weiboTest
//
//  Created by haitao on 17/1/9.
//  Copyright © 2017年 Haitao.xue. All rights reserved.
//

#import "mineCell.h"

@implementation mineCell

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
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(7, 7, 30, 30)];
    _imgView.backgroundColor = [UIColor greenColor];
    [self addSubview:_imgView];
    
    _lab = [[UILabel alloc]initWithFrame:CGRectMake(7+30+7, 7, 60, 30)];
    _lab.text = @"新的好友";
    _lab.font = [UIFont systemFontOfSize:14];
    [self addSubview:_lab];
    
    _deslab = [[UILabel alloc]initWithFrame:CGRectMake(7+30+7+60+7, 7, 180, 30)];
    _deslab.text = @"";
    _deslab.font = [UIFont systemFontOfSize:12];
    _deslab.textColor = [UIColor colorWithRed:180.0/255.0 green:180.0/255.0 blue:180.0/255.0 alpha:1.0];
    [self addSubview:_deslab];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
