//
//  NSString+JGDecimalNumber.m
//  LH_QJ
//
//  Created by 郭军 on 2018/5/23.
//  Copyright © 2018年 LHYD. All rights reserved.
//  处理高进度数字的工具类

#import "NSString+JGDecimalNumber.h"

@implementation NSString (JGDecimalNumber)


+ (NSString *)stringOfDoubleValueAfterPoint:(NSString *)value{
    NSDecimalNumber * valueNum = [NSDecimalNumber decimalNumberWithString:value];
    NSDecimalNumberHandler * handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSNumberFormatter * formatter = [[NSNumberFormatter alloc]init];
    formatter.zeroSymbol = @"--";
    formatter.positiveFormat = @"#.00";
    return [formatter stringFromNumber:[valueNum decimalNumberByRoundingAccordingToBehavior:handler]];
}

+ (NSString *)stringOfDoubleValueAfterPointDefaultZero:(NSString *)value{
    NSDecimalNumber * valueNum = [NSDecimalNumber decimalNumberWithString:value];
    NSDecimalNumberHandler * handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSNumberFormatter * formatter = [[NSNumberFormatter alloc]init];
    formatter.positiveFormat = @"#.00";
    formatter.zeroSymbol = @"0.00";
    return [formatter stringFromNumber:[valueNum decimalNumberByRoundingAccordingToBehavior:handler]];
}

+ (NSString *)stringOfDoubleValueAfterPointRemoveEndZero:(NSString *)value{
    NSDecimalNumber * valueNum = [NSDecimalNumber decimalNumberWithString:value];
    NSDecimalNumberHandler * handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSNumberFormatter * formatter = [[NSNumberFormatter alloc]init];
    formatter.zeroSymbol = @"--";
    formatter.maximumFractionDigits = 2;
    return [formatter stringFromNumber:[valueNum decimalNumberByRoundingAccordingToBehavior:handler]];
}

+ (NSString *)stringOfDoubleValueAfterPointDefaultZeroRemoveEndZero:(NSString *)value{
    NSDecimalNumber * valueNum = [NSDecimalNumber decimalNumberWithString:value];
    NSDecimalNumberHandler * handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSNumberFormatter * formatter = [[NSNumberFormatter alloc]init];
    formatter.zeroSymbol = @"0";
    formatter.maximumFractionDigits = 2;
    return [formatter stringFromNumber:[valueNum decimalNumberByRoundingAccordingToBehavior:handler]];
}

+ (NSString *)stringOfThreeValueAfterPoint:(NSString *)value{
    NSDecimalNumber * valueNum = [NSDecimalNumber decimalNumberWithString:value];
    NSDecimalNumberHandler * handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:3 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSNumberFormatter * formatter = [[NSNumberFormatter alloc]init];
    formatter.zeroSymbol = @"--";
    formatter.positiveFormat = @"#.000";
    return [formatter stringFromNumber:[valueNum decimalNumberByRoundingAccordingToBehavior:handler]];
}

+ (NSString *)stringOfThreeValueAfterPointDefaultZero:(NSString *)value{
    NSDecimalNumber * valueNum = [NSDecimalNumber decimalNumberWithString:value];
    NSDecimalNumberHandler * handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:3 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSNumberFormatter * formatter = [[NSNumberFormatter alloc]init];
    formatter.positiveFormat = @"#.000";
    formatter.zeroSymbol = @"0.000";
    return [formatter stringFromNumber:[valueNum decimalNumberByRoundingAccordingToBehavior:handler]];
}

+ (NSString *)stringOfThreeValueAfterPointRemoveEndZero:(NSString *)value{
    NSDecimalNumber * valueNum = [NSDecimalNumber decimalNumberWithString:value];
    NSDecimalNumberHandler * handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:3 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSNumberFormatter * formatter = [[NSNumberFormatter alloc]init];
    formatter.zeroSymbol = @"--";
    formatter.maximumFractionDigits = 3;
    return [formatter stringFromNumber:[valueNum decimalNumberByRoundingAccordingToBehavior:handler]];
}

+ (NSString *)stringOfThreeValueAfterPointDefaultZeroRemoveEndZero:(NSString *)value{
    NSDecimalNumber * valueNum = [NSDecimalNumber decimalNumberWithString:value];
    NSDecimalNumberHandler * handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:3 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSNumberFormatter * formatter = [[NSNumberFormatter alloc]init];
    formatter.zeroSymbol = @"0.000";
    formatter.maximumFractionDigits = 3;
    return [formatter stringFromNumber:[valueNum decimalNumberByRoundingAccordingToBehavior:handler]];
}

+ (NSString *)stringToPercentageWithDoubleValueAfterPointRemoveEndZero:(NSString *)value{
    NSDecimalNumber * valueNum = [NSDecimalNumber decimalNumberWithString:value];
    NSDecimalNumberHandler * handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSNumberFormatter * formatter = [[NSNumberFormatter alloc]init];
    formatter.zeroSymbol = @"--";
    formatter.positiveFormat = @"#.00%";
    return [formatter stringFromNumber:[valueNum decimalNumberByRoundingAccordingToBehavior:handler]];
}

+ (NSString *)stringToPercentageWithDoubleValueAfterPointDefaultZero:(NSString *)value{
    NSDecimalNumber * valueNum = [NSDecimalNumber decimalNumberWithString:value];
    NSDecimalNumberHandler * handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSNumberFormatter * formatter = [[NSNumberFormatter alloc]init];
    formatter.positiveFormat = @"#.00%";
    formatter.zeroSymbol = @"0.00%";
    return [formatter stringFromNumber:[valueNum decimalNumberByRoundingAccordingToBehavior:handler]];
}

+ (NSString *)stringToPercentageWithThreeValueAfterPointRemoveEndZero:(NSString *)value{
    NSDecimalNumber * valueNum = [NSDecimalNumber decimalNumberWithString:value];
    NSDecimalNumberHandler * handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:3 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSNumberFormatter * formatter = [[NSNumberFormatter alloc]init];
    formatter.positiveFormat = @"#.000%";
    formatter.zeroSymbol = @"--";
    return [formatter stringFromNumber:[valueNum decimalNumberByRoundingAccordingToBehavior:handler]];
}

+ (NSString *)stringToPercentageWithThreeValueAfterPointDefaultZero:(NSString *)value{
    NSDecimalNumber * valueNum = [NSDecimalNumber decimalNumberWithString:value];
    NSDecimalNumberHandler * handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:3 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSNumberFormatter * formatter = [[NSNumberFormatter alloc]init];
    formatter.positiveFormat = @"#.000%";
    formatter.zeroSymbol = @"0.000%";
    return [formatter stringFromNumber:[valueNum decimalNumberByRoundingAccordingToBehavior:handler]];
}



@end
