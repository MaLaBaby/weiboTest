//
//  WeatherViewController.m
//  新闻
//
//  Created by 薛海涛 on 16/4/12.
//  Copyright © 2016年 薛海涛. All rights reserved.
//

#import "WeatherViewController.h"
#import "WeatherInfoTableViewCell.h"
#import "FutureWeatherTableViewCell.h"
#import "TitleTableViewCell.h"
#import "IndexTableViewCell.h"
#import "AddCityTableViewController.h"
#import "EditCityTableViewController.h"
#import "AppDelegate.h"
@interface WeatherViewController ()

@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [NSThread sleepForTimeInterval:3.0];
    _weatherInfoArray = [[NSMutableArray alloc]init]; //对存放天气信息的数组进行初始化
    [self enterView];                                 //调用enterView方法
}
- (void)enterView
{
    [super viewDidLoad];
    
    _tableviewsArray = [[NSMutableArray alloc]init];    //对存放tableView的数组进行初始化
    _weatherArray = [[NSMutableArray alloc]init];       //对存放weather的数组进行初始化
    [self createScrollerview];
    [self createPageController];
    [self createImageView];
    [self createTopView];
}
- (void)createTopView
{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 70)];
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 20, 32, 32)];
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 52, 20, 32, 32)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"shezhi"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(shezhiAction) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(addCityAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    [topView addSubview:leftBtn];
    [topView addSubview:rightBtn];
    [self.view addSubview:topView];
}
- (void)createScrollerview
{
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSInteger n = del.selectedCityDic.count;
    
    self.scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:self.scrollview];
    self.scrollview.delegate = self;
    _scrollview.contentSize = CGSizeMake(self.view.frame.size.width * n, 0);
    _scrollview.pagingEnabled = YES;
}
- (void)createPageController
{
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSInteger n = del.selectedCityDic.count;
    
    self.pageControl1 = [[UIPageControl alloc]init];
    _pageControl1.center = CGPointMake(self.view.frame.size.width / 2, 60);
    _pageControl1.bounds = CGRectMake(0, 0, 100, 30);
    _pageControl1.numberOfPages = n;
    _pageControl1.enabled = NO;
    _pageControl1.pageIndicatorTintColor = [UIColor whiteColor];
    _pageControl1.currentPageIndicatorTintColor = [UIColor blueColor];
    [self.view addSubview:_pageControl1];
}
- (void)createInfoView:(NSInteger) n
{
    _infoView = [[UITableView alloc]initWithFrame:CGRectMake(self.view.frame.size.width * n, self.view.frame.size.height / 2, self.view.frame.size.width, self.view.frame.size.height / 2 - 44 )];
    _infoView.backgroundColor = [UIColor clearColor];
    _infoView.separatorColor = [UIColor colorWithWhite:1 alpha:0.2];
    [_scrollview addSubview:_infoView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _infoView.dataSource = self;
    _infoView.delegate = self;
    _infoView.tag = n + 100;
    [_tableviewsArray addObject:_infoView];
}
- (void)createImageView
{
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSInteger n = del.selectedCityDic.count;
    for (int i = 0; i < n; i ++)
    {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width * i, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [self.scrollview addSubview:imageView];
        UILabel *cityLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 120, self.view.frame.size.width, 70)];
        NSString *str = del.selectedCities[i];
        cityLabel.text = str;
        cityLabel.textAlignment = NSTextAlignmentCenter;
        cityLabel.textColor = [UIColor whiteColor];
        cityLabel.font = [UIFont fontWithName:@"Arial" size:45];
        [imageView addSubview:cityLabel];
        [self getWeatherInfo:[del.selectedCityDic objectForKey:str]];
        // NSLog(@"str = %@%@",str,[del.selectedCityDic objectForKey:str]);
        
        if ([[_weatherArray[i][2][0] objectForKey:@"weather"] containsString:@"晴"])
        {
            imageView.image = [UIImage imageNamed:@"晴天.jpg"];
        }
        else if([[_weatherArray[i][2][0] objectForKey:@"weather"] containsString:@"云"])
        {
            imageView.image = [UIImage imageNamed:@"云.jpg"];
        }else if([[_weatherArray[i][2][0] objectForKey:@"weather"] containsString:@"雷"])
        {
            imageView.image = [UIImage imageNamed:@"雷.jpg"];
        }else if([[_weatherArray[i][2][0] objectForKey:@"weather"] containsString:@"沙"])
        {
            imageView.image = [UIImage imageNamed:@"沙.jpg"];
        }else if([[_weatherArray[i][2][0] objectForKey:@"weather"] containsString:@"雾"])
        {
            imageView.image = [UIImage imageNamed:@"雾.jpg"];
        }else if([[_weatherArray[i][2][0] objectForKey:@"weather"] containsString:@"雪"])
        {
            imageView.image = [UIImage imageNamed:@"雪.jpg"];
        }else if([[_weatherArray[i][2][0] objectForKey:@"weather"] containsString:@"雨"])
        {
            imageView.image = [UIImage imageNamed:@"下雨.jpg"];
        }else
        {
            imageView.image = [UIImage imageNamed:@"晴天.jpg"];
        }
        
        [self createInfoView:i];
    }
}


- (void)getWeatherInfo:(NSString *)weatherNum
{
    NSString *str = [NSString stringWithFormat:@"http://weatherapi.market.xiaomi.com/wtr-v2/weather?cityId=%@",weatherNum];
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    NSData *weatherData = [NSURLConnection sendSynchronousRequest:req returningResponse:nil error:nil];
    NSDictionary *weatherDic = [NSJSONSerialization JSONObjectWithData:weatherData options:NSJSONReadingMutableLeaves error:nil];
    NSMutableArray *weatherArray = [[NSMutableArray alloc]init];
    NSMutableArray *weatherArray2 = [[NSMutableArray alloc]init];
    NSMutableArray *indexArray = [[NSMutableArray alloc]init];
    NSMutableArray *codeArray = [[NSMutableArray alloc]init];
    NSMutableArray *detailsArray = [[NSMutableArray alloc]init];
    NSMutableArray *zhishuImageArray = [[NSMutableArray alloc]initWithObjects:@"防晒",@"穿衣",@"运动",@"洗车",@"晾晒", nil];
    
    [weatherArray addObject:[weatherDic objectForKey:@"realtime"]];
    [weatherArray addObject:[weatherDic objectForKey:@"aqi"]];
    [weatherArray addObject:[weatherDic objectForKey:@"today"]];
    [weatherArray addObject:[weatherDic objectForKey:@"accu_cc"]];
    
    NSArray *arr1 = [[NSArray alloc]initWithObjects:@"明天",[[weatherDic objectForKey:@"forecast"] objectForKey:@"weather3"],[[weatherDic objectForKey:@"forecast"] objectForKey:@"temp3"], nil];
    NSArray *arr2 = [[NSArray alloc]initWithObjects:@"后天",[[weatherDic objectForKey:@"forecast"] objectForKey:@"weather4"],[[weatherDic objectForKey:@"forecast"] objectForKey:@"temp4"], nil];
    
    [weatherArray2 addObject:arr1];
    [weatherArray2 addObject:arr2];
    
    
    NSArray *ary =[weatherDic objectForKey:@"index"];
    
    for (int i = 0; i < 5;i++ )
    {
        [detailsArray addObject:[ary[i] objectForKey:@"details"]];
        [codeArray addObject:[ary[i] objectForKey:@"name"]];
        [indexArray addObject:[ary[i] objectForKey:@"index"]];
    }
    
    
    
    _weatherInfoArray = [[NSMutableArray alloc]init];
    [_weatherInfoArray addObject:[[weatherDic objectForKey:@"realtime"] objectForKey:@"weather"]];
    [_weatherInfoArray addObject:zhishuImageArray = [[NSMutableArray alloc]initWithObjects:@"防晒",@"穿衣",@"运动",@"洗车",@"晾晒", nil]];
    [_weatherInfoArray addObject:weatherArray];
    [_weatherInfoArray addObject:weatherArray2];
    [_weatherInfoArray addObject:detailsArray];
    [_weatherInfoArray addObject:codeArray];
    [_weatherInfoArray addObject:indexArray];
    [_weatherArray addObject:_weatherInfoArray];
    
}



- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:YES];
    [self.scrollview removeFromSuperview];
    [self enterView];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = self.scrollview.contentOffset.x / self.scrollview.frame.size.width;
    self.pageControl1.currentPage = page;
}
- (void)shezhiAction
{
    EditCityTableViewController *editView = [[EditCityTableViewController alloc]init];
    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:editView];
    [self presentViewController:nav1 animated:YES completion:nil];
}
- (void)addCityAction
{
    AddCityTableViewController *addview = [[AddCityTableViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:addview];
    [self presentViewController:nav animated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }else if (section == 1)
    {
        return 3;
    }
    return 6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return self.view.frame.size.height/2;
    }else if (indexPath.section == 1)
    {
        return 43 ;
    }else{
        if (indexPath.row == 0) {
            return 43;
        }
        return 136;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    for (int i = 0 ; i < _tableviewsArray.count; i++)
    {
        if (tableView == _tableviewsArray[i])
        {
            if (indexPath.section == 0)
            {
                UINib *nib = [UINib nibWithNibName:@"WeatherInfoTableViewCell" bundle:nil];
                [tableView registerNib:nib forCellReuseIdentifier:@"cellID"];
                WeatherInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
                cell.backgroundColor = [UIColor clearColor];
                NSString *weatherStr = [_weatherArray[i][2][0] objectForKey:@"weather"];
                //                NSString *weatherStr = @"风";
                
                if ([weatherStr containsString:@"晴"])
                {
                    cell.weatherImage.image = [UIImage imageNamed:@"123"];
                }else if ([weatherStr containsString:@"雹"])
                {
                    cell.weatherImage.image = [UIImage imageNamed:@"冰雹"];
                }else if ([weatherStr containsString:@"雾"])
                {
                    cell.weatherImage.image = [UIImage imageNamed:@"大雾"];
                }else if ([weatherStr containsString:@"雪"])
                {
                    cell.weatherImage.image = [UIImage imageNamed:@"大雪"];
                }else if ([weatherStr containsString:@"云"])
                {
                    cell.weatherImage.image = [UIImage imageNamed:@"多云"];
                }else if ([weatherStr containsString:@"沙"])
                {
                    cell.weatherImage.image = [UIImage imageNamed:@"沙尘暴"];
                }else if ([weatherStr containsString:@"雨"])
                {
                    cell.weatherImage.image = [UIImage imageNamed:@"中雨"];
                }else
                {
                    cell.weatherImage.image = [UIImage imageNamed:@"未知"];
                }
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                cell.weatherLabel.text = weatherStr;
                cell.Pm25Label.text = [_weatherArray[i][2][1] objectForKey:@"pm25"];
                cell.updataDateLabel.text = [_weatherArray[i][2][2] objectForKey:@"date"];
                cell.tempLabel.text = [NSString stringWithFormat:@"%@℃",[_weatherArray[i][2][3] objectForKey:@"RealFeelTemperature"]];
                cell.tempRangeLabel.text = [NSString stringWithFormat:@"%@℃ ~ %@℃",[_weatherArray[i][2][2] objectForKey:@"tempMin"],[_weatherArray[i][2][2] objectForKey:@"tempMax"]];
                int pm25 = [[_weatherArray[i][2][1] objectForKey:@"pm25"] intValue];
                if (pm25 <= 50)
                {
                    cell.Pm25Image.image = [UIImage imageNamed:@"11"];
                }else if (50 < pm25 && pm25<=100)
                {
                    cell.Pm25Image.image = [UIImage imageNamed:@"22"];
                }else if (100 < pm25 && pm25<=150)
                {
                    cell.Pm25Image.image = [UIImage imageNamed:@"33"];
                }else
                {
                    cell.Pm25Image.image = [UIImage imageNamed:@"44"];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                return cell;
            }else if (indexPath.section == 1)
            {
                UINib *nib = [UINib nibWithNibName:@"FutureWeatherTableViewCell" bundle:nil];
                [tableView registerNib:nib forCellReuseIdentifier:@"cellID"];
                FutureWeatherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
                
                
                UINib *titleNib = [UINib nibWithNibName:@"TitleTableViewCell" bundle:nil];
                [tableView registerNib:titleNib forCellReuseIdentifier:@"titleCellID"];
                TitleTableViewCell *titleCell = [tableView dequeueReusableCellWithIdentifier:@"titleCellID"];
                if (indexPath.row == 0)
                {
                    titleCell.titleLabel.text = @"预报";
                    titleCell.backgroundColor = [UIColor clearColor];
                    titleCell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return titleCell;
                }else
                {
                    cell.backgroundColor = [UIColor clearColor];
                    cell.weekdayLabel.text = _weatherArray[i][3][indexPath.row - 1][0];
                    cell.weatherLabel.text = _weatherArray[i][3][indexPath.row - 1][1];
                    cell.tempRangeLabel.text = _weatherArray[i][3][indexPath.row - 1][2];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return cell;
                }
            }else if (indexPath.section == 2)
            {
                UINib *indexNib = [UINib nibWithNibName:@"IndexTableViewCell" bundle:nil];
                [tableView registerNib:indexNib forCellReuseIdentifier:@"indexCellID"];
                IndexTableViewCell *indexCell = [tableView dequeueReusableCellWithIdentifier:@"indexCellID"];
                UINib *titleNib = [UINib nibWithNibName:@"TitleTableViewCell" bundle:nil];
                [tableView registerNib:titleNib forCellReuseIdentifier:@"titleCellID"];
                TitleTableViewCell *titleCell = [tableView dequeueReusableCellWithIdentifier:@"titleCellID"];
                if (indexPath.row == 0)
                {
                    titleCell.titleLabel.text = @"指数";
                    titleCell.backgroundColor = [UIColor clearColor];
                    titleCell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return titleCell;
                }else
                {
                    indexCell.indexTitleLabel.text = _weatherArray[i][5][indexPath.row - 1];
                    indexCell.indexDegreeLabel.text = _weatherArray[i][6][indexPath.row - 1];
                    indexCell.indexDescLabel.text = _weatherArray[i][4][indexPath.row - 1];
                    indexCell.indPicImageview.image = [UIImage imageNamed:_weatherArray[i][1][indexPath.row - 1]];
                    indexCell.backgroundColor = [UIColor clearColor];
                    indexCell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return indexCell;
                }
            }
        }
    }
    
    return nil;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
