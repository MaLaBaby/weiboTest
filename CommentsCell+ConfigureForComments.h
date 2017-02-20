//
//  CommentsCell+ConfigureForComments.h
//  weiboTest
//
//  Created by haitao on 17/1/19.
//  Copyright © 2017年 Haitao.xue. All rights reserved.
//

#import "CommentsCell.h"
#import "CommentsModel.h"
@interface CommentsCell (ConfigureForComments)

- (CGFloat)configureForComments:(NSDictionary *)commentsDict; // 配置 comments dictionary （explore controller）

- (CGFloat)configureForCommentsInDetailController:(Comments *)comments; // 配置 comments model （detail controller）

@end
