//
//  cTableView.m
//  septwolves
//
//  Created by 小才 on 13-3-1.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "cTableView.h"
#import "cView.h"

#define WIDTH 320.0f
#define HEIGHT 480.0f

@implementation cTableView
@synthesize customDelegate = _customDelegate;
@synthesize products;
@synthesize loadIndex;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame products:(RssBean*)productsArr
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        if (self.products == nil) {
            self.products = productsArr;
            [self setBackgroundColor:[UIColor blackColor]];
            [self setShowsVerticalScrollIndicator:NO];
            [self setupView:productsArr];
        }
    }
    return self;
}

- (void)reloadData
{
    [self reSetView];
    [self setupView:self.products];
}

- (void)reSetView
{
    self.products = nil;
    
}

- (void)setupView:(RssBean*)productsArr
{
    int productsLen = [productsArr.list count];
    for (int i = 0; i < productsLen; i++) {
        cView *view = [[cView alloc]initWithFrame:CGRectMake((i%2)*WIDTH/2, (i/2)*HEIGHT/3, WIDTH/2, HEIGHT/3)];
        RssBean *productItem = [productsArr.list objectAtIndex:i];
        [view setView:CGRectMake((i%2)*WIDTH/2, (i/2)*HEIGHT/3, WIDTH/2, HEIGHT/3) title:productItem.title img:productItem.icon cornerable:NO];
        [view setDelegate:self];
        [self addSubview:view];
        [view release];
        [productItem release];
    }
    UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake((productsLen%2)*WIDTH/2, (productsLen/2)*HEIGHT/3, WIDTH/2, HEIGHT/3)];
    [addButton addTarget:self action:@selector(addButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    [addButton setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:addButton];
    [addButton release];
}

- (void)layoutSubviews
{
    int productsLen = [self.products.list count];
    if (productsLen % 2 == 0) {
        productsLen += 2;
    }
    [self setContentSize:CGSizeMake(self.frame.size.width, (productsLen/2)*HEIGHT/3)];
}

- (void)addButtonSelected:(id)sender
{
    NSLog(@"addButtonSelected");
    [_customDelegate cTableViewAdd:self];
}

- (void)touchEvent:(cView *)view
{
    NSLog(@"touchEvent");
    [_customDelegate cTableViewSelected:self];
}

- (void)dealloc
{
    [super dealloc];
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
