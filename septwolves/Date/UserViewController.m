//
//  UserViewController.m
//  septwolves
//
//  Created by  Lion on 13-3-14.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "UserViewController.h"
#import <QuartzCore/QuartzCore.h>
#define WIDTH_TABLE 295.0f
@interface UserViewController ()

@end

@implementation UserViewController
@synthesize mainView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil userViewType:(UserViewType)type
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        viewType = type;
        
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

- (UIView *)returnLoginView
{
    self.title = @"用户登陆";
    UIView *tempView = [[UIView alloc]initWithFrame:self.view.frame];
    UITableView *tempTableView = [[UITableView alloc]initWithFrame:CGRectMake((WIDTH_SCREEN - WIDTH_TABLE)/2, 10, WIDTH_TABLE, 200) style:UITableViewStyleGrouped];
    tempTableView.delegate = self;
    tempTableView.dataSource = self;
    tempTableView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
    [tempView addSubview:tempTableView];
    return tempView;
}

- (UIView *)returnRegView
{
    self.title = @"用户注册";
    UIView *tempView = [[UIView alloc]initWithFrame:self.view.frame];
    return tempView;
}

- (UIView *)returnForgetView
{
    self.title = @"忘记密码";
    UIView *tempView = [[UIView alloc]initWithFrame:self.view.frame];
    return tempView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor blackColor]];
    UIView *bgView = [[UIView alloc]initWithFrame:self.view.frame];
    [bgView.layer setCornerRadius:10];
    [bgView setBackgroundColor:[UIColor colorWithRed:33.0/255.0 green:33.0/255.0 blue:34.0/255.0 alpha:1]];
    [self.view addSubview:bgView];
    switch (viewType) {
        case Login:
            self.mainView = [self returnLoginView];
            break;
        case Reg:
            self.mainView = [self returnRegView];
            break;
        case Forget:
            self.mainView = [self returnForgetView];
            break;
        default:
            self.mainView = [self returnLoginView];
            break;
    }
    [self.view addSubview:self.mainView];
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (viewType) {
        case Login:
            return 4;
            break;
        case Reg:
            return 5;
            break;
        case Forget:
            return 5;
            break;
        default:
            return 5;
            break;
    }
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    UITextField *textField = nil;
    if (cell == nil) {
        switch (viewType) {
            case Login:
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"form1"];
                [cell setBackgroundColor:[UIColor colorWithRed:234.0/255.0 green:234.0/255.0 blue:234.0/255.0 alpha:1]];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                switch (indexPath.row) {
                    case 0:
                        cell.textLabel.text = @"用户名/邮箱";
                        [cell.textLabel setFont:[UIFont fontWithName:@"黑体" size:10.0f]];
                        textField = [[UITextField alloc] initWithFrame: CGRectMake(100, 12, 170, 42)];
                        textField.clearsOnBeginEditing = NO;
                        [textField setDelegate: self];
                        textField.returnKeyType = UIReturnKeyDone;
                        [textField addTarget:self action:@selector(textfieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
                        [cell.contentView addSubview: textField];
                        break;
                    case 1:
                        cell.textLabel.text = @"输入密码";
                        [cell.textLabel setFont:[UIFont fontWithName:@"黑体" size:10.0f]];
                        textField = [[UITextField alloc] initWithFrame: CGRectMake(100, 12, 170, 42)];
                        textField.clearsOnBeginEditing = NO;
                        [textField setDelegate: self];
                        textField.returnKeyType = UIReturnKeyDone;
                        [textField addTarget:self action:@selector(textfieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
                        [cell.contentView addSubview: textField];
                        break;
                    case 2:
                        break;
                    case 3:
                        break;
                    default:
                        break;
                }
                
                break;
            case Reg:
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"form1"];
                cell.textLabel.text = @"用户名:";
                textField = [[UITextField alloc] initWithFrame: CGRectMake(90, 12, 200, 25)];
                textField.clearsOnBeginEditing = NO;
                [textField setDelegate: self];
                textField.returnKeyType = UIReturnKeyDone;
                [textField addTarget:self action:@selector(textfieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
                [cell.contentView addSubview: textField];
                break;
            case Forget:
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"form1"];
                cell.textLabel.text = @"用户名:";
                textField = [[UITextField alloc] initWithFrame: CGRectMake(90, 12, 200, 25)];
                textField.clearsOnBeginEditing = NO;
                [textField setDelegate: self];
                textField.returnKeyType = UIReturnKeyDone;
                [textField addTarget:self action:@selector(textfieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
                [cell.contentView addSubview: textField];
                break;
            default:
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"form1"];
                cell.textLabel.text = @"用户名:";
                textField = [[UITextField alloc] initWithFrame: CGRectMake(90, 12, 200, 25)];
                textField.clearsOnBeginEditing = NO;
                [textField setDelegate: self];
                textField.returnKeyType = UIReturnKeyDone;
                [textField addTarget:self action:@selector(textfieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
                [cell.contentView addSubview: textField];
                break;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIColor *altCellColor = [UIColor colorWithWhite:0 alpha:0.0];
    tableView.backgroundColor = altCellColor;
    tableView.backgroundView = nil;
    [tableView setBounces:NO];
}

- (void)textfieldDone:(id)sender {
    [sender resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
