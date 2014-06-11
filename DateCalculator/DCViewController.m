//
//  DCViewController.m
//  DateCalculator
//
//  Created by Wei Tan on 12-7-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DCViewController.h"
#import "Global.h"

static BOOL bCurPlus = YES;

@interface DCViewController ()

@end

@implementation DCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    for (int i = 1; i <= 6; ++i)
    {
        id tf = [Global GetChildren:svDate className:[UITextField class] Tag:i];
        id btn = [Global GetChildren:svDate className:[UIButton class] Tag:0x8000 + i - 1];
        [tf setDelegate:self];
        [btn addTarget:self action:@selector(SelectBtn:) forControlEvents:UIControlEventTouchUpInside];
        tf = [Global GetChildren:svNum className:[UITextField class] Tag:i];
        btn = [Global GetChildren:svNum className:[UIButton class] Tag:0x8000 + i - 1];
        [tf setDelegate:self];
        [btn addTarget:self action:@selector(SelectBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    UIScrollView *tmp = [svDate isHidden] ? svNum : svDate;
    for (int i = 1; i <= 6; ++i)
    {
        id tf = [Global GetChildren:tmp className:[UITextField class] Tag:i];
        [tf resignFirstResponder];
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    int max = 2;
    if([svNum isHidden] && ![svDate isHidden])
    {
        switch (textField.tag)
        {
            case 1:
            case 4:
                max = 4;
                break;
        }
    }
    else if(![svNum isHidden] && [svDate isHidden])
    {
        switch (textField.tag)
        {
            case 1:
                max = 4;
                break;
            case 4:
                max = 9;
                break;
        }
    }
    if (range.location >= max)
        return NO;
    return YES;
}

-(IBAction)didChangeSegmentControl:(id)sender
{
    UISegmentedControl *seg = (UISegmentedControl*)sender;
    if (seg.selectedSegmentIndex == 0)
    {
        [svDate setHidden:NO];
        [svNum setHidden:YES];
    }
    else if(seg.selectedSegmentIndex == 1)
    {
        [svNum setHidden:NO];
        [svDate setHidden:YES];
    }
}

-(IBAction)SelectBtn:(id)sender
{
    UIScrollView *tmp = [svDate isHidden] ? svNum : svDate;
    for (int i = 1; i <= 6; ++i)
    {
        id tf = [Global GetChildren:tmp className:[UITextField class] Tag:i];
        [tf resignFirstResponder];
    }
    
    UIButton *btn = (UIButton*)sender;
    switch (btn.tag)
    {
        case 0x8000 + 0://date From
        {
            NSDateComponents *now = [Global DateNow];
            UITextField *tmp = [Global GetChildren:svDate className:[UITextField class] Tag:1];
            [tmp setText:[NSString stringWithFormat:@"%d", now.year]];
            tmp = [Global GetChildren:svDate className:[UITextField class] Tag:2];
            [tmp setText:[NSString stringWithFormat:@"%d", now.month]];
            tmp = [Global GetChildren:svDate className:[UITextField class] Tag:3];
            [tmp setText:[NSString stringWithFormat:@"%d", now.day]];
            
        }
            break;
        case 0x8000 + 1://date To
        {
            NSDateComponents *now = [Global DateNow];
            UITextField *tmp = [Global GetChildren:svDate className:[UITextField class] Tag:4];
            [tmp setText:[NSString stringWithFormat:@"%d", now.year]];
            tmp = [Global GetChildren:svDate className:[UITextField class] Tag:5];
            [tmp setText:[NSString stringWithFormat:@"%d", now.month]];
            tmp = [Global GetChildren:svDate className:[UITextField class] Tag:6];
            [tmp setText:[NSString stringWithFormat:@"%d", now.day]];
        }
            break;
        case 0x8000 + 2://Num From
        {
            NSDateComponents *now = [Global DateNow];
            UITextField *tmp = [Global GetChildren:svNum className:[UITextField class] Tag:1];
            [tmp setText:[NSString stringWithFormat:@"%d", now.year]];
            tmp = [Global GetChildren:svNum className:[UITextField class] Tag:2];
            [tmp setText:[NSString stringWithFormat:@"%d", now.month]];
            tmp = [Global GetChildren:svNum className:[UITextField class] Tag:3];
            [tmp setText:[NSString stringWithFormat:@"%d", now.day]];
        }
            break;
        case 0x8000 + 3://Num +/-
        {
            UIButton *btn = (UIButton*)sender;
            if(bCurPlus)
            {
                [btn setTitle:@"-" forState:UIControlStateNormal];
                [btn setTitle:@"-" forState:UIControlStateHighlighted];
            }
            else
            {
                [btn setTitle:@"+" forState:UIControlStateNormal];
                [btn setTitle:@"+" forState:UIControlStateHighlighted];
            }
            bCurPlus = !bCurPlus;
        }
            break;
        case 0x8000 + 4://Date = / Num =
        {
            if(![svDate isHidden])
            {
                NSArray *array = [[NSArray alloc] initWithObjects:
                                  [Global GetChildren:svDate className:[UITextField class] Tag:1],
                                  [Global GetChildren:svDate className:[UITextField class] Tag:2],
                                  [Global GetChildren:svDate className:[UITextField class] Tag:3],
                                  [Global GetChildren:svDate className:[UITextField class] Tag:4],
                                  [Global GetChildren:svDate className:[UITextField class] Tag:5],
                                  [Global GetChildren:svDate className:[UITextField class] Tag:6],
                                  nil];
                for (int i = 0; i < 6; ++i)
                {//格式化输入yyyy-MM-dd， 检测数据长度。
                    if(((UITextField*)[array objectAtIndex:i]).text.length == 1)
                    {
                        ((UITextField*)[array objectAtIndex:i]).text = [NSString stringWithFormat:
                                                                        @"0%@", ((UITextField*)[array objectAtIndex:i]).text];
                    }
                    else if(((UITextField*)[array objectAtIndex:i]).text.length < 1)
                    {
                        NSString *tmp = nil;
                        if (i % 3 == 0)
                        {
                            tmp = @"年份需要输入！";
                        }
                        else if(i % 3 == 1)
                        {
                            tmp = @"月份需要输入！";
                        }
                        else if(i % 3 == 2)
                        {
                            tmp = @"日-需要输入！";
                        }
                        UIAlertView *alert =
                        [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                   message:tmp
                                                  delegate:nil
                                         cancelButtonTitle:@"确定"
                                         otherButtonTitles:nil];
                        [alert show];
                        return;
                    }
                }
                NSDateComponents *diff = [Global dateDiff:[NSString stringWithFormat:@"%@-%@-%@", 
                                                           ((UITextField*)[array objectAtIndex:3]).text,
                                                           ((UITextField*)[array objectAtIndex:4]).text,
                                                           ((UITextField*)[array objectAtIndex:5]).text]
                                                 FromDate:[NSString stringWithFormat:@"%@-%@-%@", 
                                                           ((UITextField*)[array objectAtIndex:0]).text,
                                                           ((UITextField*)[array objectAtIndex:1]).text,
                                                           ((UITextField*)[array objectAtIndex:2]).text]];
                
                if(diff == nil)
                {
                    UIAlertView *alert =
                    [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                               message:@"日期错误！"
                                              delegate:nil
                                     cancelButtonTitle:@"确定"
                                     otherButtonTitles:nil];
                    [alert show];
                }
                UILabel *tmp = [Global GetChildren:svDate className:[UILabel class] Tag:1];//date
                [tmp setText:[NSString stringWithFormat:@"%@-%@-%@", 
                              ((UITextField*)[array objectAtIndex:3]).text,
                              ((UITextField*)[array objectAtIndex:4]).text,
                              ((UITextField*)[array objectAtIndex:5]).text]];
                tmp = [Global GetChildren:svDate className:[UILabel class] Tag:2];//days
                [tmp setText:[NSString stringWithFormat:@"%d", diff.week]];
                tmp = [Global GetChildren:svDate className:[UILabel class] Tag:3];//weeks
                [tmp setText:[NSString stringWithFormat:@"%d", diff.day]];
                tmp = [Global GetChildren:svDate className:[UILabel class] Tag:4];//month
                [tmp setText:[NSString stringWithFormat:@"%d", diff.month]];
                tmp = [Global GetChildren:svDate className:[UILabel class] Tag:5];//year
                [tmp setText:[NSString stringWithFormat:@"%d", diff.year]];
            }
            else if(![svNum isHidden])
            {
                NSArray *array = [[NSArray alloc] initWithObjects:
                                  [Global GetChildren:svNum className:[UITextField class] Tag:1],
                                  [Global GetChildren:svNum className:[UITextField class] Tag:2],
                                  [Global GetChildren:svNum className:[UITextField class] Tag:3],
                                  [Global GetChildren:svNum className:[UITextField class] Tag:4],
                                  nil];
                for (int i = 0; i < 3; ++i)
                {//格式化输入yyyy-MM-dd， 检测数据长度。
                    if(((UITextField*)[array objectAtIndex:i]).text.length == 1)
                    {
                        ((UITextField*)[array objectAtIndex:i]).text = [NSString stringWithFormat:
                                                                        @"0%@", ((UITextField*)[array objectAtIndex:i]).text];
                    }
                    else if(((UITextField*)[array objectAtIndex:i]).text.length < 1)
                    {
                        NSString *tmp = nil;
                        if (i % 3 == 0)
                        {
                            tmp = @"年份需要输入！";
                        }
                        else if(i % 3 == 1)
                        {
                            tmp = @"月份需要输入！";
                        }
                        else if(i % 3 == 2)
                        {
                            tmp = @"日-需要输入！";
                        }
                        UIAlertView *alert =
                        [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                   message:tmp
                                                  delegate:nil
                                         cancelButtonTitle:@"确定"
                                         otherButtonTitles:nil];
                        [alert show];
                        return;
                    }
                }
                double day = [((UITextField*)[array objectAtIndex:3]).text doubleValue];
                if(!bCurPlus)
                {
                    day = -day;
                }
                NSDateComponents *date = [Global diffToDate:[NSString stringWithFormat:@"%@-%@-%@", 
                                                             ((UITextField*)[array objectAtIndex:0]).text,
                                                             ((UITextField*)[array objectAtIndex:1]).text,
                                                             ((UITextField*)[array objectAtIndex:2]).text]
                                                   DiffDays:day];
                
                if(date == nil)
                {
                    UIAlertView *alert =
                    [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                               message:@"日期错误！"
                                              delegate:nil
                                     cancelButtonTitle:@"确定"
                                     otherButtonTitles:nil];
                    [alert show];
                }
                UILabel *tmp = [Global GetChildren:svNum className:[UILabel class] Tag:1];//date
                [tmp setText:[NSString stringWithFormat:@"%d-%d-%d", date.hour, date.minute, date.second]];
                tmp = [Global GetChildren:svNum className:[UILabel class] Tag:2];//days
                [tmp setText:[NSString stringWithFormat:@"%d", date.week]];
                tmp = [Global GetChildren:svNum className:[UILabel class] Tag:3];//weeks
                [tmp setText:[NSString stringWithFormat:@"%d", date.day]];
                tmp = [Global GetChildren:svNum className:[UILabel class] Tag:4];//month
                [tmp setText:[NSString stringWithFormat:@"%d", date.month]];
                tmp = [Global GetChildren:svNum className:[UILabel class] Tag:5];//year
                [tmp setText:[NSString stringWithFormat:@"%d", date.year]];
            }
        }
            break;
        default:
            break;
    }
}



@end
