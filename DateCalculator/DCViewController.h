//
//  DCViewController.h
//  DateCalculator
//
//  Created by Wei Tan on 12-7-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCViewController : UIViewController <UITextFieldDelegate>
{
    IBOutlet UIScrollView *svDate;
    IBOutlet UIScrollView *svNum;
}

-(IBAction)didChangeSegmentControl:(id)sender;
-(IBAction)SelectBtn:(id)sender;

@end
