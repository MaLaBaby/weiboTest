//
//  IndexTableViewCell.h
//  新闻
//
//  Created by 薛海涛 on 16/4/12.
//  Copyright © 2016年 薛海涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IndexTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *indPicImageview;
@property (strong, nonatomic) IBOutlet UILabel *indexTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *indexDegreeLabel;
@property (strong, nonatomic) IBOutlet UILabel *indexDescLabel;

@end
