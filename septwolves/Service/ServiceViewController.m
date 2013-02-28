//
//  ServiceViewController.m
//  septwolves
//
//  Created by  Lion on 12-12-18.
//  Copyright (c) 2012年 uniideas. All rights reserved.
//
//品格天下

#import "ServiceViewController.h"

@interface ServiceViewController ()

@end

@implementation ServiceViewController
<<<<<<< HEAD
@synthesize allArr;
@synthesize resultArr;
=======
@synthesize searchDisplayController = _searchDisplayController;

>>>>>>> 2013-02-27
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.allArr = [NSArray arrayWithObjects:@"fdsa",@"wefews",@"sfdwew",@"tewres", nil];
        [self.searchDisplayController setDelegate:self];
        [self.searchDisplayController setSearchResultsDataSource:self];
        [self.searchDisplayController setSearchResultsDelegate:self];
        [self.searchDisplayController.searchBar setScopeButtonTitles:[NSArray arrayWithObjects:@"First",@"Last",nil]];
        self.searchDisplayController.searchBar.delegate = self;
        [self.searchDisplayController.searchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        
        [self.searchDisplayController.searchBar sizeToFit];
    }
    return self;
}

#pragma mark UISearchBar and UISearchDisplayController Delegate Methods

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    
    //準備搜尋前，把上面調整的TableView調整回全屏幕的狀態，如果要產生動畫效果，要另外執行animation代碼
    
    return YES;
    
}

-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    
    //搜尋結束後，恢復原狀，如果要產生動畫效果，要另外執行animation代碼
    
    return YES;
    
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller

shouldReloadTableForSearchString:(NSString *)searchString

{
    
    //一旦SearchBar輸入內容有變化，則執行這個方法，詢問要不要重裝searchResultTableView的數據
    
    //[self filterContentForSearchText:searchString scope:
     
     //[[self.searchDisplayController.searchBar scopeButtonTitles]
      
     // objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    // Return YES to cause the search result table view to be reloaded.
    
    return YES;
    
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller

shouldReloadTableForSearchScope:(NSInteger)searchOption

{
    
    //一旦Scope Button有變化，則執行這個方法，詢問要不要重裝searchResultTableView的數據
    
    //[self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
     
     //[[self.searchDisplayController.searchBar scopeButtonTitles]
      
     // objectAtIndex:searchOption]];
    
    // Return YES to cause the search result table view to be reloaded.
    
    return YES;
    
}
#pragma mark UITableView and UITableViewController Delegate Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    NSInteger a=0;
    
    //过滤关键字
    
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@",self.searchDisplayController.searchBar.text];
    
    NSLog(@"%@",self.searchDisplayController.searchBar.text);
    
    //将搜索的结果赋值给新的数组
    self.resultArr = [self.allArr filteredArrayUsingPredicate:resultPredicate ] ;
    
    NSLog(@"%@",self.resultArr);
    
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]) {
        
        a=[self.resultArr count];
        
    }
    
    return a;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    int resultNum = [self.resultArr count];
    if(resultNum > 0)
    {
        cell.textLabel.text = [self.resultArr objectAtIndex:indexPath.row];
    }else
    {
        cell.textLabel.text = [self.allArr objectAtIndex:indexPath.row];
    }
    return cell;
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
