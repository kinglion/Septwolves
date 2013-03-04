//
//  cTableView.m
//  septwolves
//
//  Created by 小才 on 13-3-1.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "cTableView.h"
#import "product.h"
#import "cView.h"

#define WIDTH 320
#define HEIGHT 640

@implementation cTableView
@synthesize products;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame products:(NSMutableArray*)productsArr
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        if (self.products == nil) {
            self.products = [[NSMutableArray alloc]initWithArray:productsArr];
        }
    }
    return self;
}

- (void)setProducts:(NSMutableArray *)productsArr
{
    self.products = productsArr;
}

- (NSMutableArray*)getProducts
{
    return self.products;
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

- (void)setupView:(NSMutableArray*)productsArr
{
    int productsLen = [productsArr count];
    for (int i = 0; i < productsLen; i++) {
        cView *view = [[cView alloc]init];
        product *productItem = productsArr[i];
        [view setView:CGRectMake((i%2)*WIDTH/2, floor(i/2)*HEIGHT/5, WIDTH/2, HEIGHT/5) title:productItem.title img:productItem.imgUrl cornerable:NO];
        [self addSubview:view];
        [view release];
        [productItem release];
    }
    
}

- (void)dealloc
{
    [super dealloc];
    [products release];
    self.products = nil;
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
