//
//  AtMeCell+ConfigureForAtMe.m
//  weiboTest
//
//  Created by haitao on 17/2/7.
//  Copyright © 2017年 Haitao.xue. All rights reserved.
//

#import "AtMeCell+ConfigureForAtMe.h"
#import "AtMeModel.h"
#import "AtMeViewController.h"

@implementation AtMeCell (ConfigureForAtMe)

- (CGFloat)configureForAtMe:(Statuses_two *)statusesModel indexPath:(NSIndexPath *)indexPath viewController:(AtMeViewController *)aViewController{
    self.id = [statusesModel id];
    self.atMePersonName = [UILabel new];
    self.atMePersonName.text = [statusesModel wbuser][@"name"];
    NSLog(@"AAAAAA======%@",[statusesModel wbuser][@"name"]);
    return 217.0;
}

@end
