//
//  AddCityTableViewController.m
//  新闻
//
//  Created by 薛海涛 on 16/4/12.
//  Copyright © 2016年 薛海涛. All rights reserved.
//

#import "AddCityTableViewController.h"
#import "AppDelegate.h"
#import "WeatherViewController.h"
#define selectProvince 0
#define selectCity 1
@interface AddCityTableViewController ()

@end

@implementation AddCityTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc]init];
    NSString *addressPath = [[NSBundle mainBundle]pathForResource:@"address" ofType:@"plist"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithContentsOfFile:addressPath];
    self.provinces = [dic objectForKey:@"address"];
    
    
    if (self.selectType == selectProvince)
    {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    }else
    {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(submit)];
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }

}
- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)submit
{
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    WeatherViewController *tao = [[WeatherViewController alloc]initWithNibName:@"WeatherViewController" bundle:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
    [del.selectedCities addObject:self.selectedCity];
    del.selectedCity = self.selectedCity;
    NSString *addressPath = [[NSBundle mainBundle]pathForResource:@"cityList" ofType:@"plist"];
    NSMutableDictionary *Citydic = [[NSMutableDictionary alloc]initWithContentsOfFile:addressPath];
    for (NSString *str in [Citydic allKeys] )
    {
        if ([del.selectedCity containsString:str])
        {
            del.selectedCityNum = [Citydic objectForKey:str];
            NSLog(@"%@",del.selectedCityNum);
            [del.selectedCityDic setObject:del.selectedCityNum forKey:del.selectedCity];
            
        }
    }
    [tao getWeatherInfo:del.selectedCityNum];
    NSLog(@"count = %lu",(unsigned long)del.selectedCityDic.count);
    NSLog(@"%@",del.selectedCityDic);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.selectType == selectProvince)
    {
        return self.provinces.count;
    }else
    {
        return self.cities.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    if (self.selectType == selectProvince)
    {
        cell.textLabel.text = [[self.provinces objectAtIndex:indexPath.row] objectForKey:@"name"];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }else
    {
        cell.textLabel.text = [self.cities[indexPath.row] objectForKey:@"name"];
        if ([self.selectedCity isEqualToString:[self.cities[indexPath.row] objectForKey:@"name"]])
        {
            cell.imageView.image = [UIImage imageNamed:@"checked"];
        }else
        {
            cell.imageView.image = [UIImage imageNamed:@"unchecked"];
        }
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //    for (NSString *str in [del.selectedCityDic allKeys])
    //    {
    //        if ([self.selectedCity containsString:str])
    //        {
    //            self.navigationItem.rightBarButtonItem.enabled = NO;
    //            break;
    //        }else
    //        {
    //            self.navigationItem.rightBarButtonItem.enabled = YES;
    //        }
    //    }
    self.navigationItem.rightBarButtonItem.enabled = YES;
    if (self.selectType == selectProvince)
    {
        NSDictionary *province = self.provinces[indexPath.row];
        NSArray *citys = [province objectForKey:@"sub"];
        AddCityTableViewController *addview = [[AddCityTableViewController alloc]init];
        addview.cities = citys;
        addview.selectType = selectCity;
        [self.navigationController pushViewController:addview animated:YES];
    }else
    {
        self.selectedCity = [self.cities[indexPath.row] objectForKey:@"name"];
        AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        for (NSString *str in [del.selectedCityDic allKeys])
        {
            if ([self.selectedCity containsString:str])
            {
                self.navigationItem.rightBarButtonItem.enabled = NO;
                break;
            }else
            {
                self.navigationItem.rightBarButtonItem.enabled = YES;
            }
        }
        
        [tableView reloadData];
    }
}

@end
