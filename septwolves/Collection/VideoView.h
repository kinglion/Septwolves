//
//  VideoView.h
//  septwolves
//
//  Created by 小才 on 13-2-22.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VideoView;
@protocol VideoViewDelegate

- (void)touchEvent:(VideoView *)view;

@end

@interface VideoView : UIView
{
    id<VideoViewDelegate> delegate;
}

@property(nonatomic,retain) id<VideoViewDelegate> delegate;

@end
