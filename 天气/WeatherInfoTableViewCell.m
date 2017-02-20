//
//  WeatherInfoTableViewCell.m
//  新闻
//
//  Created by 薛海涛 on 16/4/12.
//  Copyright © 2016年 薛海涛. All rights reserved.
//

#import "WeatherInfoTableViewCell.h"

@implementation WeatherInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.weatherLabel.textColor = [UIColor whiteColor];
    self.weatherLabel.font = [UIFont fontWithName:@"Arial" size:20];
    self.Pm25Label.textColor = [UIColor whiteColor];
    self.Pm25Label.font = [UIFont fontWithName:@"Arial" size:20];
    self.tempRangeLabel.textColor = [UIColor whiteColor];
    self.tempRangeLabel.font = [UIFont fontWithName:@"Arial" size:20];
    self.tempLabel.textColor = [UIColor whiteColor];
    self.tempLabel.font = [UIFont fontWithName:@"Arial" size:70];
    self.updataDateLabel.textColor = [UIColor whiteColor];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
