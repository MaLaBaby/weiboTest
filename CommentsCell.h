//
//  CommentsCell.h
//  weiboTest
//
//  Created by haitao on 17/1/19.
//  Copyright © 2017年 Haitao.xue. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYLabel;


@interface CommentsCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *avatarView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@property (strong, nonatomic) YYLabel *contentLabel; // 显示文本内容

- (void)adjustHeightForLabel:(YYLabel *)label; // 动态调节label显示区域高度

@end
