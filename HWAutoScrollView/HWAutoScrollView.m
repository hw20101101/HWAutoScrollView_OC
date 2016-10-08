//
//  HWAutoScrollView.m
//  AutoScroll 
//
//  Created by hw on 16/9/19.
//  Copyright © 2016年 hwacdx. All rights reserved.
//

#import "HWAutoScrollView.h"

@interface HWAutoScrollView ()<UIScrollViewDelegate>

/**
 * 轮播的图片数组
 */
@property (nonatomic, strong) NSArray *imageArray;

/**
 * 占位图片名
 */
@property (nonatomic, strong) NSString *placeHolder;

/**
 * 滚到视图
 */
@property (nonatomic, strong) UIScrollView *scrollView;

/**
 * 分页控制器
 */
@property (nonatomic, strong) UIPageControl *pageControl;

/**
 * 分页控制器的宽度
 */
@property (nonatomic, assign) CGFloat pageControlWidth;


/**
 * 定时器(1s调用一次)
 */
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation HWAutoScrollView

- (instancetype)initWithImageNameArray:(NSArray *)imageNameArray imageOnClickCallBack:(void (^)())imageOnClickCallBack
{
    if (self = [super init]) {         
        _imageArray = imageNameArray;
        _imageOnClickCallBack = imageOnClickCallBack;
        [self initControlsIsRemoteImage:NO];
    }
    return self;
}

- (instancetype)initWithImageUrlArray:(NSArray *)imageUrlArray placeHolder:(NSString *)placeHolder imageOnClickCallBack:(void (^)())imageOnClickCallBack
{
    if (self = [super init]) {
        _placeHolder = placeHolder;
        _imageArray = imageUrlArray;
        _imageOnClickCallBack = imageOnClickCallBack;
        [self initControlsIsRemoteImage:YES];
    }
    return self;
}

#pragma mark - initControls
/**
 * 初始化控件
 * @param isRemote 是否为远程图片
 */
- (void)initControlsIsRemoteImage:(BOOL)isRemote
{
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
    [self initImageViews:isRemote];
    self.pageControlWidth = self.imageArray.count * 16;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timingAction) userInfo:nil repeats:YES];
}

/**
 * 初始化图片数组
 * @param isRemote 是否为远程图片
 */
- (void)initImageViews:(BOOL)isRemote
{
    __weak typeof(self) weakSelf = self;
    
    for (int i = 0; i < self.imageArray.count; i++) {
        CGFloat imageViewX = i * SCREEN_WIDTH;
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.tag = i;
        imageView.clipsToBounds = YES;
        imageView.userInteractionEnabled = YES;
        imageView.contentMode = self.imageViewContentMode;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewAction:)]];
        [self.scrollView addSubview:imageView];
        
        if (isRemote) {//远程图片
            NSString *imageUrlStr = self.imageArray[i];
            [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrlStr] placeholderImage:[UIImage imageNamed:weakSelf.placeHolder]];
            
        } else {//本地图片
            imageView.image = [UIImage imageNamed:self.imageArray[i]];
        }
        
        [imageView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.scrollView).offset(imageViewX);
            make.top.height.width.equalTo(weakSelf.scrollView);
        }];
    }
}

#pragma mark - 滚动视图
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        CGFloat contentWidth = self.imageArray.count * SCREEN_WIDTH;
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.contentSize = CGSizeMake(contentWidth, 0);
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.scrollView];
        
        __weak typeof(self) weakSelf = self;
        [_scrollView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf);
        }];
    }
    return _scrollView;
}

#pragma mark   分页控制器
- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.currentPage = 0;
        _pageControl.numberOfPages = self.imageArray.count;
        _pageControl.userInteractionEnabled = NO;
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    }
    return _pageControl;
}

#pragma mark - 倒计时事件
- (void)timingAction
{
    CGFloat lastContent = SCREEN_WIDTH * (self.imageArray.count - 1);
    if (self.scrollView.contentOffset.x == lastContent) {//已经滚到最后一张
        self.pageControl.currentPage = 0;
    } else {
        self.pageControl.currentPage ++;
    }
    
    CGPoint point = self.scrollView.contentOffset;
    point.x = SCREEN_WIDTH * self.pageControl.currentPage;
    [self.scrollView setContentOffset:point animated:YES];
    [self.pageControl updateCurrentPageDisplay];
}

#pragma mark   图片点击事件
- (void)imageViewAction:(UIGestureRecognizer *)tap
{
    [self.timer invalidate];
    self.timer = nil;
    int tag = tap.view.tag;
    
    if (self.imageOnClickCallBack) {
        self.imageOnClickCallBack(tag);
    }
}

#pragma mark - scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int index = scrollView.contentOffset.x / SCREEN_WIDTH;
    self.pageControl.currentPage = index;
    [self.pageControl updateCurrentPageDisplay];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    __weak typeof(self) weakSelf = self;
    
    if (self.pageControlPosition == HWPageControlPositionLeft) {//设置分页控制器靠左
        [self.pageControl makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf).offset(10);
        }];
        
    } else if(self.pageControlPosition == HWPageControlPositionRight){//设置分页控制器靠右
        [self.pageControl makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf).offset(-10);
        }];
        
    } else {
        [self.pageControl makeConstraints:^(MASConstraintMaker *make) {//设置分页控制器居中
            make.centerX.equalTo(weakSelf.centerX);
        }];
    }
    
    [self.pageControl updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.bottom).offset(-10);
        make.size.mas_equalTo(CGSizeMake(weakSelf.pageControlWidth, 15));
    }];
}

@end
