//
//  SetCell.m
//  weiboTest
//
//  Created by haitao on 17/1/10.
//  Copyright © 2017年 Haitao.xue. All rights reserved.
//

#import "SetCell.h"

@implementation SetCell

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
    _desLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 80, 24)];
    _desLab.text = @"账号管理";
    [self addSubview:_desLab];
    _otherLab = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width-20-60, 10, 60, 24)];
    _otherLab.text = @"";
    [self addSubview:_otherLab];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
