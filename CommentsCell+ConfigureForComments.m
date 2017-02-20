//
//  CommentsCell+ConfigureForComments.m
//  weiboTest
//
//  Created by haitao on 17/1/19.
//  Copyright © 2017年 Haitao.xue. All rights reserved.
//

#import "CommentsCell+ConfigureForComments.h"
#import "YYKit.h"

@implementation CommentsCell (ConfigureForComments)

- (CGFloat)configureForComments:(NSDictionary *)commentsDict {
    self.avatarView = [UIImageView new];
    NSString *imageURL = commentsDict[@"user"][@"profile_image_url"];
    self.avatarView.imageURL = [NSURL URLWithString:imageURL];
    self.nameLabel = [UILabel new];
    NSString *name = commentsDict[@"user"][@"screen_name"];
    self.nameLabel.text = name;
    self.timeLabel = [UILabel new];
    self.timeLabel.text = [CommentsModel convertDateformat:commentsDict[@"created_at"]];
    self.contentLabel = [YYLabel new];
    self.contentLabel.text = commentsDict[@"text"];
    [self adjustHeightForLabel:self.contentLabel];
    CGFloat rowHeight = self.contentLabel.frame.origin.y + self.contentLabel.frame.size.height + 10;
    return rowHeight;
}

- (CGFloat)configureForCommentsInDetailController:(Comments *)comments {
    self.avatarView = [UIImageView new];
    self.avatarView.imageURL = [NSURL URLWithString:[comments wbuser][@"profile_image_url"]];
    self.nameLabel = [UILabel new];
    self.nameLabel.text = [comments wbuser][@"name"];
    self.timeLabel = [UILabel new];
    if ([comments created_at]) {
        self.timeLabel.text = [CommentsModel convertDateformat:[comments created_at]];
    }
    self.contentLabel = [YYLabel new];
    self.contentLabel.text = [comments text];
    [self adjustHeightForLabel:self.contentLabel];
    CGFloat rowHeight = self.contentLabel.frame.origin.y + self.contentLabel.frame.size.height + 10;
    return rowHeight;
}

@end
