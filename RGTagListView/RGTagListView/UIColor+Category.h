//
//  UIColor+Category.h
//  RGTagListView
//
//  Created by change_pan on 2018/4/21.
//  Copyright © 2018年 kocla. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Category)

+ (UIColor *)colorWithHex:(unsigned int)rgbValue;
+ (UIColor *)colorWithHexString:(NSString *)hexColor;
+ (UIColor *)colorRed:(int)red green:(int)green blue:(int)blue alpha:(int)alpha;

@end
