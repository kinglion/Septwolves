//
//  UserViewController.h
//  septwolves
//
//  Created by  Lion on 13-3-14.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    Login,
    Reg,
    Forget
}UserViewType;

@interface UserViewController : UIViewController
{
    UIView *mainView;
}
@property (nonatomic,retain) UIView *mainView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil userViewType:(UserViewType)type;
@end
