//
//  VideoInformationCell.m
//  VIdeoTest
//
//  Created by haitao on 17/2/13.
//  Copyright © 2017年 Haitao.xue. All rights reserved.
//

#import "VideoInformationCell.h"
#import "Model.h"
#import "UIImageView+WebCache.h"
#import "UIView+SDAutoLayout.h"

@interface VideoInformationCell ()

@end

@implementation VideoInformationCell

+(VideoInformationCell *)videoCellWithTableView:(UITableView *)tableview{
    static NSString *ID = @"videoInformationCell";
    VideoInformationCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"VideoInformationCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setVideoItem:(Model *)videoItem{
    _CoverImageView.userInteractionEnabled = YES;
    _playImageView.userInteractionEnabled = YES;
    _videoItem = videoItem;
    _titleLabel.text = videoItem.title;
    _titleLabel.sd_layout.widthIs(250).autoHeightRatio(0);
    [self.CoverImageView setImageWithURL:[NSURL URLWithString:videoItem.cover]];
}

@end
