//
//  DataAddViewController.h
//  septwolves
//
//  Created by 小才 on 13-3-21.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LNconst.h"

@interface DataAddViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UITableView *mainTableView;
    UITextField *themeField;
    UITextField *addrField;
    UITextField *externField;
    UIDatePicker *datePicker;
}
@property (nonatomic,retain) UITableView *mainTableView;
@property (nonatomic,retain) UITextField *themeField;
@property (nonatomic,retain) UITextField *addrField;
@property (nonatomic,retain) UITextField *externField;
@property (nonatomic,retain) UIDatePicker *datePicker;
@end
