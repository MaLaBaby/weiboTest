//
//  LoginedSetViewController.m
//  weiboTest
//
//  Created by haitao on 17/1/10.
//  Copyright © 2017年 Haitao.xue. All rights reserved.
//

#import "LoginedSetViewController.h"
#import "SetCell.h"
#import "WeiboSDK.h"

@interface LoginedSetViewController ()

@end

@implementation LoginedSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"设置";
    
    //添加导航栏控件
    UIBarButtonItem *setBtn = [[UIBarButtonItem alloc]initWithTitle:@"<我" style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    [setBtn setTintColor:[UIColor blackColor]];
    self.navigationItem.leftBarButtonItem = setBtn;
    
    //初始化设置界面
    _setTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _setTableView.dataSource = self;
    _setTableView.delegate = self;
    _setTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.view addSubview:_setTableView];
    
    //初始化标题数组
    NSMutableArray *ary1 = [[NSMutableArray alloc]initWithObjects:@"账号管理",@"账号安全", nil];
    NSMutableArray *ary2 = [[NSMutableArray alloc]initWithObjects:@"消息设置",@"隐私",@"通用设置", nil];
    NSMutableArray *ary3 = [[NSMutableArray alloc]initWithObjects:@"清理缓存",@"意见反馈",@"客服中心",@"关于微博", nil];
    NSMutableArray *ary4 = [[NSMutableArray alloc]initWithObjects:@"退出当前账号", nil];
    _titleAry = [[NSMutableArray alloc] initWithObjects:ary1,ary2,ary3,ary4, nil];
}


#pragma mark UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }else if (section == 1){
        return 3;
    }else if (section == 2){
        return 4;
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(10.0, 0.0, 320.0, 100.0)];
    view.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"myCell";
    if (indexPath.section == 3&&indexPath.row == 0)
    {
        UILabel *logoutLab = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-60, 0, 120, 44)];
        logoutLab.text = [NSString stringWithFormat:@"%@", [[_titleAry objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
        logoutLab.textColor = [UIColor redColor];
        logoutLab.textAlignment = NSTextAlignmentCenter;
        logoutLab.font = [UIFont systemFontOfSize:16];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        }
        [cell addSubview:logoutLab];
        return cell;
    }else
    {
        SetCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[SetCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        }
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.desLab.text = [NSString stringWithFormat:@"%@", [[_titleAry objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
        if (indexPath.section == 2&&indexPath.row == 0)
        {
            cell.otherLab.text = [NSString stringWithFormat:@"%.2fM",[self folderSizeAtPath:NSHomeDirectory()]];
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2&&indexPath.row == 0)
    {
        //清除缓存操作
        CGFloat size = [self folderSizeAtPath:NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject] + [self folderSizeAtPath:NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject] + [self folderSizeAtPath:NSTemporaryDirectory()];
        
        NSString *message = size > 1 ? [NSString stringWithFormat:@"缓存%.2fM, 删除缓存", size] : [NSString stringWithFormat:@"缓存%.2fK, 删除缓存", size * 1024.0];
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:(UIAlertControllerStyleAlert)];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action)
        {
            [self cleanCaches:NSHomeDirectory()];
            [_setTableView reloadData];
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
        [alert addAction:action];
        [alert addAction:cancel];
        [self showDetailViewController:alert sender:nil];
    }else if (indexPath.section == 3&&indexPath.row == 0)
    {
        //退出登录操作
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确认退出?" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"确定"
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * _Nonnull action) {
                                                                  
                                                                  [WeiboSDK logOutWithToken:self.myDelegate.wbtoken delegate:self withTag:@"loginOut"];
                                                                  [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                                                              }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                               style:UIAlertActionStyleCancel
                                                             handler:nil];
        [alertController addAction:defaultAction];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController
                           animated:YES
                         completion:nil];

    }
}


- (void)cleanCaches:(NSString *)path{
    // 利用NSFileManager实现对文件的管理
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        // 获取该路径下面的文件名
        NSArray *childrenFiles = [fileManager subpathsAtPath:path];
        for (NSString *fileName in childrenFiles) {
            // 拼接路径
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            // 将文件删除
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
}
-(long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

-(float) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath])
        return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}

-(void)backAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)request:(WBHttpRequest *)request didReceiveResponse:(NSURLResponse *)response {
    if ([request.tag isEqualToString:@"loginOut"]) {
        NSLog(@"退出成功");
        //发送通知（我已经退出登录了）
        [[NSNotificationCenter defaultCenter]postNotificationName:@"未登录" object:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
