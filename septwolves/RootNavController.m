//
//  RootNavController.m
//  septwolves
//
//  Created by 小才 on 13-1-30.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "RootNavController.h"
#import "LNSingleViewController.h"
#import "FristViewController.h"
#import "CollectionViewController.h"
#import "DateViewController.h"
#import "NewViewController.h"
#import "ServiceViewController.h"
@interface RootNavController ()

@end

@implementation RootNavController
@synthesize tableView;
@synthesize kenBurnsView;
@synthesize navController;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initializatio
        UIView *rootView = [[UIView alloc]init];
        [rootView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        /*NSArray *imageArr = [NSArray arrayWithObjects:
                             @"http://img.article.pchome.net/00/59/22/36/pic_lib/wm/Meinv06.jpg",@"http://img.article.pchome.net/00/50/42/87/pic_lib/wm/Meinv01.jpg",nil];*/
        //kenBurnsView = [[KenBurnsView alloc]initWithFrame:CGRectMake(0, 0,rootView.frame.size.width,rootView.frame.size.height)];
        //[rootView addSubview:kenBurnsView];
        //kenBurnsView.delegate = self;
        //[kenBurnsView animateWithSDWebImageURLs:imageArr transitionDuration:15 loop:YES isLandscape:YES];
        UIImage *uiimage = [UIImage imageNamed:@"indexBG.png"];
        UIImageView *imageView =  [[UIImageView alloc]initWithImage:uiimage];
        [imageView setFrame:CGRectMake(0, 0, self.view.frame.size
                                       .width, self.view.frame.size
                                       .height)];
        [self.view addSubview:imageView];
        tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [tableView setDataSource:self];
        [tableView setDelegate:self];
        [rootView addSubview:tableView];
        [self.view addSubview:rootView];
        [tableView release];
        [uiimage release];
        [imageView release];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"self.navigationController:%@",self.navigationController);
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView setFrame:CGRectMake(0, self.view.frame.size.height-self.tableView.contentSize.height, self.view.frame.size.width, self.tableView.contentSize.height)];
    UIColor *altCellColor = [UIColor colorWithWhite:0 alpha:0.6];
    self.tableView.backgroundColor = altCellColor;
    cell.backgroundColor = altCellColor;
    altCellColor = [UIColor colorWithWhite:1 alpha:0];
    cell.textLabel.backgroundColor = altCellColor;
    cell.detailTextLabel.backgroundColor = altCellColor;
    cell.textLabel.textColor = [UIColor whiteColor];
    self.tableView.separatorColor = [UIColor darkGrayColor];
    [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.tableView setBounces:NO];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"simple"];
        
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"品格男装";
                break;
            case 1:
                cell.textLabel.text = @"男人不止一面";
                break;
            case 2:
                cell.textLabel.text = @"品格天下";
                break;
            case 3:
                cell.textLabel.text = @"品格着装顾问";
                break;
            case 4:
                cell.textLabel.text = @"品格会";
                break;
            default:
                break;
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 41;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"选中！");
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *singleView;
    switch (indexPath.row) {
        case 0:
            //跳转到品格男装
            singleView = [[FristViewController alloc]init];
            break;
        case 1:
            //男人不止一面
            singleView = [[CollectionViewController alloc]init];
            break;
        case 2:
            //品格天下
            singleView = [[ServiceViewController alloc]init];
            break;
        case 3:
            //品格着装顾问
            singleView = [[NewViewController alloc]init];
            break;
        case 4:
            singleView = [[DateViewController alloc]init];
            //品格会
            break;
        default:
            break;
    }
    navController = [[NavViewController alloc]initWithRootViewController:singleView];
    /*CATransition *animation = [CATransition animation];
    [animation setDuration:0.5];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromRight];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [[navController.view layer] addAnimation:animation forKey:@"SwitchToView"];*/
    //[self setModalPresentationStyle:UIModalTransitionStylePartialCurl];
    [self addChildViewController:navController];
    [self transitionFromViewController:nil toViewController:navController duration:0.5 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{} completion:^(BOOL finished) {
        //
    }];
   // [self presentViewController:navController animated:NO completion:nil];
    //[self.navigationController pushViewController:singleView animated:YES];
    [singleView release];
}


- (void)dealloc
{
    [tableView release];
    [kenBurnsView release];
    [navController release];
    [super dealloc];
}

@end
