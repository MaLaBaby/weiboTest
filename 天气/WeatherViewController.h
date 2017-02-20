//
//  WeatherViewController.h
//  新闻
//
//  Created by 薛海涛 on 16/4/12.
//  Copyright © 2016年 薛海涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (nonatomic, retain) UIScrollView *scrollview;
@property (nonatomic, retain) UIPageControl *pageControl1;
@property (nonatomic, retain) UITableView *infoView;
@property (nonatomic, retain) NSMutableArray *weatherInfoArray;
@property (nonatomic, retain) NSMutableArray *weatherArray;
@property (nonatomic, retain) NSMutableArray *tableviewsArray;
@property (nonatomic, retain) NSString *currentCity;
- (void)getWeatherInfo:(NSString *)weatherNum;

- (void)createScrollerview;
- (void)createPageController;
- (void)createInfoView:(NSInteger) n;
@end
