//
//  AttitudeMeViewController.m
//  weiboTest
//
//  Created by haitao on 17/1/22.
//  Copyright © 2017年 Haitao.xue. All rights reserved.
//

#import "AttitudeMeViewController.h"

@interface AttitudeMeViewController ()

@end

@implementation AttitudeMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"赞";
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    self.tabBarController.tabBar.hidden = NO;
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
