//
//  main.m
//  DateCalculator
//
//  Created by Wei Tan on 12-7-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DCAppDelegate.h"

int main(int argc, char *argv[])
{
    NSUserDefaults *defaults = [ NSUserDefaults standardUserDefaults ];
    // 取得 iPhone 支持的所有语言设置
    NSArray *languages = [defaults objectForKey : @"AppleLanguages" ];
    NSLog ( @"%@" , languages);
    
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([DCAppDelegate class]));
    }
}
