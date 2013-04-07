//
//  ServiceViewController.m
//  septwolves
//
//  Created by  Lion on 12-12-18.
//  Copyright (c) 2012年 uniideas. All rights reserved.
//
//品格天下

#import "ServiceViewController.h"
#import "JSONKit.h"
#import "mainViewController.h"
#import "LNconst.h"
#import "ChannelViewController.h"
#define WIDTH_LIST 120.0f
@interface ServiceViewController ()

@end

@implementation ServiceViewController
@synthesize allArr;
@synthesize resultArr;
@synthesize ctableView;
@synthesize str;
@synthesize allTitleArr;
@synthesize filterTitleArr;
@synthesize listTableView;
@synthesize bean;
@synthesize mainView;
@synthesize indicatorView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.searchDisplayController setDelegate:self];
        [self.searchDisplayController setSearchResultsDataSource:self];
        [self.searchDisplayController setSearchResultsDelegate:self];
        [self.searchDisplayController.searchBar setScopeButtonTitles:[NSArray arrayWithObjects:@"First",@"Last",nil]];
        self.searchDisplayController.searchBar.delegate = self;
        [self.searchDisplayController.searchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [self.searchDisplayController.searchBar sizeToFit];
        
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
        
        UIImage* listImage = [UIImage imageNamed:@"right_item_bg.png"];
        CGRect listframe = CGRectMake(0, 0, 20, 18);
        UIButton *listButton = [[UIButton alloc]initWithFrame:listframe];
        [listButton setBackgroundImage:listImage forState:UIControlStateNormal];
        [listButton setTitle:@"" forState:UIControlStateNormal];
        listButton.titleLabel.font=[UIFont systemFontOfSize:13];
        [listButton addTarget:self action:@selector(doClickListAction:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem* rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:listButton];
        self.navigationItem.rightBarButtonItem = rightBarButtonItem;
        [rightBarButtonItem release];
        [listButton release];
        [listImage release];
    }
    return self;
}

- (void)doClickListAction:(id)sender
{
    if (isListOpen) {
        [UIView animateWithDuration:1 animations:^{
            [self.listTableView setFrame:CGRectMake(WIDTH_SCREEN, 0, WIDTH_LIST, HEIGHT_SUB_BAR)];
        } completion:^(BOOL finished) {
            if (finished) {
                [self.listTableView setHidden:YES];
            }
        }];
        isListOpen = NO;
    }else{
        [self.listTableView setHidden:NO];
        [UIView animateWithDuration:1 animations:^{
            [self.listTableView setFrame:CGRectMake(WIDTH_SCREEN - WIDTH_LIST, 0, WIDTH_LIST, HEIGHT_SUB_BAR)];
        } completion:^(BOOL finished) {
            if (finished) {
                [self.listTableView setHidden:NO];
            }
        }];
        isListOpen = YES;
    }
}

#pragma mark -

#pragma mark Content Filtering



- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope

{
    
    /*
     
     Update the filtered array based on the search text and scope.
     
     */
    
    
    
    //[self.filteredListContent removeAllObjects]; // First clear the filtered array.
    
    
    
    /*
     
     Search the main list for products whose type matches the scope (if selected) and whose name matches searchText; add items that match to the filtered array.
     
     */
    
    /*for (Product *product in listContent)
        
    {
        
        if ([scope isEqualToString:@"All"] || [product.type isEqualToString:scope])
            
        {
            
            NSComparisonResult result = [product.name compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
            
            if (result == NSOrderedSame)
                
            {
                
                [self.filteredListContent addObject:product];
                
            }
            
        }
        
    }*/
    
}

- (void)doClickBackAction:(id)sender
{
    if (self.parentViewController) {
        CGRect rect = [[UIScreen mainScreen] bounds];
        mainViewController *parentVC = (mainViewController *)self.parentViewController.parentViewController;
        [parentVC transitionFromViewController:parentVC.navController toViewController:parentVC.rootController duration:0.5 options:UIViewAnimationOptionTransitionNone animations:^{
            [parentVC.navController.view setCenter:CGPointMake(rect.size.width * 1.5, rect.size.height/2)];
            [parentVC.rootController.view setCenter:CGPointMake(rect.size.width/2, rect.size.height/2)];
        } completion:^(BOOL finished) {
            [parentVC.navController removeFromParentViewController];
        }];
    }
}


#pragma mark UISearchBar and UISearchDisplayController Delegate Methods

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    
    //準備搜尋前，把上面調整的TableView調整回全屏幕的狀態，如果要產生動畫效果，要另外執行animation代碼
    [self.searchDisplayController setActive:YES];
    return YES;
    
}

-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    
    //搜尋結束後，恢復原狀，如果要產生動畫效果，要另外執行animation代碼
    [self.searchDisplayController setActive:NO];
    return YES;
    
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller

shouldReloadTableForSearchString:(NSString *)searchString

{
    
    //一旦SearchBar輸入內容有變化，則執行這個方法，詢問要不要重裝searchResultTableView的數據
    
    [self filterContentForSearchText:searchString scope:
     
     [[self.searchDisplayController.searchBar scopeButtonTitles]
      
      objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    
    [self.searchDisplayController.searchResultsTableView reloadData];
    // Return YES to cause the search result table view to be reloaded.
    
    return YES;
    
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller

shouldReloadTableForSearchScope:(NSInteger)searchOption

{
    
    //一旦Scope Button有變化，則執行這個方法，詢問要不要重裝searchResultTableView的數據
    
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
     
     [[self.searchDisplayController.searchBar scopeButtonTitles]
      
      objectAtIndex:searchOption]];
    
    // Return YES to cause the search result table view to be reloaded.
    
    return YES;
    
}
#pragma mark UITableView and UITableViewController Delegate Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    /*NSInteger a=0;
    
    //过滤关键字
    
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@",self.searchDisplayController.searchBar.text];
    
    //将搜索的结果赋值给新的数组
    [filterTitleArr setArray:[allTitleArr filteredArrayUsingPredicate:resultPredicate ]];
    //NSLog(@"%@",self.resultArr);
    
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]) {
        
        a=[self.filterTitleArr count];
        
    }
    return a;*/
    NSInteger a = 0;
    if (tableView == self.listTableView) {
        a = 3;
    }
    return a;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* Cellldentifier = @"Cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:Cellldentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cellldentifier]autorelease];
        if (tableView == self.listTableView) {
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"我的频道";
                    break;
                case 1:
                    cell.textLabel.text = @"我的收藏";
                    break;
                case 2:
                    cell.textLabel.text = @"订阅频道";
                    break;
                default:
                    break;
            }
        }else{
            int resultNum = [self.resultArr count];
            if(resultNum > 0)
            {
                cell.textLabel.text = [self.resultArr objectAtIndex:indexPath.row];
            }else
            {
                cell.textLabel.text = [self.allArr objectAtIndex:indexPath.row];
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    return cell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    LNActivityIndicatorView *tempIndicatorView = [[LNActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, HEIGHT_SCREEN)];
    UIView *tempView = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT_BAR, self.view.frame.size.width, self.view.frame.size.height - HEIGHT_BAR)];
    [self.view addSubview:tempView];
    self.mainView = tempView;
    [self.searchDisplayController.searchResultsTableView reloadData];
    self.listTableView = [self creatListTableView];
    [self.view addSubview:self.listTableView];
    [self.view addSubview:tempIndicatorView];
    self.indicatorView = tempIndicatorView;
    self.bean = [LNconst httpRequestRssList:self.indicatorView type:nil];
    ctableView = [[cTableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - HEIGHT_BAR) products:bean];
    [self.mainView addSubview:ctableView];
    [ctableView setCustomDelegate:self];
    [ctableView release];
}

- (UITableView*)creatListTableView
{
    UITableView *tempTableView = [[UITableView alloc]initWithFrame:CGRectMake(WIDTH_SCREEN - WIDTH_LIST, 0, WIDTH_LIST, HEIGHT_SUB_BAR) style:UITableViewStylePlain];
    [UIView animateWithDuration:1 animations:^{
        [tempTableView setFrame:CGRectMake(WIDTH_SCREEN, 0, WIDTH_LIST, HEIGHT_SUB_BAR)];
    } completion:^(BOOL finished) {
        if (finished) {
            [self.listTableView setHidden:YES];
        }
    }];
    isListOpen = NO;
    [tempTableView setDataSource:self];
    [tempTableView setDelegate:self];
    return tempTableView;
}

- (void)cTableViewAdd:(cTableView *)view
{
    UIViewController *singleViewController = [[ChannelViewController alloc]init];
    [self.navigationController pushViewController:singleViewController animated:YES];
}

- (void)cTableViewSelected:(cTableView *)view
{
    NSLog(@"cTableViewSelected");
    ReaderVC *readerVc = [[ReaderVC alloc]init];
    readerVc.sharedIndex = 0;
    [self.navigationController pushViewController:readerVc animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    UIColor *altCellColor = [UIColor colorWithWhite:0 alpha:1];
    self.listTableView.backgroundColor = altCellColor;
    cell.backgroundColor = altCellColor;
    altCellColor = [UIColor colorWithWhite:1 alpha:0];
    cell.textLabel.backgroundColor = altCellColor;
    [cell.textLabel setFont:[UIFont fontWithName:@"黑体" size:20]];
    [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
    cell.detailTextLabel.backgroundColor = altCellColor;
    cell.textLabel.textColor = [UIColor whiteColor];
    self.listTableView.separatorColor = [UIColor darkGrayColor];
    [self.listTableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.listTableView) {
        return 50;
    }else{
        return 40;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.listTableView){
        NSLog(@"选中！");
        [self.listTableView deselectRowAtIndexPath:indexPath animated:YES];
        UIViewController *singleViewController;
        switch (indexPath.row) {
            case 0:
                singleViewController = [[ChannelViewController alloc]init];
                singleViewController.title = @"订阅频道";
                break;
            case 1:
                singleViewController = [[ChannelViewController alloc]init];
                singleViewController.title = @"订阅频道";
                break;
            case 2:
                singleViewController = [[ChannelViewController alloc]init];
                singleViewController.title = @"订阅频道";
                break;
            default:
                singleViewController = [[ChannelViewController alloc]init];
                singleViewController.title = @"订阅频道";
                break;
        }
        [self.navigationController pushViewController:singleViewController animated:YES];
        [UIView animateWithDuration:1 animations:^{
            [self.listTableView setFrame:CGRectMake(WIDTH_SCREEN, 0, WIDTH_LIST, HEIGHT_SUB_BAR)];
        } completion:^(BOOL finished) {
            if (finished) {
                [self.listTableView setHidden:YES];
            }
        }];
        isListOpen = NO;
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
