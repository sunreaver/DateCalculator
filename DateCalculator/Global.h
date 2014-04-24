//
//  Global.h
//  Orion
//
//  Created by Wei Tan on 12-5-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Global : NSObject
+(void)setStrNetData:(NSString*)newData;
+(NSString*)StrNetData;
+ (UIImage *) imageFromURLString: (NSString *) urlstring;
+(NSDateComponents *) dateDiff:(NSString*)toDate;
+(NSDateComponents *) dateDiff:(NSString*)toDate FromDate:(NSString*)fromDate;
+(NSString*)DateComponents2string:(NSDateComponents*)DateComponents;
+(id)GetChildren:(UIView*)Parents className:(Class)class Tag:(NSInteger)tag;
+(NSDateComponents*)DateNow;

//时分秒依次代表计算出的年月日， 其它参数的值dateDiff:FromDate 一样
+(NSDateComponents *) diffToDate:(NSString*)baseDate DiffDays:(double)diffDays;
@end
