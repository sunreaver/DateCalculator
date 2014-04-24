//
//  Global.m
//  Orion
//
//  Created by Wei Tan on 12-5-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Global.h"

@implementation Global

static NSString *_strNetData;

+(void)setStrNetData:(NSString*)newData
{
    _strNetData = newData;
}

+(NSString*)StrNetData
{
    return _strNetData;
}

+(UIImage*)imageFromURLString:(NSString *)urlstring
{
    return  [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlstring]]];
}

/* dateDiff 方法实现 */
+(NSDateComponents *) dateDiff:(NSString*)toDate
{
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setTimeZone:[NSTimeZone systemTimeZone]];
    [date setFormatterBehavior:NSDateFormatterBehaviorDefault];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *endData = [date dateFromString:toDate];
    NSDate *fromD = [NSDate dateWithTimeIntervalSinceNow:0];
    
    
    NSCalendar *sysCalendar = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |
    NSDayCalendarUnit | NSHourCalendarUnit |
    NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    NSDateComponents *compInfo = [sysCalendar components:unitFlags
                                                fromDate:fromD
                                                  toDate:endData
                                                 options:0];
    return compInfo;
}

+(NSDateComponents *) dateDiff:(NSString*)toDate FromDate:(NSString*)fromDate
{
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setTimeZone:[NSTimeZone systemTimeZone]];
    [date setFormatterBehavior:NSDateFormatterBehaviorDefault];
    [date setDateFormat:@"yyyy-MM-dd"];
    NSDate *endData = [date dateFromString:toDate];
    NSDate *fromD = [date dateFromString:fromDate];
    
    if(endData == nil || fromD == nil)
    {
        return nil;
    }
    
    NSTimeInterval diff = [endData timeIntervalSinceDate:fromD];
    NSTimeInterval iDat = diff / ( 86400 ) ;//一天
    
    NSCalendar *sysCalendar = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |
    NSDayCalendarUnit | NSHourCalendarUnit |
    NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    NSDateComponents *compInfo = [sysCalendar components:unitFlags
                                                fromDate:fromD
                                                  toDate:endData
                                                 options:0];
    
    [compInfo setWeek:iDat];
    return compInfo;
}

+(NSDateComponents *) diffToDate:(NSString*)baseDate DiffDays:(double)diffDays
{
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setTimeZone:[NSTimeZone systemTimeZone]];
    [date setFormatterBehavior:NSDateFormatterBehaviorDefault];
    [date setDateFormat:@"yyyy-MM-dd"];
    NSDate *base = [date dateFromString:baseDate];
    
    if(base == nil)
    {
        return nil;
    }
    
    NSDate *since = [NSDate dateWithTimeInterval:diffDays*86400 sinceDate:base];
    
    NSTimeInterval diff = [since timeIntervalSinceDate:base];
    NSTimeInterval iDat = diff / ( 86400 ) ;//一天
    
    NSCalendar *sysCalendar = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |
    NSDayCalendarUnit | NSHourCalendarUnit |
    NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    NSDateComponents *compInfo = [sysCalendar components:unitFlags
                                                fromDate:base
                                                  toDate:since
                                                 options:0];
    
    
    NSDateComponents *outDate = [sysCalendar components:unitFlags
                                                fromDate:since];
    
    [compInfo setWeek:iDat];
    [compInfo setHour:outDate.year];
    [compInfo setMinute:outDate.month];
    [compInfo setSecond:outDate.day];
    return compInfo;
}

+(NSString*)DateComponents2string:(NSDateComponents*)DateComponents
{
    NSString *str;
    if(DateComponents.month > 0)
    {
        str = [NSString stringWithFormat:@"倒计时：%d月%d天%d小时%d分钟", DateComponents.month, DateComponents.day, DateComponents.hour, DateComponents.minute];
    }
    else if(DateComponents.day > 0)
    {
        str = [NSString stringWithFormat:@"倒计时：%d天%d小时%d分钟", DateComponents.day, DateComponents.hour, DateComponents.minute];
    }
    else if (DateComponents.hour > 0)
    {
        str = [NSString stringWithFormat:@"倒计时：%d小时%d分钟", [DateComponents hour], [DateComponents minute]];
    }
    else if (DateComponents.minute > 0)
    {
        str = [NSString stringWithFormat:@"倒计时：%d分钟", [DateComponents minute]];
    }
    else
    {
        str = @"活动已过期";
    }
    return str;
}

+(id)GetChildren:(UIView*)Parents className:(Class)class Tag:(NSInteger)tag
{
    for (UIView* sub in Parents.subviews)
    {
        if([sub isKindOfClass:class] && sub.tag == tag)
        {
            return sub;
        }
    }
    return nil;
}

+(NSDateComponents*)DateNow
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *now;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | 
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    now=[NSDate date];
    comps = [calendar components:unitFlags fromDate:now];
    
    return comps;
}
@end
