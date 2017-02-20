//
//  MessageViewController.m
//  weiboTest
//
//  Created by haitao on 17/1/18.
//  Copyright © 2017年 Haitao.xue. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageCell.h"
#import "AtMeViewController.h"
#import "CommentMeController.h"
#import "AttitudeMeViewController.h"

static NSString *identifier = @"Cell";

@interface MessageViewController ()

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _myTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44)];
    [self.view addSubview:_myTableview];
    _myTableview.delegate = self;
    _myTableview.dataSource = self;
    _myTableview.tableFooterView = [[UIView alloc] init];
    _infoArray = [[NSMutableArray alloc]initWithObjects:@"艾特",@"icon_comment",@"icon_zan_0", nil];
    _detailArray = [[NSMutableArray alloc]initWithObjects:@"@我的",@"评论",@"赞", nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 10+60+10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.photoImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [_infoArray objectAtIndex:indexPath.row]]];
    cell.titleLabel.text = [_detailArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        AtMeViewController *atMeView = [[AtMeViewController alloc]init];
        [self.navigationController pushViewController:atMeView animated:YES];
    }else if (indexPath.row == 1){
        CommentMeController *commentMeView = [[CommentMeController alloc]init];
        [self.navigationController pushViewController:commentMeView animated:YES];
    }else if (indexPath.row == 2){
        AttitudeMeViewController *attitudeMeView = [[AttitudeMeViewController alloc]init];
        [self.navigationController pushViewController:attitudeMeView animated:YES];
    }
    // 取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
