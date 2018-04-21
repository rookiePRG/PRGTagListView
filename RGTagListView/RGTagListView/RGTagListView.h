//
//  RGTagListView.h
//  RGTagListView
//
//  Created by change_pan on 2018/4/21.
//  Copyright © 2018年 kocla. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RGTagListView : UIView

//默认标签
@property (nonatomic, assign) CGFloat tagListH;//标签列表的高度

@property (nonatomic, assign) CGFloat tagBtnH;//标签的高度

@property (nonatomic, assign) CGFloat tagMarginW;//标签与标签之间的间距(左右)

@property (nonatomic, assign) CGFloat tagMarginH;//标签与标签之间的间距(上下)

@property (nonatomic, assign) CGFloat tagCornerRadius;//圆角

@property (nonatomic, assign) CGFloat tagBorderWidth;//边框宽度

@property (nonatomic, strong) UIColor *tagBorderColor;//边框线条颜色

@property (nonatomic, assign) CGFloat tagFontSize;//字体大小

@property (nonatomic, strong) UIColor *tagBackgroundColor;//背景颜色

@property (nonatomic, strong) UIColor *tagTextColor;//字体颜色

@property (nonatomic, strong) NSMutableArray *tagBtns;//获取所有标签

//是否是自定义标签
@property (nonatomic, assign) BOOL isCustom;

//自定义标签需要
@property (nonatomic, assign) CGFloat customTagDefaultW;//自定义标签距离左边的最初宽度

@property (nonatomic, assign) CGFloat customTagDefaultH;//自定义标签距离顶部的最初高度

@property (nonatomic, assign) CGFloat customTagLabH;//自定义标签中Lab的高度

@property (nonatomic, assign) CGFloat customTagImagViewH;//自定义标签中图片的高度

@property (nonatomic, assign) CGFloat customTagLabImageMarginW;//自定义标签中Lab与图片的重合的宽度

@property (nonatomic, assign) CGFloat customTagLabImageMarginH;//自定义标签中Lab与图片的重合的宽度

@property (nonatomic, strong) UIImage *customTagDelImage;//自定义标签中的删除图片

@property (nonatomic, strong) NSMutableArray *tagStrs; //获取所有自定义标签

//项目需要
@property (nonatomic, strong) UIColor *tagTextColor_sel;//选中字体颜色

@property (nonatomic, strong) UIColor *tagBackgroundColor_sel;//选中背景颜色

@property (nonatomic, strong) UIColor *tagBorderColor_sel;//选中边框线条颜色

/**
 添加标签
 
 @param tagStr 标签内容
 @param isSelect 是否可以选择
 */
- (void)addTag:(NSString *)tagStr isSelected:(BOOL)isSelect;

/**
 添加自定义标签
 
 @param tagStr 标签内容
 */
-(void)addCustomTag:(NSString *)tagStr;

/**
 删除标签
 
 @param tagStr 标签内容
 */
- (void)deleteTag:(NSString *)tagStr;

/**
 点击标签
 */
@property (nonatomic, copy) void(^clickTagBlock)(NSString *tagStr, BOOL tagSelect);

@end
