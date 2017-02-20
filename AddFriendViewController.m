//
//  AddFriendViewController.m
//  weiboTest
//
//  Created by haitao on 17/1/10.
//  Copyright © 2017年 Haitao.xue. All rights reserved.
//

#import "AddFriendViewController.h"

@interface AddFriendViewController ()

@end

@implementation AddFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
    self.title = @"添加好友";
    
    UIBarButtonItem *setBtn = [[UIBarButtonItem alloc]initWithTitle:@"<我" style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    [setBtn setTintColor:[UIColor blackColor]];
    self.navigationItem.leftBarButtonItem = setBtn;
    
}

-(void)backAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}- (void)didReceiveMemoryWarning {
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
