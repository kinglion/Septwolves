//
//  ShakeViewController.m
//  septwolves
//
//  Created by 小才 on 13-3-26.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "ShakeViewController.h"
#define SHAKE_ALERT_HEIGHT 56.0f

@interface ShakeViewController ()

@end

@implementation ShakeViewController
@synthesize shakeView;
@synthesize isShaking;
@synthesize bean;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        isShaking = NO;
        UIImage* backImage = [UIImage imageNamed:@"backButton.png"];
        CGRect backframe = CGRectMake(0,0,30,19);
        UIButton* backButton= [[UIButton alloc] initWithFrame:backframe];
        [backButton setBackgroundImage:backImage forState:UIControlStateNormal];
        [backButton setTitle:@"" forState:UIControlStateNormal];
        backButton.titleLabel.font=[UIFont systemFontOfSize:13];
        [backButton addTarget:self action:@selector(doClickBackAction:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem* leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        self.navigationItem.leftBarButtonItem = leftBarButtonItem;
        [leftBarButtonItem release];
        [backButton release];
        
        UIAccelerometer *accelerometer = [UIAccelerometer sharedAccelerometer];
        accelerometer.delegate = self;
        accelerometer.updateInterval = 1.0/30.0f;
    }
    return self;
}

- (void)doClickBackAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.frame];
    [imageView setImage:[UIImage imageNamed:@"shake_bg.png"]];
    [imageView setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:imageView];
    [imageView release];
    UIImageView *bottomImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shake_alert.png"]];
    [bottomImageView setFrame:CGRectMake(0, self.view.frame.size.height - SHAKE_ALERT_HEIGHT - 44.0f, self.view.frame.size.width,SHAKE_ALERT_HEIGHT)];
    [self.view addSubview:bottomImageView];
    [bottomImageView release];
    shakeView = [[LNShakeView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 44.0f - SHAKE_ALERT_HEIGHT)];
    NSArray *lists = [[NSArray alloc]initWithObjects:@"ss",@"ss",@"ss",@"ss",nil];
    [shakeView setImageDate:lists];
    [self.view addSubview:shakeView];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)shakeAnimateFinished:(LNShakeView *)target
{
    [shakeView pull];
}

- (void)pullAnimateFinished:(LNShakeView *)target
{
    [shakeView push];
}

- (void)pushAnimateFinished:(LNShakeView *)target
{
    isShaking = NO;
}

-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    //    NSString *str = [NSString stringWithFormat:@"x:%g\ty:%g\tz:%g",acceleration.x,acceleration.y,acceleration.z];
    //    NSLog(@"%@",str);
    
    // 检测摇动, 1.5为轻摇，2.0为重摇
    //    if (fabsf(acceleration.x)>1.8||
    //        fabsf(acceleration.y)>1.8||
    //        fabsf(acceleration.z>1.8)) {
    //        NSLog(@"你摇动我了~");
    //    }
    static NSInteger shakeCount = 0;
    static NSDate *shakeStart;
    NSDate *now = [[NSDate alloc]init];
    NSDate *checkDate = [[NSDate alloc]initWithTimeInterval:1.5f sinceDate:shakeStart];
    if ([now compare:checkDate] == NSOrderedDescending || shakeStart == nil) {
        shakeCount = 0;
        [shakeStart release];
        shakeStart = [[NSDate alloc]init];
    }
    [now release];
    [checkDate release];
    
    if (fabsf(acceleration.x)>1.7||
        fabsf(acceleration.y)>1.7||
        fabsf(acceleration.z)>1.7) {
        shakeCount ++;
        if (shakeCount >10) {
            NSLog(@"你摇动我了~");
            if (isShaking) {
                return;
            }
            isShaking = YES;
            [self.shakeView shake];
            shakeCount = 0;
            [shakeStart release];
            shakeStart = [[NSDate alloc]init];
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
