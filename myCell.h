//
//  myCell.h
//  weiboTest
//
//  Created by haitao on 17/1/9.
//  Copyright © 2017年 Haitao.xue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myCell : UITableViewCell

@property (nonatomic, strong) UIView *sourceView;

@property (nonatomic, strong) UIImageView *personImageView;

@property (nonatomic, strong) UILabel *nameLab;

@property (nonatomic, strong) UILabel *desLab;

@property (nonatomic, strong) UIButton *vipBtn;

@property (nonatomic, strong) UIButton *weiboBtn;

@property (nonatomic, strong) UIButton *guanzhuBtn;

@property (nonatomic, strong) UIButton *fensiBtn;

@property (nonatomic, strong) UILabel *weiboCountLab;

@property (nonatomic, strong) UILabel *guanzhuCountLab;

@property (nonatomic, strong) UILabel *fensiCountLab;

@end
