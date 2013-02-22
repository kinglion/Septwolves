//
//  SliderView.h
//  septwolves
//
//  Created by 小才 on 13-2-22.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SliderDelegate

- (void)touchView:(UIImageView *)imageView;

@end

@interface SliderView : UIView

@property (nonatomic,assign) NSInteger imageCount;
@property (nonatomic,assign) id<SliderDelegate> delegate;
@end
