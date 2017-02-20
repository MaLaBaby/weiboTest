//
//  MyViewController.m
//  weiboTest
//
//  Created by yaopeng on 16/12/26.
//  Copyright © 2016年 Haitao.xue. All rights reserved.
//

#import "MyViewController.h"
#import "WeiboSDK.h"
#import "WeiboAPIMacro.h"
#import "myCell.h"
#import "mineCell.h"
#import "UnloginSetViewController.h"
#import "UnloginGuanzhuViewController.h"
#import "LoginedSetViewController.h"
#import "AddFriendViewController.h"
#import "MJRefresh.h"
#import "FindViewController.h"



@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化存储标题的数组
    _titleArray = [[NSMutableArray alloc]init];
    NSMutableArray *ary1 = [[NSMutableArray alloc]initWithObjects:@"新的好友",@"新手任务", nil];
    NSMutableArray *ary2 = [[NSMutableArray alloc]initWithObjects:@"我的相册",@"我的点评",@"我的赞", nil];
    NSMutableArray *ary3 = [[NSMutableArray alloc]initWithObjects:@"微博钱包",@"微博运动", nil];
    NSMutableArray *ary4 = [[NSMutableArray alloc]initWithObjects:@"草稿箱", nil];
    NSMutableArray *ary5 = [[NSMutableArray alloc]initWithObjects:@"更多", nil];
    [_titleArray addObject:ary1];
    [_titleArray addObject:ary2];
    [_titleArray addObject:ary3];
    [_titleArray addObject:ary4];
    [_titleArray addObject:ary5];
    
    
    //初始化存储标题图片的数组
    _titleImgArray = [[NSMutableArray alloc]init];
    NSMutableArray *imgary1 = [[NSMutableArray alloc]initWithObjects:@"朋友",@"任务", nil];
    NSMutableArray *imgary2 = [[NSMutableArray alloc]initWithObjects:@"相册",@"点评",@"赞", nil];
    NSMutableArray *imgary3 = [[NSMutableArray alloc]initWithObjects:@"钱包",@"运动", nil];
    NSMutableArray *imgary4 = [[NSMutableArray alloc]initWithObjects:@"草稿箱", nil];
    NSMutableArray *imgary5 = [[NSMutableArray alloc]initWithObjects:@"更多", nil];
    [_titleImgArray addObject:imgary1];
    [_titleImgArray addObject:imgary2];
    [_titleImgArray addObject:imgary3];
    [_titleImgArray addObject:imgary4];
    [_titleImgArray addObject:imgary5];
    
    
    //设置代理
    self.myDelegate = [UIApplication sharedApplication].delegate;
    
    //初始化未登录状态界面
    [self initView];
    
    //添加通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginedView) name:@"已登录" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(unloginedView) name:@"未登录" object:nil];

}

-(void)loginedView
{
    
    //登录过后隐藏未登录状态界面
    _mytableview.alpha = 0;
    _mytableview.hidden = YES;
    
    //初始化登录状态界面
    _loginTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64-49)];
    _loginTableView.dataSource = self;
    _loginTableView.delegate = self;
    
    //这句代码解决了cell之间左边分割线短一截
    _loginTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.view addSubview:_loginTableView];
    
    //初始化导航栏设置按钮
    UIBarButtonItem *setBtn = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(loginedSetAction)];
    [setBtn setTintColor:[UIColor blackColor]];
    self.navigationItem.rightBarButtonItem = setBtn;

    UIBarButtonItem *addFriendBtn = [[UIBarButtonItem alloc]initWithTitle:@"添加好友" style:UIBarButtonItemStylePlain target:self action:@selector(addFriendAction)];
    [addFriendBtn setTintColor:[UIColor blackColor]];
    self.navigationItem.leftBarButtonItem = addFriendBtn;
    
    //设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(hander)];
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=60; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
        [idleImages addObject:image];
    }
    [header setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [refreshingImages addObject:image];
    }
    [header setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [header setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
    //设置文字
    [header setTitle:@"这是下拉刷新显示的文字" forState:MJRefreshStateIdle];
    [header setTitle:@"快放开手啦" forState:MJRefreshStatePulling];
    [header setTitle:@"人家正在加载哦" forState:MJRefreshStateRefreshing];
    
    //设置字体
    header.stateLabel.font = [UIFont systemFontOfSize:15];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
    
    //设置颜色
    header.stateLabel.textColor = [UIColor redColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor blueColor];
    
    //设置header
    _loginTableView.mj_header = header;
    
    //添加上拉刷新（同理）
    _loginTableView.mj_footer = [MJRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(footer)];
    
    //初始化存储个人信息的字典
    _infoDic = [[NSMutableDictionary alloc]init];
    
    //获取个人信息
    [self getUserInfo];
}

#pragma mark 下拉刷新

- (void)hander
{
    //多线程  延时调用
    [self getUserInfo];
    [self performSelector:@selector(addMore) withObject:nil afterDelay:0];
}

- (void)addMore
{
    [_loginTableView reloadData];
    [_loginTableView.mj_header endRefreshing];
}

- (void)footer
{
    [_loginTableView reloadData];
    [_loginTableView.mj_header endRefreshing];
}

-(void)unloginedView
{
    //添加tableView
    _mytableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _mytableview.dataSource = self;
    _mytableview.delegate = self;
    _mytableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mytableview.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_mytableview];
    
    
    
    //添加导航栏按钮
    UIBarButtonItem *setBtn = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(unloginSetAction)];
    [setBtn setTintColor:[UIColor blackColor]];
    self.navigationItem.rightBarButtonItem = setBtn;
    
    self.navigationItem.leftBarButtonItem = nil;
}

/*初始化视图和控件*/
-(void)initView
{
    //初始化未登录状态界面
    _mytableview = [[UITableView alloc]initWithFrame:CGRectMake(0, -80, self.view.frame.size.width, self.view.frame.size.height+80)];
    _mytableview.dataSource = self;
    _mytableview.delegate = self;
    _mytableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mytableview.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_mytableview];
    
    
    
    //添加导航栏按钮
    UIBarButtonItem *setBtn = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(unloginSetAction)];
    [setBtn setTintColor:[UIColor blackColor]];
    self.navigationItem.rightBarButtonItem = setBtn;
    
  
}

-(void)addFriendAction
{
    //添加好友事件
    AddFriendViewController *addfriendView = [[AddFriendViewController alloc]init];
    UINavigationController *navAddFriend = [[UINavigationController alloc]initWithRootViewController:addfriendView];
    [self presentViewController:navAddFriend animated:YES completion:nil];
}

-(void)loginedSetAction
{
    //登录后设置事件
    LoginedSetViewController *loginedSetView = [[LoginedSetViewController alloc]init];
    UINavigationController *navLoginedSet = [[UINavigationController alloc]initWithRootViewController:loginedSetView];
    [self presentViewController:navLoginedSet animated:YES completion:nil];
}

-(void)unloginSetAction
{
    //未登录设置事件
    UnloginSetViewController *UnloginSetView = [[UnloginSetViewController alloc]init];
    UINavigationController *navUnloginSet = [[UINavigationController alloc]initWithRootViewController:UnloginSetView];
    navUnloginSet.tabBarController.title = @"设置";
    [self presentViewController:navUnloginSet animated:YES completion:nil];
}




#pragma mark - UITableViewDataSource



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == _mytableview) {
        return 1;
    }else if(tableView == _loginTableView)
    {
        return 6;
    }else
        return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _mytableview)
    {
        return 3;
    }else if(tableView == _loginTableView)
    {
        if (section == 0)
        {
            return 1;
        }else if (section == 1)
        {
            return 2;
        }else if (section == 2)
        {
            return 3;
        }else if (section == 3)
        {
            return 2;
        }else if (section == 4)
        {
            return 1;
        }else
        {
            return 1;
        }
    }else
        return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _mytableview)
    {
        if (indexPath.row == 0) {
            return 260;
        }else if (indexPath.row == 1)
        {
            return 40;
        }else
            return self.view.frame.size.height - (180+40+84);
    }else if(tableView == _loginTableView)
    {
        if (indexPath.section == 0)
        {
            return 150;
        }else
        {
            return 44;
        }
    }else
        return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

//-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(10.0, 0.0, 320.0, 100.0)];
//    view.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
//    return view;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _mytableview)
    {
        NSString *CellIdentifier = @"SinaCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (indexPath.row == 0) {
            //添加登录界面默认背景
            UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 260)];
            imgView.image = [UIImage imageNamed:@"loginImage.jpg"];
            
            //添加登录按钮
            UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(imgView.frame.size.width/2-40, imgView.frame.size.height/2, 80, 80)];
            loginBtn.backgroundColor = [UIColor whiteColor];
            loginBtn.layer.cornerRadius = 40.0;
            [loginBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_profile"] forState:UIControlStateNormal];
            [loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
            imgView.userInteractionEnabled = YES;
            [imgView addSubview:loginBtn];
            [cell addSubview:imgView];
        }else if (indexPath.row == 1)
        {
            UILabel *titlelab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
            titlelab.text = @"关注";
            [cell addSubview:titlelab];
            UILabel *desLab = [[UILabel alloc]initWithFrame:CGRectMake(40+5, 10, 300, 20)];
            desLab.text = @"快看看大家都在关注谁";
            desLab.font = [UIFont systemFontOfSize:16];
            desLab.textColor = [UIColor grayColor];
            [cell addSubview:desLab];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }else if (indexPath.row == 2)
        {
            [cell setBackgroundColor:[UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0]];
            UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(38, 80, self.view.frame.size.width - 2*38, 20)];
            lab1.text =@"登录后，你的微博、相册、个人资料、";
            lab1.font = [UIFont systemFontOfSize:14];
            lab1.textColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0];
            
            UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(70, 80+20, self.view.frame.size.width - 2*70, 20)];
            lab2.text =@"会显示在这里，展示给别人";
            lab2.font = [UIFont systemFontOfSize:14];
            lab2.textColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0];
            [cell addSubview:lab1];
            [cell addSubview:lab2];
            
            UIButton *regBtn = [[UIButton alloc]initWithFrame:CGRectMake(40, 80+20+20+20, (self.view.frame.size.width-40-40-30)/2, 40)];
            [regBtn setTitle:@"注册" forState:UIControlStateNormal];
            [regBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            [regBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
            regBtn.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1.0];
            regBtn.layer.cornerRadius = 10.0;
            
            UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(40+(self.view.frame.size.width-40-40-30)/2+30, 80+20+20+20, (self.view.frame.size.width-40-40-30)/2, 40)];
            [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
            [loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
            loginBtn.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1.0];
            loginBtn.layer.cornerRadius = 10.0;
            
            [cell addSubview:regBtn];
            [cell addSubview:loginBtn];
        }
        return  cell;
    }else if(tableView == _loginTableView)
    {
        NSString *CellIdentifier = @"myCell";
        if (indexPath.section == 0) {
            myCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[myCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            }
           // NSLog(@"infoArray = %@",_infoDic);
            if (_infoDic.count > 0)
            {
                [cell.personImageView setImageWithURL:[_infoDic objectForKey:@"avatar_hd"] placeholderImage:nil];
                cell.nameLab.text = [NSString stringWithFormat:@"%@", [_infoDic objectForKey:@"name"]];
                NSString *desStr = [_infoDic objectForKey:@"description"];
                if (desStr.length == 0) {
                    cell.desLab.text = @"简介:暂无介绍";
                }else
                {
                    cell.desLab.text = [NSString stringWithFormat:@"%@",[_infoDic objectForKey:@"description"]];
                }
                cell.weiboCountLab.text = [NSString stringWithFormat:@"%@",[_infoDic objectForKey:@"statuses_count"]];
                cell.guanzhuCountLab.text = [NSString stringWithFormat:@"%@",[_infoDic objectForKey:@"friends_count"]];
                cell.fensiCountLab.text = [NSString stringWithFormat:@"%@",[_infoDic objectForKey:@"followers_count"]];
            }            
            return cell;
        }else
        {
            mineCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[mineCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            }
            cell.lab.text = [NSString stringWithFormat:@"%@",[[_titleArray objectAtIndex:indexPath.section - 1] objectAtIndex:indexPath.row]];
            cell.imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[[_titleImgArray objectAtIndex:indexPath.section - 1] objectAtIndex:indexPath.row]]];
            if (indexPath.section == 1) {
                if (indexPath.row == 1)
                {
                    cell.deslab.text = @"完成任务，抽取大奖";
                }
            }
            if (indexPath.section == 3)
            {
                if (indexPath.row == 0)
                {
                    cell.deslab.text = @"战神套装10元夺";
                }else if (indexPath.row == 1)
                {
                    cell.deslab.text = @"每天10000步，你达标了吗？";
                }
            }
            
            //添加cell小箭头
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
    }else
        return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _mytableview)
    {
        if (indexPath.row == 1)
        {
            UnloginGuanzhuViewController *unloginGuanzhuView = [[UnloginGuanzhuViewController alloc]init];
            UINavigationController *navGuanzhu = [[UINavigationController alloc]initWithRootViewController:unloginGuanzhuView];
            [self presentViewController:navGuanzhu animated:YES completion:nil];
        }
    }
}

#pragma mark - 登录授权
//登录授权（WeiBo  SDK）
-(void)loginAction
{
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kRedirectURI;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From" : @"myViewController",
                         @"Other_Info_1" : [NSNumber numberWithInt:123],
                         @"Other_Info_2" : @[@"obj1", @"obj2"],
                         @"Other_Info_3" : @{@"key1" : @"obj1", @"key2" : @"obj2"}};
    
    [WeiboSDK sendRequest:request];
}

//登录授权后获取个人信息
- (void)getUserInfo {
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:2];
    [params setObject:self.myDelegate.wbtoken forKey:@"access_token"];
    [params setObject:self.myDelegate.wbCurrentUserID forKey:@"uid"];
    NSLog(@"params:%@", params);
    
    WBHttpRequest * asiRequest = [WBHttpRequest requestWithURL:kUSER_SHOW httpMethod:@"GET" params:params delegate:self withTag:@"getUserInfo"];
}

#pragma mark - WBHttpRequestDelegate

- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"user_timeline请求失败：%@", error.userInfo);
}

- (void)request:(WBHttpRequest *)request didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"user_timeline收到微博请求响应");
}

- (void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result
{
    NSError *error;
    NSData  *data = [result dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    _infoDic = json;
    [_loginTableView reloadData];
}
//- (void)request:(WBHttpRequest *)request didFinishLoadingWithDataResult:(NSData *)data {
//    if ([request.tag isEqualToString:@"suggesstions_users"]) {
//        NSMutableArray *resultArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        self.infoArray = resultArray;
//        NSLog(@"%@",_infoArray);
//        [_loginTableView reloadData];
//    }
//}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
