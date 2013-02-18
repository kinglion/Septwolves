//
//  RootNavController.h
//  septwolves
//
//  Created by 小才 on 13-1-30.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JBKenBurnsView.h"

@interface RootNavController : UIViewController<UITableViewDataSource,UITableViewDelegate,KenBurnsViewDelegate,UINavigationControllerDelegate>
@property (strong , nonatomic) KenBurnsView *kenBurnsView;
@property (nonatomic, retain) UITableView *tableView;
@end
