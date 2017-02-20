//
//  FindTableViewCell.m
//  weiboTest
//
//  Created by haitao on 17/1/17.
//  Copyright © 2017年 Haitao.xue. All rights reserved.
//

#import "FindTableViewCell.h"
#import "StatusHelper.h"
#import "NSAttributedString+YYText.h"
#import "YYKit.h"
#import "FindViewController.h"

@implementation FindTableViewCell

#pragma mark - Accessor methods

- (void)setNameLabel:(UILabel *)nameLabel {
    nameLabel.frame = CGRectMake(70, 10, 144, 21);
    nameLabel.font = [UIFont systemFontOfSize:14.0];
    nameLabel.userInteractionEnabled = YES;
    nameLabel.textColor = [UIColor orangeColor];
    _nameLabel = nameLabel;
    [self.contentView addSubview:_nameLabel];
}

- (void)setTimeLabel:(UILabel *)timeLabel {
    timeLabel.frame = CGRectMake(209, 10, 103, 21);
    timeLabel.font = [UIFont systemFontOfSize:12.0];
    timeLabel.textColor = [UIColor colorWithRed:180.0/255.0 green:180.0/255.0 blue:180.0/255.0 alpha:1.0];
    timeLabel.textAlignment = NSTextAlignmentRight;
    _timeLabel = timeLabel;
    [self.contentView addSubview:_timeLabel];
}

- (void)setSourceLabel:(UILabel *)sourceLabel {
    sourceLabel.frame = CGRectMake(70, 39, 200, 21);
    sourceLabel.font = [UIFont systemFontOfSize:12.0];
    sourceLabel.textColor = [UIColor colorWithRed:180.0/255.0 green:180.0/255.0 blue:180.0/255.0 alpha:1.0];
    sourceLabel.textAlignment = NSTextAlignmentLeft;
    _sourceLabel = sourceLabel;
    [self.contentView addSubview:_sourceLabel];
}

- (void)setAvatarView:(UIImageView *)avatarView {
    avatarView.frame = CGRectMake(15, 15, 40, 40);
    avatarView.contentMode = UIViewContentModeScaleAspectFill;
    avatarView.layer.cornerRadius = 20;
    avatarView.layer.masksToBounds = YES;
    avatarView.userInteractionEnabled = YES;
    _avatarView = avatarView;
    [self.contentView addSubview:avatarView];
}

- (void)setWbtextLabel:(YYLabel *)wbtextLabel {
    wbtextLabel.frame = CGRectMake(10, 75, 0, 0);
    wbtextLabel.numberOfLines = 0;
    wbtextLabel.textColor = [UIColor blackColor];
    _wbtextLabel = wbtextLabel;
    [self.contentView addSubview:_wbtextLabel];
}

- (void)setThumbnailView:(UIImageView *)thumbnailView {
    thumbnailView.frame = CGRectMake(0, 0, 97, 97);
    thumbnailView.contentMode = UIViewContentModeScaleAspectFill;
    _thumbnailView = thumbnailView;
}
#pragma mark - reweet view

- (void)setRetweetView:(UIView *)retweetView {
    retweetView.frame = CGRectMake(0, 0, 320, 400);
    retweetView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    _retweetView = retweetView;
    [self.contentView addSubview:_retweetView];
}

- (void)setRetweetLabel:(YYLabel *)retweetLabel {
    retweetLabel.frame = CGRectMake(10, 10, 0, 0);
    retweetLabel.numberOfLines = 0;
    retweetLabel.textColor = [UIColor grayColor];
    _retweetLabel = retweetLabel;
    [self.retweetView addSubview:self.retweetLabel];
}

- (void)setRetweetThumbnailView:(UIImageView *)retweetThumbnailView {
    retweetThumbnailView.frame = CGRectMake(0, 0, 97, 97);
    retweetThumbnailView.contentMode = UIViewContentModeScaleAspectFill;
    _retweetThumbnailView = retweetThumbnailView;
}
#pragma mark - bottom view

- (void)setRepostView:(UIView *)repostView {
    repostView.frame = CGRectMake(0, 0, 107, 35);
    repostView.userInteractionEnabled = YES;
    _repostView = repostView;
}

- (void)setCommentView:(UIView *)commentView {
    commentView.frame = CGRectMake(107, 0, 106, 35);
    commentView.userInteractionEnabled = YES;
    _commentView = commentView;
}

- (void)setAttitudeView:(UIView *)attitudeView {
    attitudeView.frame = CGRectMake(213, 0, 107, 35);
    attitudeView.userInteractionEnabled = YES;
    _attitudeView = attitudeView;
}

- (void)setBottomView:(UIView *)bottomView {
    UIImageView *repostImageView = [UIImageView new];
    repostImageView.frame = CGRectMake(35, 10, 16, 16);
    repostImageView.image = [UIImage imageNamed:@"icon_repost"];
    self.repostLabel = [UILabel new];
    self.repostLabel.frame = CGRectMake(55, 10, 40, 16);
    self.repostLabel.font = [UIFont systemFontOfSize:14];
    self.repostLabel.textColor = [UIColor grayColor];
    
    UIImageView *commentImageView = [UIImageView new];
    commentImageView.frame = CGRectMake(35, 10, 16, 16);
    commentImageView.image = [UIImage imageNamed:@"icon_comment"];
    self.commentLabel = [UILabel new];
    self.commentLabel.frame = CGRectMake(55, 10, 40, 16);
    self.commentLabel.font = [UIFont systemFontOfSize:14.0];
    self.commentLabel.textColor = [UIColor grayColor];
    
    self.attitudeImageView = [UIImageView new];
    self.attitudeImageView.frame = CGRectMake(35, 10, 16, 16);
    self.attitudeImageView.image = [UIImage imageNamed:@"icon_zan_0"];
    self.attitudeLabel = [UILabel new];
    self.attitudeLabel.frame = CGRectMake(55, 10, 40, 16);
    self.attitudeLabel.font = [UIFont systemFontOfSize:14.0];
    self.attitudeLabel.textColor = [UIColor grayColor];
    
    bottomView.frame = CGRectMake(0, 0, 320, 35);
    _bottomView = bottomView;
    [self.contentView addSubview:_bottomView];
    [bottomView addSubview:self.repostView];
    [self.repostView addSubview:repostImageView];
    [self.repostView addSubview:self.repostLabel];
    
    [bottomView addSubview:self.commentView];
    [self.commentView addSubview:commentImageView];
    [self.commentView addSubview:self.commentLabel];
    
    [bottomView addSubview:self.attitudeView];
    [self.attitudeView addSubview:self.attitudeImageView];
    [self.attitudeView addSubview:self.attitudeLabel];
}

- (void)setGrayBarView:(UIView *)grayBarView {
    grayBarView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    grayBarView.frame = CGRectMake(0, 0, 320, 10);
    _grayBarView = grayBarView;
    [self.contentView addSubview:_grayBarView];
}

#pragma mark - Action method

- (void)checkProfileAction {
    [self.homeController checkProfile:self.row];
}

- (void)cellRepostAction {
    [self.homeController repostAction:self.id];
}

- (void)CellCommentAction {
    [self.homeController commentActionWithRow:self.row weiboid:self.id];
}

- (void)repostActionInProfile {
    // [self.profileController repostWeiboWithID:self.id];
}

- (void)commentActionInPfofile {
    //  [self.profileController commentWeiboWithID:self.id];
}

- (void)repostActionInMe {
    // [self.meViewController repostActionWithID:self.id];
}

- (void)commentActionInMe {
    // [self.meViewController commentActionWithID:self.id];
}

- (void)attitudeAction {
    UIImage *attitudeImage_0 = [UIImage imageNamed:@"icon_zan_0"];
    NSInteger attitudes_count;
    if ([self.attitudeImageView.image isEqual:attitudeImage_0]) {
        self.attitudeImageView.image = [UIImage imageNamed:@"icon_zan_1"];
        attitudes_count = self.attitudeLabel.text.integerValue + 1;
    }else {
        self.attitudeImageView.image = [UIImage imageNamed:@"icon_zan_0"];
        attitudes_count = self.attitudeLabel.text.integerValue - 1;
    }
    if (attitudes_count == 0) {
        self.attitudeLabel.text = @"赞";
    }else {
        self.attitudeLabel.text = [NSNumber numberWithInteger:attitudes_count].stringValue;
    }
}

- (void)_getRow {
    if (self.detailViewController) {
        [self.detailViewController checkImageWithRow:self.row viewTag:0];
    }else{
        [self.homeController checkImageWithRow:self.row viewTag:0];}
}

- (void)_getRowWithTwoImage:(UITapGestureRecognizer *)tapGestureRecognizer {
    NSInteger viewTag = tapGestureRecognizer.view.tag;
    if (self.detailViewController) {
        [self.detailViewController checkImageWithRow:self.row viewTag:viewTag];
    }else{
        [self.homeController checkImageWithRow:self.row viewTag:viewTag];}
}

- (void)_getRowWithRetweet {
    if (self.detailViewController) {
        [self.detailViewController checkRetweetImageWithRow:self.row viewTag:0];
    }else{
        [self.homeController checkRetweetImageWithRow:self.row viewTag:0];}
}

- (void)_getRowWithRetweet:(UITapGestureRecognizer *)tapGestureRecognizer {
    NSInteger viewTag = tapGestureRecognizer.view.tag;
    if (self.detailViewController) {
        [self.detailViewController checkRetweetImageWithRow:self.row viewTag:viewTag];
    }else{
        [self.homeController checkRetweetImageWithRow:self.row viewTag:viewTag];}
}

#pragma mark - Size frame of view

- (void)adjustHeightForLabel:(YYLabel *)label {
    UIFont *font = [UIFont systemFontOfSize:14.0];
    UIColor *color = label.textColor;
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          font, NSFontAttributeName,
                                          color, NSForegroundColorAttributeName,
                                          nil];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:label.text attributes:attributesDictionary];
    // 调整行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:6];
    [string addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [label.text length])];
    // 高亮状态背景
    YYTextBorder *highlightBorder = [YYTextBorder new];
    highlightBorder.insets = UIEdgeInsetsMake(-2, 0, -2, 0);
    highlightBorder.cornerRadius = 3;
    highlightBorder.fillColor = kWBCellTextHighlightBackgroundColor;
    
    // 匹配 @用户名
    NSArray *atResults = [[StatusHelper regexAt] matchesInString:string.string
                                                         options:kNilOptions
                                                           range:string.rangeOfAll];
    for (NSTextCheckingResult *at in atResults) {
        if (at.range.location == NSNotFound && at.range.length <= 1) {
            continue;
        }
        if ([string attribute:YYTextHighlightAttributeName atIndex:at.range.location] == nil) {
            [string setColor:kWBCellTextHighlightColor range:at.range];
            YYTextHighlight *highlight = [YYTextHighlight new]; // 高亮状态
            [highlight setBackgroundBorder:highlightBorder];
            // 数据信息，用于稍后用户点击
            highlight.userInfo = @{kWBLinkAtName : [string.string substringWithRange:NSMakeRange(at.range.location + 1, at.range.length - 1)]};
        }
    }
    
    // 匹配 [表情]
    NSArray<NSTextCheckingResult *> *emoticonResults = [[StatusHelper regexEmoticon] matchesInString:string.string options:kNilOptions range:string.string.rangeOfAll];
    NSUInteger emoClipLength = 0;
    for (NSTextCheckingResult *emo in emoticonResults) {
        if (emo.range.location == NSNotFound && emo.range.length <= 1) {
            continue;
        }
        NSRange range = emo.range;
        range.location -= emoClipLength;
        if ([string attribute:YYTextHighlightAttributeName atIndex:range.location]) {
            continue;
        }
        if ([string attribute:YYTextAttachmentAttributeName atIndex:range.location]) {
            continue;
        }
        NSString *emoString = [string.string substringWithRange:range];
        NSString *imagePath = [StatusHelper emoticonDic][emoString];
        UIImage *image = [StatusHelper imageWithPath:imagePath];
        if (!image) {
            continue;
        }
        NSAttributedString *emoText = [NSAttributedString attachmentStringWithEmojiImage:image fontSize:14.0];
        [string replaceCharactersInRange:range withAttributedString:emoText];
        emoClipLength += range.length - 1;
    }
    
    CGRect rect = [string boundingRectWithSize:CGSizeMake(305.f, CGFLOAT_MAX) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) context:nil];
    label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y, rect.size.width, rect.size.height);
    
    label.attributedText = string;
    [label sizeToFit];
}

- (void)setBmiddleViewWithUrl:(NSString *)picUrl withLabel:(YYLabel *)wbLabel{
    UIImageView *theImageView = [UIImageView new];
    theImageView.tag = 0;
    theImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_getRow)];
    [theImageView addGestureRecognizer:singleTapGestureRecognizer];
    theImageView.contentMode = UIViewContentModeScaleAspectFill;
    theImageView.clipsToBounds = YES;
    theImageView.frame = CGRectMake(10, wbLabel.frame.origin.y + wbLabel.frame.size.height + 10, 200, 150);
    [theImageView setImageWithURL:[NSURL URLWithString:picUrl] options:YYWebImageOptionProgressive];
    [self.contentView addSubview:theImageView];
    self.lastImageView = theImageView;
}

- (void)setThumbnailViewWithUrlArray:(NSArray *)picArray withLabel:(YYLabel *)wbLabel{
    NSMutableArray *imageArray = [NSMutableArray new];
    UIImageView *theImageView;
    if (picArray.count == 2) {
        for (int i = 0; i < picArray.count; i++) {
            theImageView = [UIImageView new];
            theImageView.tag = i;
            theImageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_getRowWithTwoImage:)];
            [theImageView addGestureRecognizer:singleTapGestureRecognizer];
            theImageView.contentMode = UIViewContentModeScaleAspectFill;
            theImageView.clipsToBounds = YES;
            theImageView.frame = CGRectMake(10 + i * (148 + 4), wbLabel.frame.origin.y + wbLabel.frame.size.height + 10, 148, 110);
            [theImageView setImageWithURL:picArray[i][@"thumbnail_pic"] options:YYWebImageOptionProgressive];
            [self.contentView addSubview:theImageView];
            if (i == 1) {
                self.lastImageView = [UIImageView new];
                self.lastImageView = theImageView;
            }
        }
    }else {
        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3; j++) {
                theImageView = [UIImageView new];
                theImageView.userInteractionEnabled = YES;
                UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_getRowWithTwoImage:)];
                [theImageView addGestureRecognizer:singleTapGestureRecognizer];
                theImageView.contentMode = UIViewContentModeScaleAspectFill;
                theImageView.clipsToBounds = YES;
                theImageView.frame = CGRectMake(10 + j * (97 + 4.5), wbLabel.frame.origin.y + wbLabel.frame.size.height + 10 + i * (97 + 4.5), 97, 97);
                [imageArray addObject:theImageView];
            }
        }
        for (NSInteger i = 0; i < picArray.count; i++) {
            NSURL *url = picArray[i][@"thumbnail_pic"];
            theImageView = imageArray[i];
            theImageView.tag = i;
            [theImageView setImageWithURL:url options:YYWebImageOptionProgressive];
            [self.contentView addSubview:theImageView];
            if (i == picArray.count - 1) {
                self.lastImageView = [UIImageView new];
                self.lastImageView = theImageView;
            }
        }
        [imageArray removeAllObjects];
    }
}

- (void)setRetweetBmiddleViewWithUrl:(NSString *)picUrl withLabel:(YYLabel *)retweetLabel {
    UIImageView *theImageView = [UIImageView new];
    theImageView.tag = 0;
    theImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_getRowWithRetweet)];
    [theImageView addGestureRecognizer:singleTapGestureRecognizer];
    theImageView.contentMode = UIViewContentModeScaleAspectFill;
    theImageView.clipsToBounds = YES;
    theImageView.frame = CGRectMake(10, retweetLabel.frame.origin.y + retweetLabel.frame.size.height + 10, 200, 150);
    [theImageView setImageWithURL:[NSURL URLWithString:picUrl] options:YYWebImageOptionProgressive];
    [self.retweetView addSubview:theImageView];
    self.lastRetweetImageView = theImageView;
}

- (void)setRetweetThumbnailViewWithUrlArray:(NSArray *)retweetPicArray withLabel:(YYLabel *)retweetLabel {
    NSMutableArray *imageArray = [NSMutableArray new];
    UIImageView *theImageView;
    if (retweetPicArray.count == 2) {
        for (int i = 0; i < retweetPicArray.count; i++) {
            theImageView = [UIImageView new];
            theImageView.tag = i;
            theImageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_getRowWithRetweet:)];
            [theImageView addGestureRecognizer:singleTapGestureRecognizer];
            theImageView.contentMode = UIViewContentModeScaleAspectFill;
            theImageView.clipsToBounds = YES;
            theImageView.frame = CGRectMake(10 + i * (148 + 4), retweetLabel.frame.origin.y + retweetLabel.frame.size.height + 10, 148, 110);
            [theImageView setImageWithURL:retweetPicArray[i][@"thumbnail_pic"] options:YYWebImageOptionProgressive];
            [self.retweetView addSubview:theImageView];
            if (i == 1) {
                self.lastRetweetImageView = [UIImageView new];
                self.lastRetweetImageView = theImageView;
            }
        }
    }else {
        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3; j++) {
                theImageView = [UIImageView new];
                theImageView.userInteractionEnabled = YES;
                UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_getRowWithRetweet:)];
                [theImageView addGestureRecognizer:singleTapGestureRecognizer];
                theImageView.contentMode = UIViewContentModeScaleAspectFill;
                theImageView.clipsToBounds = YES;
                theImageView.frame = CGRectMake(10 + j * (97 + 4.5), retweetLabel.frame.origin.y + retweetLabel.frame.size.height + 10 + i * (97 + 4.5), 97, 97);
                [imageArray addObject:theImageView];
            }
        }
        for (int i = 0; i < retweetPicArray.count; i++) {
            NSURL *url = retweetPicArray[i][@"thumbnail_pic"];
            theImageView = imageArray[i];
            theImageView.tag = i;
            [theImageView setImageWithURL:url options:YYWebImageOptionProgressive];
            [self.retweetView addSubview:theImageView];
            if (i == retweetPicArray.count - 1) {
                self.lastRetweetImageView = [UIImageView new];
                self.lastRetweetImageView = theImageView;
            }
        }
        [imageArray removeAllObjects];
    }
    
}

- (void)adjustHeightForRetweetView:(UIView *)retweetView {
    retweetView.frame = CGRectMake(0, self.wbtextLabel.frame.origin.y + self.wbtextLabel.frame.size.height + 10, 320, 400);
}

- (void)adjustHeightForBottomView:(UIView *)bottomView withView:(UIView *)lastView{
    bottomView.frame = CGRectMake(0, lastView.frame.origin.y + lastView.frame.size.height + 10, bottomView.frame.size.width, bottomView.frame.size.height);
}

- (void)sizeFrameOfRetweetView:(UIView *)retweetView withLastRetweetImageOrLabelView:(UIView *)theView{
    retweetView.frame = CGRectMake(retweetView.frame.origin.x, retweetView.frame.origin.y, retweetView.frame.size.width, theView.frame.origin.y + theView.frame.size.height + 10);
}

- (void)sizeFrameOfView:(UIView *)theView {
    theView.frame = CGRectMake(theView.frame.origin.x, theView.frame.origin.y - 10, theView.frame.size.width, theView.frame.size.height);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
