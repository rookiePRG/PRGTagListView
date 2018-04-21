//
//  ViewController.m
//  RGTagListView
//
//  Created by change_pan on 2018/4/21.
//  Copyright © 2018年 kocla. All rights reserved.
//

#import "ViewController.h"
#import "RGTagListView.h"

#define kScreen_Width    [[UIScreen mainScreen] bounds].size.width
#define kScreen_Height   [[UIScreen mainScreen] bounds].size.height
#define WS(weakSelf) __weak __typeof(&*self) weakSelf = self;
@interface ViewController ()
@property (nonatomic, strong) RGTagListView *tagListView;
@end

@implementation ViewController

-(RGTagListView *)tagListView{

    if (!_tagListView) {
        _tagListView = [[RGTagListView alloc] initWithFrame:CGRectMake(0, 64, kScreen_Width, 0)];
        _tagListView.backgroundColor = [UIColor redColor];
    }
    return _tagListView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tagListView];
    _tagListView.customTagDelImage = [UIImage imageNamed:@"icon_del"];
    _tagListView.isCustom = YES;
    _tagListView.tagMarginW = 6;
    _tagListView.tagMarginH = 7;
    WS(weakSelf);
    _tagListView.clickTagBlock = ^(NSString *tagStr, BOOL tagSelect) {
        
        [weakSelf.tagListView deleteTag:tagStr];
    };
}

- (IBAction)addTag:(UIButton *)sender {
    [_tagListView addCustomTag:[NSString stringWithFormat:@"测试%u",arc4random_uniform(10000)]];
}

@end
