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
#import <SDWebImage/UIImageView+WebCache.h>
@interface RootNavController ()

@end

@implementation RootNavController
@synthesize tableView;
@synthesize kenBurnsView;
@synthesize navController;
@synthesize rootNavControllerDelegate = _rootNavControllerDelegate;
@synthesize indicatorView = _indicatorView;
@synthesize resultStr;
@synthesize bean;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        LNActivityIndicatorView *tempIndicatorView = [[LNActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, HEIGHT_SCREEN)];
        // Custom initializatio
        kenBurnsView = [[KenBurnsView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, HEIGHT_SCREEN)];
        kenBurnsView.delegate = self;
        [self.view addSubview:kenBurnsView];
        //UIImage *uiimage = [UIImage imageNamed:@"indexBG.png"];
        //UIImageView *imageView =  [[UIImageView alloc]initWithImage:uiimage];
        //[imageView setFrame:CGRectMake(0, 0, WIDTH_SCREEN, HEIGHT_SCREEN)];
        //[self.view addSubview:imageView];
        tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [tableView setDataSource:self];
        [tableView setDelegate:self];
        [self.view addSubview:tableView];
        [self.view addSubview:tempIndicatorView];
        self.indicatorView = tempIndicatorView;
        self.bean = [LNconst httpRequestMenu:self.indicatorView];
        //[self.indicatorView startAnimating];
        [kenBurnsView animateWithSDWebImageURLs:bean.bgImgList transitionDuration:15 loop:YES isLandscape:YES];
        [tableView reloadData];
        [tempIndicatorView release];
        [tableView release];
        //[uiimage release];
        //[imageView release];
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
    UIImageView *imageView;
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"simple"];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        UIImageView *rightCell = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cellRight.png"]];
        [cell setAccessoryView:rightCell];
        [rightCell release];
        switch (indexPath.row) {
            case 0:
                for (menuBean *item in self.bean.menu) {
                    if ([item.menuName isEqualToString:@"pgnz"]) {
                        cell.textLabel.text = item.title;
                        imageView = cell.imageView;
                        [imageView setFrame:CGRectMake(0, 0, 35, 35)];
                        [imageView setContentMode:UIViewContentModeScaleAspectFit];
                        [imageView setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"pgnz.png"]];
                    }
                }
                break;
            case 1:
                for (menuBean *item in self.bean.menu) {
                    if ([item.menuName isEqualToString:@"nrbzym"]) {
                        cell.textLabel.text = item.title;
                        imageView = cell.imageView;
                        [imageView setFrame:CGRectMake(0, 0, 35, 35)];
                        [imageView setContentMode:UIViewContentModeScaleAspectFit];
                        [imageView setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"nrbzym.png"]];
                    }
                }
                break;
            case 2:
                for (menuBean *item in self.bean.menu) {
                    if ([item.menuName isEqualToString:@"pgzx"]) {
                        cell.textLabel.text = item.title;
                        imageView = cell.imageView;
                        [imageView setFrame:CGRectMake(0, 0, 35, 35)];
                        [imageView setContentMode:UIViewContentModeScaleAspectFit];
                        [imageView setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"pgzx.png"]];
                    }
                }
                break;
            case 3:
                for (menuBean *item in self.bean.menu) {
                    if ([item.menuName isEqualToString:@"pgzzgw"]) {
                        cell.textLabel.text = item.title;
                        imageView = cell.imageView;
                        [imageView setFrame:CGRectMake(0, 0, 35, 35)];
                        [imageView setContentMode:UIViewContentModeScaleAspectFit];
                        [imageView setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"pgzzgw.png"]];
                    }
                }
                break;
            case 4:
                for (menuBean *item in self.bean.menu) {
                    if ([item.menuName isEqualToString:@"pgh"]) {
                        cell.textLabel.text = item.title;
                        imageView = cell.imageView;
                        [imageView setContentMode:UIViewContentModeScaleAspectFit];
                        [imageView setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"pgh.png"]];
                        [imageView setFrame:CGRectMake(0, 0, 35, 35)];
                    }
                }
                break;
            default:
                break;
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [_rootNavControllerDelegate onClickItem:self row:indexPath.row bean:self.bean];
}


- (void)dealloc
{
    [tableView release];
    [kenBurnsView release];
    [navController release];
    [super dealloc];
}

@end
