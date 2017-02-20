//
//  MYTabBar.m
//  weiboTest
//
//  Created by yaopeng on 16/12/26.
//  Copyright © 2016年 Haitao.xue. All rights reserved.
//

#import "MYTabBar.h"

@implementation MYTabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        //添加一个按钮到tabbar中
        UIButton *plusBtn = [[UIButton alloc]init];
        [plusBtn setImage:[UIImage imageNamed:@"ok"] forState:UIControlStateNormal];
//        plusBtn.imageView.layer.cornerRadius = 20.0;
//        plusBtn.imageView.layer.masksToBounds = YES;
        CGRect temp = plusBtn.frame;
        temp.size = plusBtn.currentImage.size;
        
        plusBtn.frame =temp;
        [plusBtn addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:plusBtn];
        self.plusBtn = plusBtn;
    }
    return self;
}

- (void)plusClick
{
    //通知代理
    if ([self.tabBarDelegate respondsToSelector:@selector(tabBarDidClickPlusButton:)])
    {
        [self.tabBarDelegate tabBarDidClickPlusButton:self];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置加号按钮的位置
    CGPoint temp = self.plusBtn.center;
    temp.x = self.frame.size.width/2;
    temp.y = self.frame.size.height/2;
    self.plusBtn.center = temp;
    
    //设置其他UITabBarButton的位置和尺寸
    CGFloat tabbarButtonW = self.frame.size.width/5;
    CGFloat tabbarButtonIndex = 0;
    for (UIView *child in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            //设置宽度
            CGRect temp1 = child.frame;
            temp1.size.width = tabbarButtonW;
            temp1.origin.x = tabbarButtonIndex *tabbarButtonW;
            child.frame = temp1;
            //增加索引
            tabbarButtonIndex++;
            if (tabbarButtonIndex == 2) {
                tabbarButtonIndex++;
            }
        }
    }
}

@end
