//
//  VideoInformationCell.h
//  VIdeoTest
//
//  Created by haitao on 17/2/13.
//  Copyright © 2017年 Haitao.xue. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Model;

@interface VideoInformationCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *CoverImageView;

@property (strong, nonatomic) IBOutlet UIImageView *playImageView;

@property (strong, nonatomic) IBOutlet UIImageView *rightImagView;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) Model *videoItem;
+ (VideoInformationCell *)videoCellWithTableView:(UITableView *)tableview;

@end
