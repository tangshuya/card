//
//  ViewController.m
//  IDCardsFolding
//
//  Created by aaa on 2019/4/24.
//  Copyright © 2019 TangShuya. All rights reserved.
//

#import "ViewController.h"
#import "TSYBaseCardViewController.h"
#import "TSYVipViewController.h"
#import "TSYLiveViewController.h"
#import "TSYVoucherViewController.h"
#import "TSYBankViewController.h"
#import "TSYButton.h"
#import "UIView+TSYView.h"
//  获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0                                                     \
blue:((float)(rgbValue & 0xFF))/255.0                                                               \
alpha:1.0]

#define UIColorFromRGBalpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0                                                     \
blue:((float)(rgbValue & 0xFF))/255.0                                                               \
alpha:a]
@interface ViewController ()<UIScrollViewDelegate>
/** 用来显示所有子控制器view的scrollView */
@property (nonatomic, weak) UIScrollView *scrollView;
/** 上一次被点击的按钮 */
@property (nonatomic, weak) TSYButton *clickedButton;
/** 下划线 */
@property (nonatomic, weak) UIView *underline;
/** 标题栏 */
@property (nonatomic, weak) UIView *titlesView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的卡包";
    [self setUpInterface];
}
-(void)setUpInterface{
//    界面设置
    // 添加所有的子控制器
    [self setupAllChildVcs];
    // 添加中间的
    [self setupScrollView];
    // 添加标题
    [self setupTitlesView];
    // 默认添加一个子控制器的view到scrollView中
    [self addChildVcViewIntoScrollView];
    
}
#pragma mark--添加所有的子控制器
- (void)setupAllChildVcs
{
    [self addChildViewController:[[TSYLiveViewController alloc] init]];
    [self addChildViewController:[[TSYBankViewController alloc] init]];
    [self addChildViewController:[[TSYVoucherViewController alloc] init]];
    [self addChildViewController:[[TSYVipViewController alloc] init]];
    
}
#pragma mark--添加中间的scrollView
- (void)setupScrollView
{
    // 不要自动设置内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    // 设置scrollView的内容宽度（左右滚动）
    CGSize contentSize = scrollView.contentSize;
    contentSize.width = self.childViewControllers.count * scrollView.frame.size.width;
    scrollView.contentSize = contentSize;
    
    scrollView.pagingEnabled = YES;
    
    self.scrollView = scrollView;
}
#pragma mark--添加标题栏
- (void)setupTitlesView
{
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    // 标题栏
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = UIColorFromRGBalpha(0Xe5e5e5, 1.0);
    titlesView.frame = CGRectMake(0, 64, screenW, 50);
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    // 标题按钮
    // 标题文字
    NSArray *titles = @[@"全部", @"银行", @"券",@"会员"];
    NSUInteger count = titles.count;
    // 标题按钮的尺寸
    CGFloat titleButtonW = screenW / count;
    CGFloat titleButtonH = 50;
    // 往标题栏中添加count个标题
    for (int i = 0; i < count; i++) {
        // 创建-添加
        TSYButton *titleButton = [TSYButton buttonWithType:UIButtonTypeCustom];
        titleButton.tag = i;
        [self.titlesView addSubview:titleButton];
        [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        // frame
        titleButton.frame = CGRectMake(i * titleButtonW, 0, titleButtonW, titleButtonH);
        // 设置文字
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
    }
    
    // 添加下划线
    // 取出最前面的按钮
    TSYButton *firstTitleButton = self.titlesView.subviews.firstObject;
    UIView *underline = [[UIView alloc] init];
    underline.backgroundColor = [firstTitleButton titleColorForState:UIControlStateSelected];
    [self.titlesView addSubview:underline];
    underline.height = 2;
    underline.y = self.titlesView.height - underline.height;
    // 默认点击了最前面的按钮
    // 切换按钮的状态 来 切换按钮的文字颜色
    firstTitleButton.selected = YES;
    firstTitleButton.titleLabel.font = [UIFont systemFontOfSize:15];
    self.clickedButton = firstTitleButton;
    // 让按钮内部的titleLabel根据文字内容自动计算大小
    [firstTitleButton.titleLabel sizeToFit];
    // 下划线宽度
    underline.width = firstTitleButton.titleLabel.width + 10;
    // 下划线中心点
    underline.centerX = firstTitleButton.centerX;
    self.underline = underline;
}


#pragma mark - <UIScrollViewDelegate>
/**
 *  当scrollView停止滚动时调用
 *  前提：通过调用scrollView的以下2个方法导致停止滚动
 - (void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated;
 - (void)scrollRectToVisible:(CGRect)rect animated:(BOOL)animated;
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self addChildVcViewIntoScrollView];
}

/**
 *  当scrollView停止滚动时调用
 *  前提：通过拖拽的方式让scrollView滚动后减速完毕
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 按钮的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    // 对应的按钮
    TSYButton *titleButton = self.titlesView.subviews[index];
    // 点击对应的按钮
    [self titleClick:titleButton];
    
    // 添加对应位置的子控制器view到scrollView中
    [self addChildVcViewIntoScrollView];
}


#pragma mark - 其它
/**
 *  添加对应位置的子控制器view到scrollView中
 */
- (void)addChildVcViewIntoScrollView
{
    // 子控制器的索引
    NSInteger index = self.scrollView.contentOffset.x / self.scrollView.frame.size.width;
    
    // 取出对应位置的子控制器
    UIViewController *childVc = self.childViewControllers[index];
    // 如果这个子控制器的view已经添加过了，那么直接返回
    if (childVc.isViewLoaded) return;
    
    // 添加子控制器的view到scrollView
    [self.scrollView addSubview:childVc.view];
    // 设置子控制器view的frame
    childVc.view.frame = self.scrollView.bounds;
}

#pragma mark - 监听 标题按钮事件

- (void)titleClick:(TSYButton *)titleButton
{
    
    // 切换按钮的状态 来 切换按钮的文字颜色
    self.clickedButton.titleLabel.font = [UIFont systemFontOfSize:13];
    self.clickedButton.selected = NO;
    titleButton.selected = YES;
    titleButton.titleLabel.font = [UIFont systemFontOfSize:15];
    self.clickedButton = titleButton;
    // 移动下划线
    [UIView animateWithDuration:0.25 animations:^{
        // 宽度
        self.underline.width = titleButton.titleLabel.width + 10;
        
        // 中心点
        self.underline.centerX = titleButton.centerX;
    }];
    
    // 让scrollView滚动到对应的子控制器界面
    // 按钮的索引
    NSInteger index = titleButton.tag;
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = index * self.scrollView.width;
    [self.scrollView setContentOffset:offset animated:YES];
}


@end
