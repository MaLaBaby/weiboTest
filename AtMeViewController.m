//
//  AtMeViewController.m
//  weiboTest
//
//  Created by haitao on 17/1/22.
//  Copyright © 2017年 Haitao.xue. All rights reserved.
//

#import "AtMeViewController.h"
#import "AtMeCell.h"
#import "WeiboSDK.h"
#import "WeiboAPIMacro.h"
#import "AtMeModel.h"
#import "YYKit.h"
#import "AtMeCell+ConfigureForAtMe.h"
@interface AtMeViewController ()<WBHttpRequestDelegate>

@end

@implementation AtMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    _mytableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:_mytableView];
    _mytableView.tableFooterView = [[UIView alloc]init];
    _mytableView.delegate = self;
    _mytableView.dataSource = self;
    _atInfoArray = [[NSMutableArray alloc]init];
    self.navigationItem.title = @"所有微博";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.atInfoArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 217;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UINib *nib = [UINib nibWithNibName:@"AtMeCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:@"cellID"];
    AtMeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil) {
        cell = [[AtMeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }else {
        while ([cell.contentView.subviews lastObject]) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    Statuses_two *statuses_twoModel = self.atInfoArray[indexPath.row];
    [cell configureForAtMe:statuses_twoModel indexPath:indexPath viewController:self];
    return cell;
}



- (void)getatMeInfomation{
    NSMutableDictionary *paramsDictionary = [NSMutableDictionary new];
    [paramsDictionary setObject:self.myDelegate.wbtoken forKey:@"access_token"];
    [self requestForOpenAPIWithURL:STATUSES_MENTIONS params:paramsDictionary withTag:nil];
}



#pragma mark - Http request

- (void)requestForOpenAPIWithURL:(NSString *)url params:(NSDictionary *)extraParams withTag:(NSString *)tag {
    [WBHttpRequest requestWithAccessToken:self.myDelegate.wbtoken url:url httpMethod:@"GET" params:extraParams delegate:self withTag:tag];
}

#pragma mark - WBHttpRequestDelegate

- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"请求失败：%@", error.userInfo);
}

- (void)request:(WBHttpRequest *)request didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"收到微博请求响应");
}

- (void)request:(WBHttpRequest *)request didFinishLoadingWithDataResult:(NSData *)data {
    AtMeModel *atMe = [AtMeModel modelWithJSON:data];
//    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//    NSLog(@"dict === %@",dict);
    [self.atInfoArray addObjectsFromArray:atMe.statuses_two];
//    for (NSString *key in dict) {
//        <#statements#>
//    }
}






- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = YES;
    [self getatMeInfomation];
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

//dict === {
//    hasvisible = 0;
//    interval = 0;
//    "next_cursor" = 0;
//    "previous_cursor" = 0;
//    statuses =     (
//                    {
//                        appid = 6;
//                        "attitudes_count" = 0;
//                        "biz_feature" = 0;
//                        "comments_count" = 0;
//                        "created_at" = "Wed Feb 27 02:46:02 +0800 2013";
//                        "darwin_tags" =             (
//                        );
//                        favorited = 0;
//                        "gif_ids" = "";
//                        hasActionTypeCard = 0;
//                        "hot_weibo_tags" =             (
//                        );
//                        id = 3550146568491338;
//                        idstr = 3550146568491338;
//                        "in_reply_to_screen_name" = "";
//                        "in_reply_to_status_id" = "";
//                        "in_reply_to_user_id" = "";
//                        isLongText = 0;
//                        "is_show_bulletin" = 0;
//                        mid = 3550146568491338;
//                        mlevel = 0;
//                        "pic_ids" =             (
//                        );
//                        "positive_recom_flag" = 0;
//                        "reposts_count" = 0;
//                        "retweeted_status" =             {
//                            appid = 1;
//                            "attitudes_count" = 1881;
//                            "biz_feature" = 0;
//                            "comments_count" = 8221;
//                            "created_at" = "Tue Feb 26 11:16:48 +0800 2013";
//                            "darwin_tags" =                 (
//                            );
//                            favorited = 0;
//                            "gif_ids" = "";
//                            hasActionTypeCard = 0;
//                            "hot_weibo_tags" =                 (
//                            );
//                            id = 3549912718936585;
//                            idstr = 3549912718936585;
//                            "in_reply_to_screen_name" = "";
//                            "in_reply_to_status_id" = "";
//                            "in_reply_to_user_id" = "";
//                            isLongText = 0;
//                            "is_show_bulletin" = 0;
//                            mid = 3549912718936585;
//                            mlevel = 0;
//                            "pic_ids" =                 (
//                            );
//                            "positive_recom_flag" = 0;
//                            "reposts_count" = 46295;
//                            source = "<a href=\"http://weibo.com/\" rel=\"nofollow\">\U5fae\U535a weibo.com</a>";
//                            "source_allowclick" = 0;
//                            "source_type" = 1;
//                            text = "\U4e00\U5916\U56fd\U670b\U53cb\U6628\U665a\U5728\U9152\U5427\U88ab\U59d1\U5a18\U642d\U8baa\Uff0c\U95ee\U4ed6\U662f\U5426\U542c\U8bf4\U8fc7Ang Lee\Uff1f \U8fd9\U54e5\U4eec\U78b0\U5de7\U662f\U4e2a\U7535\U5f71\U8ff7\Uff0c\U4e8e\U662f\U8ddf\U5185\U59d1\U5a18\U804a\U4e86\U4e00\U665a\U4e0a\Uff0c\U4ece\U65ad\U80cc\U5c71\U5230\U5c11\U5e74\U6d3e\Uff0c\U5e76\U6df1\U60c5\U8ffd\U5fc6\U4e86\U674e\U5b89\U7684\U6210\U529f\U53f2\Uff0c\U6700\U540e\U8fd8\U4e70\U4e86\U4e24\U5343\U591a\U7684\U5b89\U5229\U4ea7\U54c1\U3002 \U200b";
//                            "text_tag_tips" =                 (
//                            );
//                            truncated = 0;
//                            "url_objects" =                 (
//                            );
//                            user =                 {
//                                "allow_all_act_msg" = 0;
//                                "allow_all_comment" = 1;
//                                "avatar_hd" = "http://tva1.sinaimg.cn/crop.0.0.180.180.1024/5b7e5cb1jw1e8qgp5bmzyj2050050aa8.jpg";
//                                "avatar_large" = "http://tva1.sinaimg.cn/crop.0.0.180.180.180/5b7e5cb1jw1e8qgp5bmzyj2050050aa8.jpg";
//                                badge =                     {
//                                    "ali_1688" = 0;
//                                    anniversary = 1;
//                                    "bind_taobao" = 1;
//                                    "caishen_2017" = 0;
//                                    dailv = 0;
//                                    daiyan = 0;
//                                    "discount_2016" = 0;
//                                    "dzwbqlx_2016" = 0;
//                                    enterprise = 0;
//                                    "follow_whitelist_video" = 0;
//                                    "fools_day_2016" = 0;
//                                    gongyi = 0;
//                                    "gongyi_level" = 0;
//                                    "hongbao_2014" = 0;
//                                    "hongbao_2017" = 0;
//                                    "hongbao_2017_2" = 1;
//                                    "olympic_2016" = 0;
//                                    "self_media" = 0;
//                                    "shuang11_2016" = 0;
//                                    "suishoupai_2014" = 1;
//                                    "suishoupai_2016" = 0;
//                                    "super_star_2016" = 0;
//                                    taobao = 0;
//                                    travel2013 = 1;
//                                    "uc_domain" = 0;
//                                    "uefa_euro_2016" = 0;
//                                    "unread_pool" = 0;
//                                    "unread_pool_ext" = 0;
//                                    "vip_activity1" = 0;
//                                    "vip_activity2" = 0;
//                                    "wbzy_2016" = 0;
//                                    "wedding_2016" = 0;
//                                    zongyiji = 0;
//                                };
//                                "badge_top" = "";
//                                "bi_followers_count" = 761;
//                                "block_app" = 0;
//                                "block_word" = 0;
//                                city = 8;
//                                class = 1;
//                                "cover_image_phone" = "http://ww1.sinaimg.cn/crop.0.0.640.640.640/6cf8d7ebjw1ehfr4xa8psj20hs0hsgpg.jpg";
//                                "created_at" = "Wed Nov 04 15:54:05 +0800 2009";
//                                "credit_score" = 80;
//                                description = "\U5c0f\U4f19\U53ea \U8bf7\U4f60\U81ea\U91cd\Uff01";
//                                domain = echo8398;
//                                extend =                     {
//                                    mbprivilege = 0000000000000000000000000000000000000000000000000000000000100060;
//                                    privacy =                         {
//                                        mobile = 1;
//                                    };
//                                };
//                                "favourites_count" = 2365;
//                                "follow_me" = 0;
//                                "followers_count" = 10382;
//                                following = 0;
//                                "friends_count" = 1221;
//                                gender = f;
//                                "geo_enabled" = 1;
//                                "has_ability_tag" = 1;
//                                id = 1535007921;
//                                idstr = 1535007921;
//                                insecurity =                     {
//                                    "sexual_content" = 0;
//                                };
//                                lang = "zh-cn";
//                                level = 7;
//                                location = "\U5317\U4eac \U6d77\U6dc0\U533a";
//                                mbrank = 1;
//                                mbtype = 2;
//                                name = "\U90b5\U767d\U767d";
//                                "online_status" = 0;
//                                "pagefriends_count" = 6;
//                                "profile_image_url" = "http://tva1.sinaimg.cn/crop.0.0.180.180.50/5b7e5cb1jw1e8qgp5bmzyj2050050aa8.jpg";
//                                "profile_url" = echo8398;
//                                province = 11;
//                                ptype = 0;
//                                remark = "";
//                                "screen_name" = "\U90b5\U767d\U767d";
//                                star = 0;
//                                "statuses_count" = 1716;
//                                type = 1;
//                                ulevel = 0;
//                                urank = 28;
//                                url = "http://blog.sina.com.cn/missparanoid";
//                                "user_ability" = 0;
//                                verified = 0;
//                                "verified_reason" = "";
//                                "verified_reason_url" = "";
//                                "verified_source" = "";
//                                "verified_source_url" = "";
//                                "verified_trade" = "";
//                                "verified_type" = 220;
//                                weihao = "";
//                            };
//                            userType = 0;
//                            visible =                 {
//                                "list_id" = 0;
//                                type = 0;
//                            };
//                        };
//                        rid = "0_0_0_2666495364595379630";
//                        source = "<a href=\"http://app.weibo.com/t/feed/5xCS0B\" rel=\"nofollow\">\U5fae\U535a\U624b\U673a\U7248</a>";
//                        "source_allowclick" = 0;
//                        "source_type" = 1;
//                        text = " @\U624b\U673a\U7528\U62373186690954";
//                        "text_tag_tips" =             (
//                        );
//                        truncated = 0;
//                        "url_objects" =             (
//                        );
//                        user =             {
//                            "allow_all_act_msg" = 0;
//                            "allow_all_comment" = 1;
//                            "avatar_hd" = "http://tva3.sinaimg.cn/crop.0.0.180.180.1024/6b902c29jw1e8qgp5bmzyj2050050aa8.jpg";
//                            "avatar_large" = "http://tva3.sinaimg.cn/crop.0.0.180.180.180/6b902c29jw1e8qgp5bmzyj2050050aa8.jpg";
//                            badge =                 {
//                                "ali_1688" = 0;
//                                anniversary = 0;
//                                "bind_taobao" = 0;
//                                "caishen_2017" = 0;
//                                dailv = 0;
//                                daiyan = 0;
//                                "discount_2016" = 0;
//                                "dzwbqlx_2016" = 0;
//                                enterprise = 0;
//                                "follow_whitelist_video" = 0;
//                                "fools_day_2016" = 0;
//                                gongyi = 0;
//                                "gongyi_level" = 0;
//                                "hongbao_2014" = 0;
//                                "hongbao_2017" = 0;
//                                "hongbao_2017_2" = 0;
//                                "olympic_2016" = 0;
//                                "self_media" = 0;
//                                "shuang11_2016" = 0;
//                                "suishoupai_2014" = 0;
//                                "suishoupai_2016" = 0;
//                                "super_star_2016" = 0;
//                                taobao = 0;
//                                travel2013 = 0;
//                                "uc_domain" = 0;
//                                "uefa_euro_2016" = 0;
//                                "unread_pool" = 0;
//                                "unread_pool_ext" = 0;
//                                "vip_activity1" = 0;
//                                "vip_activity2" = 0;
//                                "wbzy_2016" = 0;
//                                "wedding_2016" = 0;
//                                zongyiji = 0;
//                            };
//                            "badge_top" = "";
//                            "bi_followers_count" = 24;
//                            "block_app" = 0;
//                            "block_word" = 0;
//                            city = 1;
//                            class = 1;
//                            "created_at" = "Sat Aug 28 20:24:09 +0800 2010";
//                            "credit_score" = 80;
//                            description = "";
//                            domain = chengcheng1996055;
//                            extend =                 {
//                                mbprivilege = 0000000000000000000000000000000000000000000000000000000000000000;
//                                privacy =                     {
//                                    mobile = 1;
//                                };
//                            };
//                            "favourites_count" = 0;
//                            "follow_me" = 0;
//                            "followers_count" = 61;
//                            following = 0;
//                            "friends_count" = 273;
//                            gender = f;
//                            "geo_enabled" = 1;
//                            "has_ability_tag" = 0;
//                            id = 1804610601;
//                            idstr = 1804610601;
//                            insecurity =                 {
//                                "sexual_content" = 0;
//                            };
//                            lang = "zh-cn";
//                            level = 1;
//                            location = "\U6e56\U5357 \U957f\U6c99";
//                            mbrank = 0;
//                            mbtype = 0;
//                            name = "_______________\U5c1b\U7a0b";
//                            "online_status" = 0;
//                            "pagefriends_count" = 0;
//                            "profile_image_url" = "http://tva3.sinaimg.cn/crop.0.0.180.180.50/6b902c29jw1e8qgp5bmzyj2050050aa8.jpg";
//                            "profile_url" = chengcheng1996055;
//                            province = 43;
//                            ptype = 0;
//                            remark = "";
//                            "screen_name" = "_______________\U5c1b\U7a0b";
//                            star = 0;
//                            "statuses_count" = 259;
//                            type = 1;
//                            ulevel = 0;
//                            urank = 4;
//                            url = "";
//                            "user_ability" = 0;
//                            verified = 0;
//                            "verified_reason" = "";
//                            "verified_reason_url" = "";
//                            "verified_source" = "";
//                            "verified_source_url" = "";
//                            "verified_trade" = "";
//                            "verified_type" = "-1";
//                            weihao = "";
//                        };
//                        userType = 0;
//                        visible =             {
//                            "list_id" = 0;
//                            type = 0;
//                        };
//                    }
//                    );
//    "total_number" = 1;
//}
