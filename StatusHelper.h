//
//  FindViewController.h
//  weiboTest
//
//  Created by haitao on 17/1/17.
//  Copyright © 2017年 Haitao.xue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class WPEmoticon, WPEmoticonGroup;
@interface StatusHelper : NSObject

+ (NSRegularExpression *)regexAt; // At 正则 例如 @王思聪

+ (NSRegularExpression *)regexEmoticon; /// 表情正则 例如 [偷笑]

+ (NSDictionary *)emoticonDic; /// 表情字典 key: [偷笑] value:imagePath

+ (UIImage *)imageWithPath:(NSString *)path; /// 从 path 创建图片（有缓存）

@end

@class WPEmoticonGroup;

typedef NS_ENUM(NSUInteger, WBEmotionType) {
    WBEmotionTypeImage = 0, ///< 图片表情
    WBEmotionTypeEmoji = 1, ///< Emoji表情
};

@interface WPEmoticon : NSObject

@property (copy, nonatomic) NSString *chs; ///< 例如 [吃惊]
@property (copy, nonatomic) NSString *cht; ///< 例如
@property (copy, nonatomic) NSString *gif; ///< 例如 d_chijing.gif
@property (copy, nonatomic) NSString *png; ///< 例如 d_chijing.png
@property (copy, nonatomic) NSString *code; ///< 例如 0x1f60d
@property (assign, nonatomic) WBEmotionType type;
@property (weak, nonatomic) WPEmoticonGroup *group;

@end

@interface WPEmoticonGroup : NSObject

@property (copy, nonatomic) NSString *groupID; /// 例如 com.sina.default
@property (assign, nonatomic) NSInteger version;
@property (copy, nonatomic) NSString *nameCN; /// < 例如 浪小花
@property (copy, nonatomic) NSString *nameEN;
@property (copy, nonatomic) NSString *nameTW;
@property (assign, nonatomic) NSInteger displayOnly;
@property (assign, nonatomic) NSInteger groupType;
@property (copy, nonatomic) NSArray<WPEmoticon *> *emoticons;

@end
