//
//  ChrConsuView.m
//  septwolves
//
//  Created by 小才 on 13-2-26.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "ChrConsuView.h"

@implementation ChrConsuView
@synthesize imageCount = _imageCount;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame imageArr:(NSMutableArray *)array
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _imageCount = [array count];
        CGFloat randomNum;
        if(_imageCount > 0)
        {
            UIImage *image = [UIImage imageNamed:@"mannoone.png"];
            UIImageView *imageView = [[[UIImageView alloc]initWithImage:image]autorelease];
            NSLog(@"%d",arc4random() % 2);
        }
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
