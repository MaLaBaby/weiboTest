//
//  CurrentUserModel.m
//  weiboTest
//
//  Created by haitao on 17/1/19.
//  Copyright © 2017年 Haitao.xue. All rights reserved.
//

#import "CurrentUserModel.h"

@implementation CurrentUserModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"desc" : @"description"};
}
@end
