//
//  mainViewController.h
//  septwolves
//
//  Created by  Lion on 13-3-5.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootNavController.h"
#import "FristViewController.h"
#import "CollectionViewController.h"
#import "DateViewController.h"
#import "NewViewController.h"
#import "ServiceViewController.h"


@interface mainViewController : UIViewController<RootNavControllerDelegate>
{
    NavViewController *navController;
    RootNavController *rootController;
}
@property (nonatomic, retain) NavViewController *navController;
@property (nonatomic, retain) RootNavController *rootController;
@end
