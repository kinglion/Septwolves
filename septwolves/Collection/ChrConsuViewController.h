//
//  ChrConsuViewController.h
//  septwolves
//
//  Created by 小才 on 13-2-26.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChrConsuViewController : UIViewController<UIScrollViewDelegate>
{
    NSString *str;
    NSMutableArray *array;
}
@property (nonatomic,retain)UIScrollView *scrollView;
@end
