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
#import "product.h"
@interface ServiceViewController ()

@end

@implementation ServiceViewController
@synthesize allArr;
@synthesize resultArr;
@synthesize ctableView;
@synthesize str;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        str = @"{\"result\":\"000\", \"list\":[{\"id\":\"0\",\"title\":\"七匹狼男装\",\"imgUrl\":\"http://www.fzlol.com/upimg/allimg/130226/2132Tb1C.jpg\",\"content\":\"一匹狼\"},{\"id\":\"1\",\"title\":\"七匹狼男装\",\"imgUrl\":\"http://www.fzlol.com/upimg/allimg/130226/2132Tb1C.jpg\",\"content\":\"一匹狼\"},{\"id\":\"2\",\"title\":\"七匹狼男装\",\"imgUrl\":\"http://www.fzlol.com/upimg/allimg/130226/2132Tb1C.jpg\",\"content\":\"一匹狼\"}]}";
        allArr = [[NSMutableArray alloc]init];
        NSDictionary *data = [str objectFromJSONString];
        NSArray *dataArray = [[NSArray alloc]initWithArray:[data objectForKey:@"list"]];
        int allArrCount = [dataArray count];
        NSLog(@"productsCount:%d",allArrCount);
        for (NSInteger i = 0; i < allArrCount; i++) {
            NSDictionary *single = [dataArray objectAtIndex:i];
            product *productBean = [product productWithType:[[single objectForKey:@"id"] intValue] title:[single objectForKey:@"title"] imgUrl:[single objectForKey:@"imgUrl"] type:0];
            [allArr addObject:productBean];
        }
        [self.searchDisplayController setDelegate:self];
        [self.searchDisplayController setSearchResultsDataSource:self];
        [self.searchDisplayController setSearchResultsDelegate:self];
        [self.searchDisplayController.searchBar setScopeButtonTitles:[NSArray arrayWithObjects:@"First",@"Last",nil]];
        self.searchDisplayController.searchBar.delegate = self;
        [self.searchDisplayController.searchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [self.searchDisplayController.searchBar sizeToFit];
        [ctableView reloadData];
    }
    return self;
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
    
    NSInteger a=0;
    
    //过滤关键字
    
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@",self.searchDisplayController.searchBar.text];
    
    //将搜索的结果赋值给新的数组
    [self.resultArr setArray:[self.allArr filteredArrayUsingPredicate:resultPredicate ]];
    //NSLog(@"%@",self.resultArr);
    
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]) {
        
        a=[self.resultArr count];
        
    }
    return a;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* Cellldentifier = @"Cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:Cellldentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cellldentifier]autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    int resultNum = [self.resultArr count];
    if(resultNum > 0)
    {
        cell.textLabel.text = [self.resultArr objectAtIndex:indexPath.row];
    }else
    {
        cell.textLabel.text = [self.allArr objectAtIndex:indexPath.row];
    }
    
    NSLog(@"%@",cell.textLabel.text);
    return cell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.allArr = [NSArray arrayWithObjects:@"fdsa",@"wefews",@"sfdwew",@"tewres", nil];
    // Do any additional setup after loading the view from its nib.
    ctableView = [[cTableView alloc]initWithFrame:CGRectMake(0, self.searchDisplayController.searchBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.searchDisplayController.searchBar.frame.size.height) products:allArr];
    NSLog(@"%f",self.view.frame.size.height - self.searchDisplayController.searchBar.frame.size.height);
    [self.view addSubview:ctableView];
    [self.searchDisplayController.searchResultsTableView reloadData];
    [ctableView release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
