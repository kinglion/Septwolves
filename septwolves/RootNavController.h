//
//  RootNavController.h
//  septwolves
//
//  Created by 小才 on 13-1-30.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JBKenBurnsView.h"
#import "NavViewController.h"
#import "LNActivityIndicatorView.h"
#import "LNconst.h"
#import "menuBean.h"
@class RootNavController;
@protocol RootNavControllerDelegate


@optional
- (void)onClickItem:(UIViewController*)viewController row:(NSInteger)row;
@end

@interface RootNavController : UIViewController<UITableViewDataSource,UITableViewDelegate,KenBurnsViewDelegate,UINavigationControllerDelegate>
{
    NavViewController *navController;
    KenBurnsView *kenBurnsView;
    LNActivityIndicatorView *indicatorView;
    NSString *resultStr;
    menuBean *bean;
}
@property (nonatomic, copy) NSString *resultStr;
@property (nonatomic, assign) id<RootNavControllerDelegate> rootNavControllerDelegate;
@property (nonatomic, retain) NavViewController *navController;
@property (nonatomic , retain) KenBurnsView *kenBurnsView;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) LNActivityIndicatorView *indicatorView;
@property (nonatomic, retain) menuBean *bean;
@end
