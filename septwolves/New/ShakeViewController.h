//
//  ShakeViewController.h
//  septwolves
//
//  Created by 小才 on 13-3-26.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LNShakeView.h"
#import "dataBean.h"
@interface ShakeViewController : UIViewController<UIAccelerometerDelegate,LNShakeViewDelegate>
{
    LNShakeView *shakeView;
    dataBean *bean;
    BOOL isShaking;
}
@property (nonatomic,retain) LNShakeView *shakeView;
@property (nonatomic,assign) BOOL isShaking;
@property (nonatomic,retain) dataBean *bean;
@end
