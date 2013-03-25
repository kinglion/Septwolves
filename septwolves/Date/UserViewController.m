//
//  UserViewController.m
//  septwolves
//
//  Created by  Lion on 13-3-14.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "UserViewController.h"
#import <QuartzCore/QuartzCore.h>
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
        viewType = type;
        
        UIImage* backImage = [UIImage imageNamed:@"backButton.png"];
        CGRect backframe = CGRectMake(0,0,30,19);
        UIButton* backButton= [[UIButton alloc] initWithFrame:backframe];
        [backButton setBackgroundImage:backImage forState:UIControlStateNormal];
        [backButton setTitle:@"" forState:UIControlStateNormal];
        backButton.titleLabel.font=[UIFont systemFontOfSize:13];
        [backButton addTarget:self action:@selector(doClickBackAction:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem* leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        self.navigationItem.leftBarButtonItem = leftBarButtonItem;
        [leftBarButtonItem release];
        [backButton release];
    }
    return self;
}

- (void)doClickBackAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIView *)returnLoginView
{
    self.title = @"用户登陆";
    UIView *tempView = [[UIView alloc]initWithFrame:self.view.frame];
    
    return tempView;
}

- (UIView *)returnRegView
{
    self.title = @"用户注册";
    UIView *tempView = [[UIView alloc]initWithFrame:self.view.frame];
    return tempView;
}

- (UIView *)returnForgetView
{
    self.title = @"忘记密码";
    UIView *tempView = [[UIView alloc]initWithFrame:self.view.frame];
    return tempView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIView *bgView = [[UIView alloc]initWithFrame:self.view.frame];
    [bgView.layer setCornerRadius:10];
    [bgView setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:bgView];
    switch (viewType) {
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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
