//
//  mainViewController.m
//  septwolves
//
//  Created by  Lion on 13-3-5.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "mainViewController.h"

@interface mainViewController ()

@end

@implementation mainViewController
@synthesize navController;
@synthesize rootController;
@synthesize indicatorView = _indicatorView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    rootController = [[RootNavController alloc]initWithNibName:@"RootNavController" bundle:nil];
    [self addChildViewController:rootController];
    rootController.rootNavControllerDelegate = self;
    [self.view addSubview:rootController.view];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onClickItem:(UIViewController*)viewController row:(NSInteger)row bean:(menuBean *)bean
{
    NSLog(@"选中！%d",row);
    UIViewController *singleView = nil;
    switch (row) {
        case 0:
            //跳转到品格男装
            singleView = [[FristViewController alloc]init];
            for (menuBean *item in bean.menu) {
                if ([item.menuName isEqualToString:@"pgnz"]) {
                    singleView.title = item.title;
                }
            }
            break;
        case 1:
            //男人不止一面
            singleView = [[SecondViewController alloc]init];
            for (menuBean *item in bean.menu) {
                if ([item.menuName isEqualToString:@"nrbzym"]) {
                    singleView.title = item.title;
                }
            }
            break;
        case 2:
            //品格天下
            singleView = [[ServiceViewController alloc]init];
            for (menuBean *item in bean.menu) {
                if ([item.menuName isEqualToString:@"pgzx"]) {
                    singleView.title = item.title;
                }
            }
            break;
        case 3:
            //品格着装顾问
            singleView = [[NewViewController alloc]init];
            for (menuBean *item in bean.menu) {
                if ([item.menuName isEqualToString:@"pgzzgw"]) {
                    singleView.title = item.title;
                }
            }
            break;
        case 4:
            singleView = [[DateViewController alloc]init];
            for (menuBean *item in bean.menu) {
                if ([item.menuName isEqualToString:@"pgh"]) {
                    singleView.title = item.title;
                }
            }
            //品格会
            break;
        default:
            break;
    }
    //navController = [[UINavigationController alloc]initWithNibName:@"NavViewController" bundle:nil];
    navController = [[[NSBundle mainBundle] loadNibNamed:@"NavViewController" owner:self options:nil] objectAtIndex:0];
    [navController setViewControllers:[NSArray arrayWithObject:singleView]];
    /*CATransition *animation = [CATransition animation];
     [animation setDuration:0.5];
     [animation setType:kCATransitionPush];
     [animation setSubtype:kCATransitionFromRight];
     [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
     
     [[navController.view layer] addAnimation:animation forKey:@"SwitchToView"];*/
    //[self setModalPresentationStyle:UIModalTransitionStylePartialCurl];
    [navController.view setCenter:CGPointMake(self.view.frame.size.width * 1.5, self.view.frame.size.height/2)];
    [self addChildViewController:navController];
    [self.view addSubview:navController.view];
    [self transitionFromViewController:rootController toViewController:navController duration:0.5 options:UIViewAnimationOptionTransitionNone animations:^{
        [rootController.view setCenter:CGPointMake(-self.view.frame.size.width/2, self.view.frame.size.height/2)];
        [navController.view setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2)];
        } completion:^(BOOL finished) {
        //
    }];
    // [self presentViewController:navController animated:NO completion:nil];
    //[self.navigationController pushViewController:singleView animated:YES];
    [singleView release];
}

@end
