//
//  IndexTableViewCell.m
//  新闻
//
//  Created by 薛海涛 on 16/4/12.
//  Copyright © 2016年 薛海涛. All rights reserved.
//

#import "IndexTableViewCell.h"

@implementation IndexTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.indexTitleLabel.textColor = [UIColor whiteColor];
    self.indexDescLabel.textColor = [UIColor whiteColor];
    self.indexDegreeLabel.textColor = [UIColor whiteColor];
    self.indexDescLabel.font = [UIFont fontWithName:@"Arial" size:13];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
