//
//  DataDetailViewController.h
//  septwolves
//
//  Created by 小才 on 13-3-22.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewViewController.h"
#import "dataBean.h"
#import "DataAddViewController.h"

@interface DataDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITableView *mainTableView;
    UILabel *themeLabel;
    UILabel *addrLabel;
    UILabel *externLabel;
    UILabel *dateLabel;
    LNSQLite *sql;
    dataBean *bean;
}
@property (nonatomic,retain) UITableView *mainTableView;
@property (nonatomic,retain) UILabel *themeLabel;
@property (nonatomic,retain) UILabel *addrLabel;
@property (nonatomic,retain) UILabel *externLabel;
@property (nonatomic,retain) UILabel *dateLabel;
@property (nonatomic,retain) dataBean *bean;
@property (nonatomic,retain) LNSQLite *sql;
@end
