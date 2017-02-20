//
//  UnloginSetViewController.m
//  weiboTest
//
//  Created by haitao on 17/1/10.
//  Copyright © 2017年 Haitao.xue. All rights reserved.
//

#import "UnloginSetViewController.h"

@interface UnloginSetViewController ()

@end

@implementation UnloginSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    self.title = @"设置";
    self.setTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:_setTableview];
    self.setTableview.tableFooterView = [[UIView alloc]init];
    self.setTableview.delegate = self;
    self.setTableview.dataSource = self;
    
    self.titleArray = [[NSMutableArray alloc]initWithObjects:@"通用设置",@"客服中心",@"关于微博", nil];
    
    UIBarButtonItem *setBtn = [[UIBarButtonItem alloc]initWithTitle:@"<我" style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    [setBtn setTintColor:[UIColor blackColor]];
    self.navigationItem.leftBarButtonItem = setBtn;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else
        return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"myCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0) {
        cell.textLabel.text = self.titleArray[indexPath.row];
    }else{
        cell.textLabel.text = self.titleArray[indexPath.row + 1];
    }
    return cell;
}

-(void)backAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
