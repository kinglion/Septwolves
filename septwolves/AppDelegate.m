//
//  AppDelegate.m
//  septwolves
//
//  Created by  Lion on 12-12-17.
//  Copyright (c) 2012年 uniideas. All rights reserved.
//

#define TABLEVIEW_HEIGHT 400

#import "AppDelegate.h"

#import "ViewController.h"
#import "FristViewController.h"
#import "CollectionViewController.h"
#import "DateViewController.h"
#import "NewViewController.h"
#import "ServiceViewController.h"
#import "CustomNavigationBar.h"
#import "CustomNavigationController.h"
#import "LNSingleViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize rootNav;
@synthesize navController;

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    //隐藏顶部状态栏
    //[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    rootNav = [[RootNavController alloc]initWithNibName:@"RootNavController" bundle:nil];
    [self.window makeKeyAndVisible];
    UIImageView *splashView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 320, 480)];
    splashView.image = [UIImage imageNamed:@"sDefault.png"];
    [self.window addSubview:splashView];
    [self.window bringSubviewToFront:splashView];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView: self.window cache:YES];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(startupAnimationDone:finished:context:)];
    splashView.alpha = 0.0;
    splashView.frame = CGRectMake(-60, -85, 440, 635);
    [UIView commitAnimations];
    self.navController = [[UINavigationController alloc] initWithRootViewController:rootNav];
    self.navController.navigationBar.tintColor = [UIColor colorWithRed:(29.0/255.0) green:(29.0 / 255.0) blue:(29.0 / 255.0) alpha:1];
    [self.window addSubview:navController.view];
    [rootNav release];
    [navController release];
    return YES;
    
}



- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
