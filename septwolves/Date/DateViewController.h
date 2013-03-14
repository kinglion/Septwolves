//
//  DateViewController.h
//  septwolves
//
//  Created by  Lion on 12-12-18.
//  Copyright (c) 2012年 uniideas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LNView.h"
#import "LNconst.h"

@interface DateViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    BOOL loginFlag;//登陆判断
    UITableView *tableView;
}

@property (assign) BOOL loginFlag;
@property (nonatomic,retain) UITableView *tableView;
//判断是否登陆
- (BOOL)isLogin;
//添加登陆按钮和注册按钮
- (void)addMutilButton:(CGRect)lFrame rFrame:(CGRect)rFrame;

@end
