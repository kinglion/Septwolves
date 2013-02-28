//
//  ServiceViewController.h
//  septwolves
//
//  Created by  Lion on 12-12-18.
//  Copyright (c) 2012年 uniideas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServiceViewController : UIViewController<UISearchDisplayDelegate,UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
{
}

@property (nonatomic,retain)NSArray *allArr;
@property (nonatomic,retain)NSArray *resultArr;
@end
