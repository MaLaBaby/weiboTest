//
//  FindTableViewCell+ConfigureForStatusesInDetail.m
//  weiboTest
//
//  Created by haitao on 17/1/19.
//  Copyright © 2017年 Haitao.xue. All rights reserved.
//

#import "FindTableViewCell+ConfigureForStatusesInDetail.h"
#import "TimelineModel.h"

@implementation FindTableViewCell (ConfigureForStatusesInDetail)

- (CGFloat)configureForStatuses:(Statuses *)statuses {
    self.nameLabel = [UILabel new];
    self.nameLabel.text = statuses.wbuser[@"screen_name"];
    self.avatarView = [UIImageView new];
    self.avatarView.imageURL = [NSURL URLWithString:statuses.wbuser[@"profile_image_url"]];
    self.timeLabel = [UILabel new];
    self.timeLabel.text = [TimelineModel transformDate:statuses.created_at];
    self.sourceLabel = [UILabel new];
    NSString *source = [TimelineModel transformSource:statuses.source];
    if ([source isEqualToString:@"来自SDK微博应用demo"]) {
        self.sourceLabel.text = @"来自OWL微博";
    }else {
        self.sourceLabel.text = source;
    }
    self.wbtextLabel = [YYLabel new];
    self.wbtextLabel.text = statuses.text;
    [self adjustHeightForLabel:self.wbtextLabel];
    NSArray *picArray = statuses.pic_urls;
    if (picArray.count) {
        if (picArray.count == 1) {
            [self setBmiddleViewWithUrl:[statuses bmiddle_pic] withLabel:self.wbtextLabel];
        }else {
            [self setThumbnailViewWithUrlArray:picArray withLabel:self.wbtextLabel];
        }
    }
    NSDictionary *retweetDictionary = [statuses retweeted_status];
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
    
    if (picArray.count == 0 && retweetDictionary == nil) {
        self.grayBarView = [UIView new];
        [self adjustHeightForBottomView:self.grayBarView withView:self.wbtextLabel];
    }
    if (picArray.count && retweetDictionary == nil) {
        self.grayBarView = [UIView new];
        [self adjustHeightForBottomView:self.grayBarView withView:self.lastImageView];
    }
    if (retweetDictionary && [retweetDictionary[@"pic_urls"] count] == 0) {
        self.grayBarView = [UIView new];
        [self sizeFrameOfRetweetView:self.retweetView withLastRetweetImageOrLabelView:self.retweetLabel];
        [self adjustHeightForBottomView:self.grayBarView withView:self.retweetView];
        [self sizeFrameOfView:self.grayBarView];
    }
    if (retweetDictionary && [retweetDictionary[@"pic_urls"] count]) {
        self.grayBarView = [UIView new];
        [self sizeFrameOfRetweetView:self.retweetView withLastRetweetImageOrLabelView:self.lastRetweetImageView];
        [self adjustHeightForBottomView:self.grayBarView withView:self.retweetView];
        [self sizeFrameOfView:self.grayBarView];
    }
    CGFloat rowHeight = self.grayBarView.frame.origin.y + self.grayBarView.frame.size.height;
    return rowHeight;
}

@end
