//
//  UserViewController.h
//  septwolves
//
//  Created by  Lion on 13-3-14.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LNconst.h"
typedef enum
{
    Login,
    Reg,
    Forget
}UserViewType;

@interface UserViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UIView *mainView;
    UserViewType viewType;
}
@property (nonatomic,retain) UIView *mainView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil userViewType:(UserViewType)type;
@end
