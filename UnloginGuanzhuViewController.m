//
//  UnloginGuanzhuViewController.m
//  weiboTest
//
//  Created by haitao on 17/1/10.
//  Copyright © 2017年 Haitao.xue. All rights reserved.
//

#import "UnloginGuanzhuViewController.h"

@interface UnloginGuanzhuViewController ()

@end

@implementation UnloginGuanzhuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
    self.title = @"关注";
    
    self.guanzhuTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.guanzhuTableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:_guanzhuTableView];
    
    UIBarButtonItem *setBtn = [[UIBarButtonItem alloc]initWithTitle:@"<我" style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    [setBtn setTintColor:[UIColor blackColor]];
    self.navigationItem.leftBarButtonItem = setBtn;
    
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
