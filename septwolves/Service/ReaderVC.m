//
//  ReaderVC.m
//  AFFeedsReader
//
//  Created by Álvaro Franco on 17/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ReaderVC.h"
#import "KMXMLParser.h"

@implementation ReaderVC

@synthesize parseResults;
@synthesize sharedIndex;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
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
    }
    return self;
}

- (void)doClickBackAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    post = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.bounds.size.height)];
   
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        KMXMLParser *parser = [[KMXMLParser alloc] initWithURL:@"http://www.ftchinese.com/rss/news" delegate:nil];
        parseResults = [parser posts];
        
        post.delegate = self;
        post.scrollView.showsHorizontalScrollIndicator = NO;
        [self setTitle:[NSString stringWithFormat:@"%@", [[self.parseResults objectAtIndex:sharedIndex]objectForKey:@"title"]]];
        NSString *titleHTML = [NSString stringWithFormat:@"<b>%@</b>", [[self.parseResults objectAtIndex:sharedIndex]objectForKey:@"title"]];
        NSString *postHTML = [NSString stringWithFormat:@"%@", [[self.parseResults objectAtIndex:sharedIndex]objectForKey:@"summary"]];
        NSLog(@"postHTML:%@",postHTML);
        
        NSString *structure =[NSString stringWithFormat:@"<html><head><style type='text/css'>iframe {width:290px; height:auto;} object {width:290px; height:auto;} blockquote {font-family:Arial;} img{width:290px; height:auto; display: block; margin-left: 0px; margin-right: auto} p {font-family:Arial;} h1 {font-family:Arial;} h2 {font-family:Arial;} h3 {font-family:Arial;} h4 {font-family:Arial;} h5 {font-family:Arial;} h6 {font-family:Arial;} li {font-family:Arial;} b {font-family:Arial;}</style></head><body>"];
        NSString *close =[NSString stringWithFormat:@"</body></html>"];
        
        NSString *HTMLString = [NSString stringWithFormat:@"%@%@<br/><br/>%@%@", structure, titleHTML, postHTML, close];

        [post loadHTMLString:HTMLString baseURL:nil];
    });
    
    back = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(back)];
    back.delegate = self;
    back.direction = UISwipeGestureRecognizerDirectionRight;
    
    
    [self.view addSubview:post];
    [self.view addGestureRecognizer:back];
    
    
    [self showLoadingView];
}

-(void)showLoadingView {
            
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.delegate = self;
    HUD.labelText = @"Loading";
    [HUD show:YES];
}

-(void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    return YES;
}

-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if (inType == UIWebViewNavigationTypeLinkClicked) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [HUD hide:YES];
}

@end
