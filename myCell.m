//
//  myCell.m
//  weiboTest
//
//  Created by haitao on 17/1/9.
//  Copyright © 2017年 Haitao.xue. All rights reserved.
//

#import "myCell.h"

@implementation myCell

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
    _sourceView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 150)];
    [self addSubview:_sourceView];
    
    _personImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 55, 55)];
    _personImageView.layer.cornerRadius = 27.5;
    _personImageView.layer.masksToBounds = YES;
    _personImageView.image = [UIImage imageNamed:@"loginImage.jpg"];
    [_sourceView addSubview:_personImageView];
    
    _nameLab = [[UILabel alloc]initWithFrame:CGRectMake(20+55+10, 30, 100, 20)];
    _nameLab.text = @"这里显示名字";
    _nameLab.font = [UIFont systemFontOfSize:16];
    [_sourceView addSubview:_nameLab];
    
    _desLab = [[UILabel alloc]initWithFrame:CGRectMake(20+55+10, 30+20, 100, 20)];
    _desLab.text = @"这里显示简介";
    _desLab.font = [UIFont systemFontOfSize:12];
    _desLab.textColor = [UIColor colorWithRed:180.0/255.0 green:180.0/255.0 blue:180.0/255.0 alpha:1.0];
    [_sourceView addSubview:_desLab];
    
    _vipBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width-80, 28, 80, 40)];
    _vipBtn.backgroundColor = [UIColor clearColor];
    [_vipBtn setBackgroundImage:[UIImage imageNamed:@"vip"] forState:UIControlStateNormal];
    [_sourceView addSubview:_vipBtn];
    
    _weiboBtn = [[UIButton alloc]initWithFrame:CGRectMake(40, 30+20+20+40, 30, 30)];
    _weiboBtn.backgroundColor = [UIColor clearColor];
    [_weiboBtn setTitle:@"微博" forState:UIControlStateNormal];
    [_weiboBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_weiboBtn setTitleColor:[UIColor colorWithRed:180.0/255.0 green:180.0/255.0 blue:180.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_sourceView addSubview:_weiboBtn];
    
    _weiboCountLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 30+20+20+25, 80, 20)];
    _weiboCountLab.text = @"00000";
    _weiboCountLab.textAlignment = NSTextAlignmentCenter;
    [_sourceView addSubview:_weiboCountLab];
    
    _guanzhuBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width/2-15, 30+20+20+40, 30, 30)];
    _guanzhuBtn.backgroundColor = [UIColor clearColor];
    [_guanzhuBtn setTitle:@"关注" forState:UIControlStateNormal];
    [_guanzhuBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_guanzhuBtn setTitleColor:[UIColor colorWithRed:180.0/255.0 green:180.0/255.0 blue:180.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_sourceView addSubview:_guanzhuBtn];
    
    _guanzhuCountLab = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2-15-25, 30+20+20+25, 80, 20)];
    _guanzhuCountLab.text = @"00000";
    _guanzhuCountLab.textAlignment = NSTextAlignmentCenter;
    [_sourceView addSubview:_guanzhuCountLab];

    
    _fensiBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width-40-30, 30+20+20+40, 30, 30)];
    _fensiBtn.backgroundColor = [UIColor clearColor];
    [_fensiBtn setTitle:@"粉丝" forState:UIControlStateNormal];
    [_fensiBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_fensiBtn setTitleColor:[UIColor colorWithRed:180.0/255.0 green:180.0/255.0 blue:180.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_sourceView addSubview:_fensiBtn];
    
    _fensiCountLab = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width-40-30-25, 30+20+20+25, 80, 20)];
    _fensiCountLab.text = @"00000";
    _fensiCountLab.textAlignment = NSTextAlignmentCenter;
    [_sourceView addSubview:_fensiCountLab];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
