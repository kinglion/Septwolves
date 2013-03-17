//
//  LNConsuViewController.h
//  septwolves
//
//  Created by  Lion on 13-3-17.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LNConsuViewController : UIViewController
{
    UIScrollView *mainScrollView;
    UITableView *listTableView;
    UILabel *pageLabel;
}
@property (nonatomic,retain)UIScrollView *mainScrollView;
@property (nonatomic,retain)UITableView *listTableView;
@property (nonatomic,retain)UILabel *pageLabel;
@end
