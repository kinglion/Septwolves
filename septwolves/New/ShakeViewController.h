//
//  ShakeViewController.h
//  septwolves
//
//  Created by 小才 on 13-3-26.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LNShakeView.h"
@interface ShakeViewController : UIViewController<UIAccelerometerDelegate>
{
    LNShakeView *shakeView;
}
@property (nonatomic,retain) LNShakeView *shakeView;

@end
