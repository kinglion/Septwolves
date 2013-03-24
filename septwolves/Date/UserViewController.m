//
//  UserViewController.m
//  septwolves
//
//  Created by  Lion on 13-3-14.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "UserViewController.h"

@interface UserViewController ()

@end

@implementation UserViewController
@synthesize mainView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil userViewType:(UserViewType)type
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        switch (type) {
            case Login:
                self.mainView = [self returnLoginView];
                break;
            case Reg:
                self.mainView = [self returnRegView];
                break;
            case Forget:
                self.mainView = [self returnForgetView];
                break;
            default:
                break;
        }
        [self.view addSubview:self.mainView];
    }
    return self;
}

- (UIView *)returnLoginView
{
    UIView *tempView = [[UIView alloc]initWithFrame:self.view.frame];
    
    return tempView;
}

- (UIView *)returnRegView
{
    UIView *tempView = [[UIView alloc]initWithFrame:self.view.frame];
    return tempView;
}

- (UIView *)returnForgetView
{
    UIView *tempView = [[UIView alloc]initWithFrame:self.view.frame];
    return tempView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
