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

@interface DateViewController : UIViewController{
    BOOL loginFlag;//登陆判断
    
}

@property (assign) BOOL loginFlag;

//判断是否登陆
- (BOOL)isLogin;

@end
