//
//  AddCityTableViewController.h
//  新闻
//
//  Created by 薛海涛 on 16/4/12.
//  Copyright © 2016年 薛海涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddCityTableViewController : UITableViewController
@property (nonatomic,retain) NSArray *provinces;
@property (nonatomic,retain) NSArray *cities;
@property (nonatomic,retain) NSArray *areas;
@property (nonatomic,assign) int selectType;
@property (nonatomic,retain) NSString *selectedCity;
@end
