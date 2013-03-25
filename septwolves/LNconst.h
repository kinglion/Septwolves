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
#import "LNActivityIndicatorView.h"
#define RECT_SCREEN [[UIScreen mainScreen] bounds]
#define SIZE_SCREEN RECT_SCREEN.size
#define HEIGHT_SCREEN SIZE_SCREEN.height
#define WIDTH_SCREEN SIZE_SCREEN.width
#define HEIGHT_BAR 44.0f
#define HEIGHT_SUB_BAR HEIGHT_SCREEN - HEIGHT_BAR
@interface LNconst : NSObject
//发出http请求获取菜单信息
+ (menuBean *)httpRequestMenu:(LNActivityIndicatorView *)indicatorView;
//发出http请求获取单独菜单信息
+ (eachMenuBean *)httpRequestEachMenu:(LNActivityIndicatorView *)indicatorView action:(NSString *)action;
@end
