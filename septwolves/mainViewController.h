//
//  mainViewController.h
//  septwolves
//
//  Created by  Lion on 13-3-5.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootNavController.h"
#import "FristViewController.h"
#import "SecondViewController.h"
#import "DateViewController.h"
#import "NewViewController.h"
#import "ServiceViewController.h"
#import "LNActivityIndicatorView.h"


@interface mainViewController : UIViewController<RootNavControllerDelegate>
{
    UINavigationController *navController;
    RootNavController *rootController;
    LNActivityIndicatorView *indicatorView;
}
@property (nonatomic, retain) UINavigationController *navController;
@property (nonatomic, retain) RootNavController *rootController;
@property (nonatomic, retain) LNActivityIndicatorView *indicatorView;
@end
