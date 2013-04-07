//
//  const.h
//  septwolves
//
//  Created by  Lion on 13-1-6.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONKit.h"
#import "menuBean.h"
#import "eachMenuBean.h"
#import "CharacterBean.h"
#import "LNActivityIndicatorView.h"
#import "NewBean.h"
#import "dataBean.h"
#import "RssBean.h"
#define RECT_SCREEN [[UIScreen mainScreen] bounds]
#define SIZE_SCREEN RECT_SCREEN.size
#define HEIGHT_SCREEN SIZE_SCREEN.height
#define WIDTH_SCREEN SIZE_SCREEN.width
#define HEIGHT_BAR 44.0f
#define HEIGHT_SUB_BAR HEIGHT_SCREEN - HEIGHT_BAR

#define BASE_URL @"http://uniideas.net/septapp/"
#define BACK_URL @"http://uniideas.net/"
#define MAIN_PAGE @"main.php"
#define MEN_PAGE @"pgnz.php"
#define DYNAMIC_PAGE @"ppdt.php"
#define INFORMATION_PAGE @"mszx.php"
#define VIP_HISTORY_PAGE @"hyzc.php"
#define GIFT_PAGE @"lpdh.php"
#define USER_PAGE @"user.php"
#define RSS_PAGE @"rss.php"
#define ADVITER_PAGE @"gw.php"

#define MAIN_URL [NSString stringWithFormat:@"%@%@",BASE_URL,MAIN_PAGE]
#define MEN_URL [NSString stringWithFormat:@"%@%@",BASE_URL,MEN_PAGE]
#define DYNAMIC_URL [NSString stringWithFormat:@"%@%@",BASE_URL,DYNAMIC_PAGE]
#define INFORMATION_URL [NSString stringWithFormat:@"%@%@",BASE_URL,INFORMATION_PAGE]
#define VIP_HISTORY_URL [NSString stringWithFormat:@"%@%@",BASE_URL,VIP_HISTORY_PAGE]
#define GIFT_URL [NSString stringWithFormat:@"%@%@",BASE_URL,GIFT_PAGE]
#define USER_URL [NSString stringWithFormat:@"%@%@",BASE_URL,USER_PAGE]
#define RSS_URL [NSString stringWithFormat:@"%@%@",BASE_URL,RSS_PAGE]
#define ADVITER_URL [NSString stringWithFormat:@"%@%@",BASE_URL,ADVITER_PAGE]
@interface LNconst : NSObject
//发出http请求获取菜单信息
+ (menuBean *)httpRequestMenu:(LNActivityIndicatorView *)indicatorView;
//发出http请求获取单独菜单信息
+ (eachMenuBean *)httpRequestEachMenu:(LNActivityIndicatorView *)indicatorView action:(NSString *)action;
//
+ (CharacterBean *)httpRequestCharacterMenu:(LNActivityIndicatorView *)indicatorView action:(NSString *)action;
//
+ (NewBean *)httpRequestNewList:(LNActivityIndicatorView *)indicatorView;
//
+ (NewBean *)httpRequestNewInfo:(LNActivityIndicatorView *)indicatorView id:(NSInteger)_id;
//
+ (NewBean *)httpRequestChrList:(LNActivityIndicatorView *)indicatorView;
//
+ (NewBean *)httpRequestChrInfo:(LNActivityIndicatorView *)indicatorView id:(NSInteger)_id;
+ (dataBean *)httpRequestAdviserList:(LNActivityIndicatorView *)indicatorView type:(NSInteger)type num:(NSInteger)num;
+ (RssBean *)httpRequestRssList:(LNActivityIndicatorView *)indicatorView type:(NSInteger)type;
+ (NSArray *)formatWithBaseUrl:(NSArray *)urlList;
+ (NSString *)stringFormatWithBaseUrl:(NSString *)url;
@end
