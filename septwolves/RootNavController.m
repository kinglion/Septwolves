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
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initializatio
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
        [self.view addSubview:tableView];
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
    UIImageView *imageView;
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"simple"];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        UIImageView *rightCell = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cellRight.png"]];
        [cell setAccessoryView:rightCell];
        [rightCell release];
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"品格男装";
                imageView = cell.imageView;
                [imageView setImageWithURL:[NSURL URLWithString:@"http://img-tx.meilishuo.net/pic/_o/b1/47/88dee2d76aaab27e6b3c87eb4d10_1300_1300.jpg"]];
                break;
            case 1:
                cell.textLabel.text = @"男人不止一面";
                imageView = cell.imageView;
                [imageView setImageWithURL:[NSURL URLWithString:@"http://img-tx.meilishuo.net/pic/_o/b1/47/88dee2d76aaab27e6b3c87eb4d10_1300_1300.jpg"]];
                break;
            case 2:
                cell.textLabel.text = @"品格咨询";
                imageView = cell.imageView;
                [imageView setImageWithURL:[NSURL URLWithString:@"http://img-tx.meilishuo.net/pic/_o/b1/47/88dee2d76aaab27e6b3c87eb4d10_1300_1300.jpg"]];
                break;
            case 3:
                cell.textLabel.text = @"品格着装顾问";
                imageView = cell.imageView;
                [imageView setImageWithURL:[NSURL URLWithString:@"http://img-tx.meilishuo.net/pic/_o/b1/47/88dee2d76aaab27e6b3c87eb4d10_1300_1300.jpg"]];
                break;
            case 4:
                cell.textLabel.text = @"品格会";
                imageView = cell.imageView;
                [imageView setImageWithURL:[NSURL URLWithString:@"http://img-tx.meilishuo.net/pic/_o/b1/47/88dee2d76aaab27e6b3c87eb4d10_1300_1300.jpg"]];
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
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [_rootNavControllerDelegate onClickItem:self row:indexPath.row];
}


- (void)dealloc
{
    [tableView release];
    [kenBurnsView release];
    [navController release];
    [super dealloc];
}

@end
