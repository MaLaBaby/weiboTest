//
//  FindTableViewCell+ConfigureForTimeline.m
//  weiboTest
//
//  Created by haitao on 17/1/17.
//  Copyright © 2017年 Haitao.xue. All rights reserved.
//

#import "FindTableViewCell+ConfigureForTimeline.h"
#import "TimelineModel.h"
#import "FindViewController.h"

@implementation FindTableViewCell (ConfigureForTimeline)

- (CGFloat)configureForHomeTimeLine:(Statuses *)statusesModel indexPath:(NSIndexPath *)indexPath viewController:(FindViewController *)aViewController {
    self.id = [statusesModel id];
    self.nameLabel = [UILabel new];
    self.nameLabel.text = [statusesModel wbuser][@"name"];
    UITapGestureRecognizer *tapGestureRecognizer_1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkProfileAction)];
    [self.nameLabel addGestureRecognizer:tapGestureRecognizer_1];
    self.timeLabel = [UILabel new];
    self.timeLabel.text = [TimelineModel transformDate:[statusesModel created_at]];
    self.sourceLabel = [UILabel new];
    NSString *source = [TimelineModel transformSource:[statusesModel source]];
    if ([source isEqualToString:@"来自SDK微博应用demo"]) {
        self.sourceLabel.text = @"来自OWL微博";
    }else {
        self.sourceLabel.text = source;
    }
    self.avatarView = [UIImageView new];
    UITapGestureRecognizer *tapGestureRecognizer_2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkProfileAction)];
    [self.avatarView addGestureRecognizer:tapGestureRecognizer_2];
    self.row = indexPath.row;
    self.homeController = aViewController;
    self.avatarView.imageURL = [NSURL URLWithString:[statusesModel wbuser][@"profile_image_url"]];
    self.wbtextLabel = [YYLabel new];
    self.wbtextLabel.text = [statusesModel text];
    [self adjustHeightForLabel:self.wbtextLabel];
    NSArray *picArray = [statusesModel pic_urls];
    if (picArray.count) {
        if (picArray.count == 1) {
            [self setBmiddleViewWithUrl:[statusesModel bmiddle_pic] withLabel:self.wbtextLabel];
        }else {
            [self setThumbnailViewWithUrlArray:picArray withLabel:self.wbtextLabel];
        }
    }
    NSDictionary *retweetDictionary = [statusesModel retweeted_status];
    if (retweetDictionary) {
        self.retweetView = [UIView new];
        NSString *atStr = @"@";
        NSString *retweetName;
        if (retweetDictionary[@"user"]) {
            retweetName = [atStr stringByAppendingString:retweetDictionary[@"user"][@"name"]];
        }else {
            retweetName = @"@未知";
        }
        retweetName = [retweetName stringByAppendingString:@":"];
        self.retweetLabel = [YYLabel new];
        self.retweetLabel.text = [retweetName stringByAppendingString:retweetDictionary[@"text"]];
        [self adjustHeightForLabel:self.retweetLabel];
        NSArray *retweetPicArray = retweetDictionary[@"pic_urls"];
        [self adjustHeightForRetweetView:self.retweetView];
        if (retweetPicArray.count) {
            if (retweetPicArray.count == 1) {
                [self setRetweetBmiddleViewWithUrl:retweetDictionary[@"bmiddle_pic"] withLabel:self.retweetLabel];
            }else {
                [self setRetweetThumbnailViewWithUrlArray:retweetPicArray withLabel:self.retweetLabel];
            }
        }
    }
    self.repostView = [UIView new];
    UITapGestureRecognizer *repostTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellRepostAction)];
    [self.repostView addGestureRecognizer:repostTapGestureRecognizer];
    self.commentView = [UIView new];
    UITapGestureRecognizer *commentTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(CellCommentAction)];
    [self.commentView addGestureRecognizer:commentTapGestureRecognizer];
    self.attitudeView = [UIView new];
    UITapGestureRecognizer *attitudeTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(attitudeAction)];
    [self.attitudeView addGestureRecognizer:attitudeTapGestureRecognizer];
    
    if (picArray.count == 0 && retweetDictionary == nil) {
        self.bottomView = [UIView new];
        [self adjustHeightForBottomView:self.bottomView withView:self.wbtextLabel];
    }
    if (picArray.count && retweetDictionary == nil ) {
        self.bottomView = [UIView new];
        [self adjustHeightForBottomView:self.bottomView withView:self.lastImageView];
    }
    if (retweetDictionary && [retweetDictionary[@"pic_urls"] count] == 0) {
        self.bottomView = [UIView new];
        [self sizeFrameOfRetweetView:self.retweetView withLastRetweetImageOrLabelView:self.retweetLabel];
        [self adjustHeightForBottomView:self.bottomView withView:self.retweetView];
        [self sizeFrameOfView:self.bottomView];
    }
    if (retweetDictionary && [retweetDictionary[@"pic_urls"] count]) {
        self.bottomView = [UIView new];
        [self sizeFrameOfRetweetView:self.retweetView withLastRetweetImageOrLabelView:self.lastRetweetImageView];
        [self adjustHeightForBottomView:self.bottomView withView:self.retweetView];
        [self sizeFrameOfView:self.bottomView];
    }
    NSInteger reposts_count = [statusesModel reposts_count].integerValue;
    NSInteger comments_count = [statusesModel comments_count].integerValue;
    NSInteger attitudes_count = [statusesModel attitudes_count].integerValue;
    
    if (reposts_count == 0) {
        self.repostLabel.text = @"转发";
    }else {
        self.repostLabel.text = [TimelineModel shortedNumberDesc:reposts_count];
    }
    if (comments_count == 0) {
        self.commentLabel.text = @"评论";
    }else {
        self.commentLabel.text = [TimelineModel shortedNumberDesc:comments_count];
    }
    if (attitudes_count == 0) {
        self.attitudeLabel.text = @"赞";
    }else {
        self.attitudeLabel.text = [TimelineModel shortedNumberDesc:attitudes_count];
    }
    
    self.grayBarView = [UIView new];
    self.grayBarView.frame = CGRectMake(0, self.bottomView.frame.origin.y + self.bottomView.frame.size.height, self.grayBarView.frame.size.width, self.grayBarView.frame.size.height);
    CGFloat rowHeight = self.grayBarView.frame.origin.y + self.grayBarView.frame.size.height;
    return rowHeight;
}

@end
