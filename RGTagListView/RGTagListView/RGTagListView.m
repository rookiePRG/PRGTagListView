//
//  RGTagListView.m
//  RGTagListView
//
//  Created by change_pan on 2018/4/21.
//  Copyright © 2018年 kocla. All rights reserved.
//

#import "RGTagListView.h"
#import "UIColor+Category.h"

@interface RGTagListView ()

@property (nonatomic, strong) NSMutableArray *tagViews;

@property (nonatomic, strong) NSMutableDictionary *tags;

@property (nonatomic, strong) NSMutableArray *delButtons;

@end

@implementation RGTagListView

#pragma mark - 懒加载

-(NSMutableArray *)tagBtns
{
    if (_tagBtns == nil) {
        _tagBtns = [NSMutableArray array];
    }
    return _tagBtns;
}

-(NSMutableArray *)tagViews
{
    if (_tagViews == nil) {
        _tagViews = [NSMutableArray array];
    }
    return _tagViews;
}

-(NSMutableArray *)tagStrs
{
    if (_tagStrs == nil) {
        _tagStrs = [NSMutableArray array];
    }
    return _tagStrs;
}

-(NSMutableDictionary *)tags
{
    if (_tags == nil) {
        _tags = [NSMutableDictionary dictionary];
    }
    return _tags;
}

-(NSMutableArray *)delButtons
{
    if (!_delButtons) {
        _delButtons =[NSMutableArray array];
    }
    return _delButtons;
}


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
    
}

//初始化
-(void)setup
{
    _tagBtnH = 32;
    _tagMarginW = 16;
    _tagMarginH = 12;
    _tagCornerRadius = 6;
    _tagBorderWidth = 0.5;
    _tagBorderColor = [UIColor colorWithHexString:@"cccccc"];
    _tagFontSize = 15.0;
    _tagBackgroundColor = [UIColor whiteColor];
    _tagBackgroundColor_sel = [UIColor colorWithHexString:@"fff9f1"];
    _tagTextColor = [UIColor blackColor];
    _tagTextColor_sel = [UIColor colorWithHexString:@"ff9000"];
    
    _isCustom = NO;
    
    _customTagDefaultH = 0;
    _customTagDefaultW = 16;
    _customTagLabH = 28;
    _customTagImagViewH = 20;
    _customTagLabImageMarginW = 10;
    _customTagLabImageMarginH = 10;
    
}


- (void)addTag:(NSString *)tagStr isSelected:(BOOL)isSelect
{
    UIButton *tagBtn = [[UIButton alloc] init];
    tagBtn.layer.masksToBounds = YES;
    tagBtn.layer.cornerRadius = _tagCornerRadius;
    tagBtn.layer.borderWidth = _tagBorderWidth;
    tagBtn.layer.borderColor = _tagBorderColor.CGColor;
    tagBtn.clipsToBounds = YES;
    tagBtn.titleLabel.font = [UIFont systemFontOfSize:_tagFontSize];
    tagBtn.backgroundColor = _tagBackgroundColor;
    [tagBtn setTitle:tagStr forState:UIControlStateNormal];
    [tagBtn setTitleColor:_tagTextColor forState:UIControlStateNormal];
    tagBtn.tag = self.tagBtns.count;
    [self addSubview:tagBtn];
    
    if (isSelect)
    {
        [tagBtn setTitleColor:_tagTextColor_sel forState:UIControlStateSelected];
        [tagBtn addTarget:self action:@selector(select_click:) forControlEvents:UIControlEventTouchUpInside];
        tagBtn.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"];
        tagBtn.layer.borderColor = [UIColor colorWithHexString:@"f6f6f6"].CGColor;
    }
    
    
    [self.tagBtns addObject:tagBtn];
    
    [self updateTagBtnFrame:tagBtn.tag];
    
    CGRect frame = self.frame;
    frame.size.height = self.tagListH;
    [UIView animateWithDuration:0.1 animations:^{
        self.frame = frame;
    }];
    
}

//添加自定义标签
-(void)addCustomTag:(NSString *)tagStr
{
    UIView *tagView = [[UIView alloc] init];
    tagView.tag = self.tagViews.count;
    tagView.userInteractionEnabled = YES;
    [self addSubview:tagView];
    
    [self.tagViews addObject:tagView];
    [self.tagStrs addObject:tagStr];
    [self.tags setObject:tagView forKey:tagStr];
    
    CGRect frame = [self updateCustomTagFrame:tagView.tag];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0,10, frame.size.width-10, 28)];
    lab.text = tagStr;
    lab.font = [UIFont systemFontOfSize:_tagFontSize];
    lab.backgroundColor = _tagTextColor_sel;
    lab.layer.masksToBounds = YES;
    lab.textColor = [UIColor whiteColor];
    lab.layer.cornerRadius = 6;
    lab.textAlignment = NSTextAlignmentCenter;
    [tagView addSubview:lab];
    
    UIButton *del_btn = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width-20, 0, 20, 20)];
    del_btn.tag = 10 +tagView.tag;
    [del_btn setImage:_customTagDelImage forState:UIControlStateNormal];
    [tagView addSubview:del_btn];
    
    [del_btn addTarget:self action:@selector(del_click:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.delButtons addObject:del_btn];
    
    CGRect tempFrame = self.frame;
    tempFrame.size.height = self.tagListH;
    [UIView animateWithDuration:0.1 animations:^{
        self.frame = tempFrame;
    }];
}

-(void)del_click:(UIButton *)btn
{
    if (_clickTagBlock) {
        _clickTagBlock(self.tagStrs[btn.tag -10],btn.selected);
    }
}

// 删除标签
- (void)deleteTag:(NSString *)tagStr
{
    // 获取对应的标题View
    UIView *tempView = self.tags[tagStr];
    
    // 移除View
    [tempView removeFromSuperview];
    
    // 移除数组
    [self.tagViews removeObject:tempView];
    [self.delButtons removeObjectAtIndex:tempView.tag];
    
    // 移除字典
    [self.tags removeObjectForKey:tagStr];
    
    // 移除数组
    [self.tagStrs removeObject:tagStr];
    
    // 更新tag
    [self updateTag];
    
    // 更新后面View 的frame
    [UIView animateWithDuration:0.25 animations:^{
        [self updateLaterTagButtonFrame:tempView.tag];
    }];
    
    // 更新自己的frame
    CGRect frame = self.frame;
    frame.size.height = self.tagListH ? self.tagListH : 45;
    [UIView animateWithDuration:0.1 animations:^{
        self.frame = frame;
    }];
    
}

// 更新标签
- (void)updateTag
{
    NSInteger count = self.tagViews.count;
    for (int i = 0; i < count; i++) {
        UIView *tagButton = self.tagViews[i];
        tagButton.tag = i;
        UIButton *delButton = self.delButtons[i];
        delButton.tag = i +10;
        
    }
}

// 更新以后View
- (void)updateLaterTagButtonFrame:(NSInteger)laterI
{
    NSInteger count = self.tagViews.count;
    
    for (NSInteger i = laterI; i < count; i++) {
        // 更新View
        [self updateCustomTagFrame:i];
    }
}



-(void)select_click:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    if (sender.selected)
    {
        sender.backgroundColor = _tagBackgroundColor_sel;
        sender.layer.borderColor = _tagTextColor_sel.CGColor;
    }
    else
    {
        
        sender.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"];
        sender.layer.borderColor = [UIColor colorWithHexString:@"f6f6f6"].CGColor;
    }
    
    if (_clickTagBlock) {
        _clickTagBlock(sender.currentTitle,sender.selected);
    }
}

- (CGFloat)tagListH
{
    if (_isCustom)
    {
        if (self.tagViews.count <= 0) return 0;
        return CGRectGetMaxY([self.tagViews.lastObject frame]) + _tagMarginH;
    }
    else
    {
        if (self.tagBtns.count <= 0) return 0;
        return CGRectGetMaxY([self.tagBtns.lastObject frame]) + _tagMarginH + 6;
    }
    
}

- (void)updateTagBtnFrame:(NSInteger)tagBtn_tag
{
    //获取上一个btn
    NSInteger pre_tag = tagBtn_tag - 1;
    
    //定义上一个btn
    UIButton *preBtn;
    
    //判断是不是第一个btn
    if (pre_tag >= 0) {
        
        preBtn = self.tagBtns[pre_tag];
    }
    
    //获取当前Btn
    UIButton *curBtn = self.tagBtns[tagBtn_tag];
    
    //设置标签Frame
    [self setupTagBtnCustomFrame:curBtn preBtn:preBtn];
}

//更新自定义标签的frame
-(CGRect)updateCustomTagFrame:(NSInteger)tagView_tag
{
    //获取上一个View
    NSInteger pre_tag = tagView_tag - 1;
    
    //定义上一个View
    UIView *preView;
    
    //过滤上一个角标
    if (pre_tag >= 0) {
        preView = self.tagViews[pre_tag];
    }
    
    //获取当前View
    CGRect temp_frame;
    UIView *tagView = self.tagViews[tagView_tag];
    
    temp_frame = [self setupCustomTagFrame:tagView preButton:preView];
    
    return temp_frame;
}

// 设置标签按钮frame（自适应）
- (void)setupTagBtnCustomFrame:(UIButton *)curBtn preBtn:(UIButton *)preBtn
{
    CGFloat labX = CGRectGetMaxX(preBtn.frame) + _tagMarginW;
    CGFloat labY = preBtn ? preBtn.frame.origin.y : _tagMarginH;
    CGFloat labW = [self getContentHightWithContent:curBtn.titleLabel.text font:[UIFont systemFontOfSize:_tagFontSize] constraint:CGSizeMake(1000, _tagBtnH)].width+24;
    CGFloat labH = _tagBtnH;
    
    // 判断当前btn是否足够显示
    CGFloat rightWidth = self.bounds.size.width - labX;
    
    if (rightWidth < (labW+_tagMarginW)) {
        // 不够显示，显示到下一行
        labX = _tagMarginW;
        labY = CGRectGetMaxY(preBtn.frame) + _tagMarginH;
    }
    
    curBtn.frame = CGRectMake(labX, labY, labW, labH);
}

//设置自定义标签frame（自适应）
-(CGRect)setupCustomTagFrame:(UIView *)tagView preButton:(UIView *)preView
{
    //上一个View的最大X + 间距
    CGFloat ViewX = preView ? CGRectGetMaxX(preView.frame) + _tagMarginW : _customTagDefaultW;
    
    //上一个View的Y值
    CGFloat ViewY = preView ? preView.frame.origin.y : _customTagDefaultH;
    
    //获取View的宽度
    CGFloat titleW = [self getContentHightWithContent:self.tagStrs[tagView.tag] font:[UIFont systemFontOfSize:_tagFontSize] constraint:CGSizeMake(1000, _customTagLabH)].width+24;
    CGFloat titleH = _customTagLabH;
    CGFloat ViewW = titleW + _customTagImagViewH - _customTagLabImageMarginW;
    
    //获取View的高度
    CGFloat ViewH = titleH + _customTagImagViewH - _customTagLabImageMarginH;
    
    // 判断当前View是否足够显示
    CGFloat rightWidth = self.bounds.size.width - ViewX;
    
    if (rightWidth < (ViewW+_tagMarginW)) {
        
        //不够 显示到下一行
        ViewX = _customTagDefaultW;
        ViewY = CGRectGetMaxY(preView.frame) + _tagMarginH;
        
    }
    
    tagView.frame = CGRectMake(ViewX, ViewY, ViewW, ViewH);
    
    return tagView.frame;
}



- (CGSize)getContentHightWithContent:(NSString *)content font:(UIFont *)font constraint:(CGSize)constraint
{
    
    CGSize size ;
    
    size = [content boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    
    return  size;
}

@end
