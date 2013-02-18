//
//  AppDelegate.h
//  septwolves
//
//  Created by  Lion on 12-12-17.
//  Copyright (c) 2012年 uniideas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JBKenBurnsView.h"
#import "RootNavController.h"

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate,UITableViewDataSource,UITableViewDelegate>
{
    
    KenBurnsView *kenBurnsView;
}
@property (strong, nonatomic) UINavigationController *navController;
@property (strong, nonatomic) IBOutlet UIWindow *window;
@property (strong, nonatomic) ViewController *viewController;
@property (nonatomic, retain) RootNavController *rootNav;

@end
