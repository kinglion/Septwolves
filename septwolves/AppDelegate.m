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
#import "mainViewController.h"

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
    rootNav = [[mainViewController alloc]init];
    [self.window makeKeyAndVisible];
    [self.window setRootViewController:rootNav];
    [rootNav release];
    //[self playStartScreen];
    
    //[navController release];
    return YES;
    
}

- (void)playStartScreen
{
    UIImageView *splashView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 320, 480)];
    splashView.image = [UIImage imageNamed:@"start_bg.png"];
    [self.window addSubview:splashView];
    [self.window bringSubviewToFront:splashView];
    UIImageView *logoIV = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH_SCREEN - 160)/2, (HEIGHT_SCREEN - 81)/2, 160, 81)];
    [logoIV setAlpha:0];
    [logoIV setImage:[UIImage imageNamed:@"start_logo.png"]];
    UIImageView *friIV = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH_SCREEN - 171)/2, 280, 171, 23)];
    [friIV setAlpha:0];
    [friIV setImage:[UIImage imageNamed:@"start_frist_text.png"]];
    UIImageView *secIV = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH_SCREEN - 215)/2, 310, 215, 23)];
    [secIV setAlpha:0];
    [secIV setImage:[UIImage imageNamed:@"start_second_text.png"]];
    UIImageView *thiIV = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH_SCREEN - 156)/2, 340, 156, 23)];
    [thiIV setAlpha:0];
    [thiIV setImage:[UIImage imageNamed:@"start_third_text.png"]];
    UIImageView *fouIV = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH_SCREEN - 185)/2, 365, 185, 27)];
    [fouIV setAlpha:0];
    [fouIV setImage:[UIImage imageNamed:@"start_fourth_text.png"]];
    UIImageView *firIV = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH_SCREEN - 185)/2, 395, 185, 23)];
    [firIV setAlpha:0];
    [firIV setImage:[UIImage imageNamed:@"start_firth_text.png"]];
    [splashView addSubview:logoIV];
    [splashView addSubview:friIV];
    [splashView addSubview:secIV];
    [splashView addSubview:thiIV];
    [splashView addSubview:fouIV];
    [splashView addSubview:firIV];
    [UIView animateWithDuration:1 animations:^{
        [logoIV setAlpha:1];
        [logoIV setCenter:CGPointMake(WIDTH_SCREEN/2, HEIGHT_SCREEN/2)];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            [logoIV setFrame:CGRectMake((WIDTH_SCREEN - 160)/2, 100, 160, 81)];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1 animations:^{
                [friIV setAlpha:1];
                [friIV setFrame:CGRectMake((WIDTH_SCREEN - 171)/2, 240, 171, 23)];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:1 animations:^{
                    [secIV setAlpha:1];
                    [secIV setFrame:CGRectMake((WIDTH_SCREEN - 215)/2, 270, 215, 23)];
                } completion:^(BOOL finished) {
                   [UIView animateWithDuration:1 animations:^{
                       [thiIV setAlpha:1];
                       [thiIV setFrame:CGRectMake((WIDTH_SCREEN - 156)/2, 300, 156, 23)];
                   } completion:^(BOOL finished) {
                       [UIView animateWithDuration:1 animations:^{
                           [fouIV setAlpha:1];
                           [fouIV setFrame:CGRectMake((WIDTH_SCREEN - 185)/2, 325, 185, 27)];
                       } completion:^(BOOL finished) {
                           [UIView animateWithDuration:1 animations:^{
                               [firIV setAlpha:1];
                               [firIV setFrame:CGRectMake((WIDTH_SCREEN - 185)/2, 355, 185, 23)];
                           } completion:^(BOOL finished) {
                               [UIView beginAnimations:nil context:nil];
                               [UIView setAnimationDuration:1.0];
                               [UIView setAnimationTransition:UIViewAnimationTransitionNone forView: self.window cache:YES];
                               [UIView setAnimationDelegate:self];
                               //[UIView setAnimationDidStopSelector:@selector(startupAnimationDone:finished:context:)];
                               splashView.alpha = 0.0;
                               [splashView setFrame:CGRectMake(0,0,660,952)];
                               [UIView commitAnimations];
                           }];
                       }];
                   }];
                }];
            }];
        }];
    }];
    
    //self.navController = [[UINavigationController alloc] initWithRootViewController:rootNav];
    //self.navController.navigationBar.tintColor = [UIColor colorWithRed:(29.0/255.0) green:(29.0 / 255.0) blue:(29.0 / 255.0) alpha:1];
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
