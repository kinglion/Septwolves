//
//  DataAddViewController.m
//  septwolves
//
//  Created by 小才 on 13-3-21.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "DataAddViewController.h"
#define HEIGHT_SEGMENT 30.0f
#define WIDTH_SEGMENT 300.0f
#define HEIGHT_TABLE 300.0f


@interface DataAddViewController ()

@end

@implementation DataAddViewController
@synthesize mainTableView;
@synthesize themeField,addrField,externField;
@synthesize datePicker;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"添加事件";
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
        
        UIBarButtonItem* rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(doClickSureAction:)];
        [rightBarButtonItem setTintColor:[UIColor grayColor]];
        self.navigationItem.rightBarButtonItem = rightBarButtonItem;
        [rightBarButtonItem release];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithWhite:0.8 alpha:1]];
    UITableView *tempTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, HEIGHT_SEGMENT + 20, self.view.frame.size.width, HEIGHT_TABLE) style:UITableViewStyleGrouped];
    [tempTableView setDelegate:self];
    [tempTableView setDataSource:self];
    [self.view addSubview:tempTableView];
    self.mainTableView = tempTableView;
    [tempTableView release];
    
    UIView *tempView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, HEIGHT_SEGMENT)];
    UISegmentedControl *tempSegmented = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"都市商务",@"重要会议",@"运动场所",@"休闲场所", nil]];
    [tempSegmented setFrame:CGRectMake((WIDTH_SCREEN - WIDTH_SEGMENT)/2, 10, WIDTH_SEGMENT, HEIGHT_SEGMENT)];
    [tempSegmented addTarget:self action:@selector(chageSegmented:) forControlEvents:UIControlEventValueChanged];
    [tempSegmented setSegmentedControlStyle:UISegmentedControlStyleBar];
    [tempSegmented setTintColor:[UIColor grayColor]];
    [tempSegmented setSelected:YES];
    [tempSegmented setSelectedSegmentIndex:0];
    [self ChangeSegmentFont:tempSegmented];
    [tempView addSubview:tempSegmented];
    [self.view addSubview:tempView];
    [tempView release];
    
    datePicker = [ [ UIDatePicker alloc] initWithFrame:CGRectMake(0.0,self.view.frame.size.height - 216,0.0,216)];
    datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    datePicker.minuteInterval = 5;
    [self.view addSubview:datePicker];
    [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
	// Do any additional setup after loading the view.
}

- (void)ChangeSegmentFont:(UIView *)aView
{
    if ([aView isKindOfClass:[UILabel class]])
    {
        UILabel *lb = (UILabel *)aView;
        [lb setTextAlignment:NSTextAlignmentCenter];
        [lb setFont:[UIFont systemFontOfSize:13]];
    }
    NSArray *na = [aView subviews];
    NSEnumerator *ne = [na objectEnumerator];
    UIView *subView;
    while (subView = [ne nextObject])
    {
        [self ChangeSegmentFont: subView];
    }
}

- (void)doClickSureAction:(id)sender
{
    
}

- (void)doClickBackAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dateChanged:(id)sender
{
    UIDatePicker *control = (UIDatePicker*)sender;
    NSDate* _date = control.date;
    NSLog(@"%@",_date);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIColor *altCellColor = [UIColor colorWithWhite:0 alpha:0.0];
    tableView.backgroundColor = altCellColor;
    tableView.backgroundView = nil;
    [tableView setBounces:NO];
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    /*
    if (section == 0) {
        UIView *tempView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, HEIGHT_SEGMENT)];
        UISegmentedControl *tempSegmented = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"都市商务",@"重要会议",@"运动场所",@"休闲场所", nil]];
        [tempSegmented addTarget:self action:@selector(chageSegmented:) forControlEvents:UIControlEventValueChanged];
        [tempView addSubview:tempSegmented];
        return tempView;
    }else{
        
    }
    */
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return 80;
    }else{
        return 40;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return 1;
            break;
        default:
            return 0;
            break;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (cell == nil) {
        switch (indexPath.section) {
            case 0:
                switch (indexPath.row) {
                    case 0:
                        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"form1"];
                        cell.textLabel.text = @"主题";
                        UITextField *textField = [[UITextField alloc] initWithFrame: CGRectMake(90, 12, 200, 25)];
                        textField.clearsOnBeginEditing = NO;
                        [textField setDelegate: self];
                        textField.returnKeyType = UIReturnKeyDone;
                        [textField addTarget:self action:@selector(textfieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
                        [cell.contentView addSubview: textField];
                        self.themeField = textField;
                        break;
                        
                    default:
                        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"form1"];
                        cell.textLabel.text = @"地点";
                        textField = [[UITextField alloc] initWithFrame: CGRectMake(90, 12, 200, 25)];
                        textField.clearsOnBeginEditing = NO;
                        [textField setDelegate: self];
                        textField.returnKeyType = UIReturnKeyDone;
                        [textField addTarget:self action:@selector(textfieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
                        [cell.contentView addSubview: textField];
                        self.addrField = textField;
                        break;
                }
                break;
            default:
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"form2"];
                cell.textLabel.text = @"备注";
                UITextField *textField = [[UITextField alloc] initWithFrame: CGRectMake(90, 12, 200, 25)];
                textField.clearsOnBeginEditing = NO;
                [textField setDelegate: self];
                textField.returnKeyType = UIReturnKeyDone;
                [textField addTarget:self action:@selector(textfieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
                [cell.contentView addSubview: textField];
                self.externField = textField;
                break;
        }
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"选中！");
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (IBAction)textfieldDone:(id)sender {
    [sender resignFirstResponder];
}

- (void)chageSegmented:(id)sender
{
    //[self ChangeSegmentFont:sender];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
