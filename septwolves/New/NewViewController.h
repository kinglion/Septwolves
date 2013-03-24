//
//  NewViewController.h
//  septwolves
//
//  Created by  Lion on 12-12-18.
//  Copyright (c) 2012年 uniideas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VRGCalendarView.h"
#import "LNSQLite.h"
#import "CustomCell.h"
#import "CustomTableView.h"
#import "DataAddViewController.h"
#import "DataDetailViewController.h"

@interface NewViewController : UIViewController<VRGCalendarViewDelegate,UITableViewDataSource,UITableViewDelegate>{
    UIView *dataView;
    UIView *outfitView;
    VRGCalendarView *calendarView;
    CustomTableView *dataTableView;
    UITableView *outfitTableView;
    BOOL isCalendarHide;
    NSMutableArray *allDataLists;
    NSMutableArray *toDayLists;
    LNSQLite *sql;
}
@property (nonatomic,retain) LNSQLite *sql;
@property (nonatomic,retain) NSMutableArray *allDataLists;
@property (nonatomic,retain) NSMutableArray *toDayLists;
@property (nonatomic,retain) VRGCalendarView *calendarView;
@property (nonatomic,retain) UIView *dataView;
@property (nonatomic,retain) UIView *outfitView;
@property (nonatomic,retain) UITableView *dataTableView;
@property (nonatomic,retain) UITableView *outfitTableView;
@property (nonatomic) BOOL isCalendarHide;
- (void)dataSelectClick:(id)sender;
- (void)addDataClick:(id)sender;
@end
