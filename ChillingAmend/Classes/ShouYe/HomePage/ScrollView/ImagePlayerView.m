//
//  ImagePlayerView.m
//  ImagePlayerView
//
//  Created by 陈颜俊 on 14-6-5.
//  Copyright (c) 2014年 Chenyanjun. All rights reserved.
//

#import "ImagePlayerView.h"

#define kStartTag   1000
//#define kDefaultScrollInterval  2
#define kDefaultScrollInterval  3

@interface ImagePlayerView() <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
//@property (nonatomic, strong) NSArray *imageURLs;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSTimer *autoScrollTimer;
@property (nonatomic, strong) PRJ_MyPageControll *pageControl;
@property (nonatomic, strong) NSMutableArray *pageControlConstraints;
@property (nonatomic, strong) NSArray *allDetails;

@property (nonatomic, strong) UILabel *detailLabel;

@property (nonatomic, strong) UIView *detailView;
@end

@implementation ImagePlayerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _init];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _init];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self _init];
    }
    return self;
}

- (void)_init
{
    self.scrollInterval = kDefaultScrollInterval;
    
    // scrollview
    self.scrollView = [[UIScrollView alloc] init];
    [self addSubview:self.scrollView];
    
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.directionalLockEnabled = YES;
    self.scrollView.delegate = self;
    // UIPageControl
    self.pageControl = [[PRJ_MyPageControll alloc] init];
    self.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    self.pageControl.translatesAutoresizingMaskIntoConstraints = NO;
    self.pageControl.numberOfPages = self.count;
    self.pageControl.currentPage = 0;
    [self addSubview:self.pageControl];
    
    NSArray *pageControlVConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[pageControl]-0-|"
                                                                               options:kNilOptions
                                                                               metrics:nil
                                                                                 views:@{@"pageControl": self.pageControl}];
    
    NSArray *pageControlHConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[pageControl]-|"
                                                                               options:kNilOptions
                                                                               metrics:nil
                                                                                 views:@{@"pageControl": self.pageControl}];
    
    self.pageControlConstraints = [NSMutableArray arrayWithArray:pageControlVConstraints];
    [self.pageControlConstraints addObjectsFromArray:pageControlHConstraints];
    
    [self addConstraints:self.pageControlConstraints];
    
    for (int i = 0; i < self.pageControl.numberOfPages; i++) {
        [(UIImageView *)self.pageControl.subviews[i] setSize:CGSizeMake(8, 8)];
    }
}

// @deprecated use - (void)initWithCount:(NSInteger)count delegate:(id<ImagePlayerViewDelegate>)delegate instead
- (void)initWithImageURLs:(NSArray *)imageURLs placeholder:(UIImage *)placeholder delegate:(id<ImagePlayerViewDelegate>)delegate
{
    [self initWithCount:imageURLs.count delegate:delegate edgeInsets:UIEdgeInsetsZero];
}

// @deprecated use - (void)initWithCount:(NSInteger)count delegate:(id<ImagePlayerViewDelegate>)delegate edgeInsets:(UIEdgeInsets)edgeInsets instead
- (void)initWithImageURLs:(NSArray *)imageURLs placeholder:(UIImage *)placeholder delegate:(id<ImagePlayerViewDelegate>)delegate edgeInsets:(UIEdgeInsets)edgeInsets
{
    [self initWithCount:imageURLs.count delegate:delegate edgeInsets:edgeInsets];
}

- (void)initWithCount:(NSInteger)count delegate:(id<ImagePlayerViewDelegate>)delegate
{
    [self initWithCount:count delegate:delegate edgeInsets:UIEdgeInsetsZero];
}

- (void)initWithCount:(NSInteger)count delegate:(id<ImagePlayerViewDelegate>)delegate edgeInsets:(UIEdgeInsets)edgeInsets
{
    //梁思远，2014年12月09日09:32，修改一张图仍轮播的问题
    //修改前代码行开始
    //count += 2;
    //修改前代码行结束
    //修改后代码行开始
    if (count>=2) {
        count += 2;
    }
    //修改结束
    
    self.count = count;
    self.imagePlayerViewDelegate = delegate;
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-%d-[scrollView]-%d-|", (int)edgeInsets.top, (int)edgeInsets.bottom]
                                                                 options:kNilOptions
                                                                 metrics:nil
                                                                   views:@{@"scrollView": self.scrollView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-%d-[scrollView]-%d-|", (int)edgeInsets.left, (int)edgeInsets.right]
                                                                 options:kNilOptions
                                                                 metrics:nil
                                                                   views:@{@"scrollView": self.scrollView}]];
    
    if (count == 0) {
        return;
    }
    
    self.pageControl.numberOfPages = count-2;
    self.pageControl.currentPage = 0;
    
    CGFloat startX = self.scrollView.bounds.origin.x;
    CGFloat width = self.bounds.size.width - edgeInsets.left - edgeInsets.right;
    CGFloat height = self.bounds.size.height - edgeInsets.top - edgeInsets.bottom;
    
    for (UIView *iv in self.scrollView.subviews) {
        if ([iv isKindOfClass:[UIImageView class]]) {
            [iv  removeFromSuperview];
        }
    }
    
    for (int i = 0; i < count; i++) {
        startX = i * width;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(startX, 0, width, height)];
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.tag = kStartTag + i;
        imageView.userInteractionEnabled = YES;
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)]];
        
        [imageView addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width]];
        [imageView addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height]];
        
        [self.imagePlayerViewDelegate imagePlayerView:self loadImageForImageView:imageView index:i];
        
        [self.scrollView addSubview:imageView];
    }
    
    // constraint
    NSMutableDictionary *viewsDictionary = [NSMutableDictionary dictionary];
    NSMutableArray *imageViewNames = [NSMutableArray array];
    for (int i = kStartTag; i < kStartTag + count; i++) {
        NSString *imageViewName = [NSString stringWithFormat:@"imageView%d", i - kStartTag];
        [imageViewNames addObject:imageViewName];
        
        UIImageView *imageView = (UIImageView *)[self.scrollView viewWithTag:i];
        [viewsDictionary setObject:imageView forKey:imageViewName];
    }
    
    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-0-[%@]-0-|", [imageViewNames objectAtIndex:0]]
                                                                            options:kNilOptions
                                                                            metrics:nil
                                                                              views:viewsDictionary]];
    
    NSMutableString *hConstraintString = [NSMutableString string];
    [hConstraintString appendString:@"H:|-0"];
    for (NSString *imageViewName in imageViewNames) {
        [hConstraintString appendFormat:@"-[%@]-0", imageViewName];
    }
    [hConstraintString appendString:@"-|"];
    
    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:hConstraintString
                                                                            options:NSLayoutFormatAlignAllTop
                                                                            metrics:nil
                                                                              views:viewsDictionary]];
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * count, self.scrollView.frame.size.height);
    self.scrollView.contentInset = UIEdgeInsetsZero;
    
    [NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(handleScrollTimer) userInfo:nil repeats:NO];
    
    for (int i = 0; i < self.pageControl.numberOfPages; i++) {
        [(UIImageView *)self.pageControl.subviews[i] setSize:CGSizeMake(8, 8)];
    }
    
}

//梁思远，2014年12月09日09:55:29，销毁定时器
-(void)invalidateMyTimer{
    [self.autoScrollTimer invalidate];
    self.autoScrollTimer=nil;
}
//修改结束

-(void)handleScrollTimer{
    [self.scrollView scrollRectToVisible:CGRectMake(320,0,320,self.scrollView.frame.size.height) animated:NO]; // 默认从序号1位置放第1页,序号0位置位置放第4页
}

- (void)handleTapGesture:(UIGestureRecognizer *)tapGesture
{
    UIImageView *imageView = (UIImageView *)tapGesture.view;
    NSInteger index = imageView.tag - kStartTag;
    
    if (self.imagePlayerViewDelegate && [self.imagePlayerViewDelegate respondsToSelector:@selector(imagePlayerView:didTapAtIndex:)]) {
        [self.imagePlayerViewDelegate imagePlayerView:self didTapAtIndex:index];
    }
}

#pragma mark - auto scroll
- (void)setAutoScroll:(BOOL)autoScroll
{
    _autoScroll = autoScroll;
    
    if (autoScroll) {
        if (!self.autoScrollTimer || !self.autoScrollTimer.isValid) {
            self.autoScrollTimer = [NSTimer scheduledTimerWithTimeInterval:self.scrollInterval target:self selector:@selector(handleScrollTimer:) userInfo:nil repeats:YES];
        }
    } else {
        if (self.autoScrollTimer && self.autoScrollTimer.isValid) {
            [self.autoScrollTimer invalidate];
            self.autoScrollTimer = nil;
        }
    }
}

- (void)setScrollInterval:(NSUInteger)scrollInterval
{
    _scrollInterval = scrollInterval;
    //梁思远，2014年12月09日09:53:19，修复重新进入页面圆钮位置不对的问题
    self.pageControl.currentPage = 0;
    //修改结束
    if (self.autoScrollTimer && self.autoScrollTimer.isValid) {
        [self.autoScrollTimer invalidate];
        self.autoScrollTimer = nil;
    }
    [self.scrollView scrollRectToVisible:CGRectMake(320,0,320,self.scrollView.frame.size.height) animated:NO]; // 默认从序号1位置放第1页,序号0位置位置放第4页
    self.autoScrollTimer = [NSTimer scheduledTimerWithTimeInterval:self.scrollInterval target:self selector:@selector(handleScrollTimer:) userInfo:nil repeats:YES];
    

}

- (void)handleScrollTimer:(NSTimer *)timer
{
    if (self.count == 0) {
        return;
    }
    
    CGFloat pagewidth = self.scrollView.frame.size.width;
    int currentPage = floor((self.scrollView.contentOffset.x - pagewidth/ (self.count+2)) / pagewidth) + 1;
    
    NSInteger nextPage = currentPage + 1;
    if (nextPage == self.count) {
        nextPage = 0;
    }
    
    UIImageView *imageView = (UIImageView *)[self.scrollView viewWithTag:(nextPage + kStartTag)];
    [self.scrollView scrollRectToVisible:imageView.frame animated:YES];
    

}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    CGFloat pagewidth = self.scrollView.frame.size.width;
    int currentPage = floor((self.scrollView.contentOffset.x - pagewidth/ (self.count+2)) / pagewidth) + 1;
//    NSLog(@"currentPage_==%d",currentPage);
    if (currentPage==0)
    {
        [self.scrollView scrollRectToVisible:CGRectMake(320 * (self.count - 2),0,320,460) animated:NO]; // 序号0 最后1页
//        self.detailLabel.text = self.allDetails[self.count - 3];
    }
    else if (currentPage==(self.count-1))
    {
        [self.scrollView scrollRectToVisible:CGRectMake(320,0,320,460) animated:NO]; // 最后+1,循环第1页
//        self.detailLabel.text = self.allDetails[0];
    }
    
    //    图片位置
    int current;
    if (currentPage >= (self.count - 2)) {
        current = (int)(currentPage - (self.count - 2));
        self.pageControl.currentPage = currentPage - (self.count - 2);
//        self.detailLabel.text = self.allDetails[currentPage - (self.count - 2)];
    }else{
        current = currentPage;
        self.pageControl.currentPage = currentPage;
//        self.detailLabel.text = self.allDetails[currentPage - 2];
    }
    
//    NSLog(@"current============%d",current);

    
    if (current > 0) {
        self.pageControl.currentPage = current - 1;
        self.detailLabel.text = self.allDetails[current - 1];
    }else{
        self.pageControl.currentPage = self.count - 2;
        self.detailLabel.text = self.allDetails[self.count - 3];
    }
    
    [self.pageControl updateCurrentPageDisplay];
    
    for (int i = 0; i < self.pageControl.numberOfPages; i++) {
        [(UIImageView *)self.pageControl.subviews[i] setSize:CGSizeMake(8, 8)];
    }
}

#pragma mark - scroll delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // disable v direction scroll
    if (scrollView.contentOffset.y > 0) {
        [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, 0)];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    // when user scrolls manually, stop timer and start timer again to avoid next scroll immediatelly
    if (self.autoScrollTimer && self.autoScrollTimer.isValid) {
        [self.autoScrollTimer invalidate];
    }
    self.autoScrollTimer = [NSTimer scheduledTimerWithTimeInterval:self.scrollInterval target:self selector:@selector(handleScrollTimer:) userInfo:nil repeats:YES];
    
    // update UIPageControl
    CGRect visiableRect = CGRectMake(scrollView.contentOffset.x, scrollView.contentOffset.y, scrollView.bounds.size.width, scrollView.bounds.size.height);
    NSInteger currentIndex = 0;
    for (UIImageView *imageView in scrollView.subviews) {
        if ([imageView isKindOfClass:[UIImageView class]]) {
            if (CGRectContainsRect(visiableRect, imageView.frame)) {
                currentIndex = imageView.tag - kStartTag;
                break;
            }
        }
    }
    
    CGFloat pagewidth = self.scrollView.frame.size.width;
    int currentPage = floor((self.scrollView.contentOffset.x - pagewidth/ (self.count+2)) / pagewidth) + 1;
    //    int currentPage_ = (int)self.scrollView.contentOffset.x/320; // 和上面两行效果一样
//    NSLog(@"currentPage_==%d",currentPage);
    
    //    图片位置
    int current;
    
    if (currentPage ==0)
    {
        [self.scrollView scrollRectToVisible:CGRectMake(320 * (self.count - 2),0,320,460) animated:NO]; // 序号0 最后1页
    }
    else if (currentPage == (self.count - 2))
    {
        [self.scrollView scrollRectToVisible:CGRectMake(0,0,320,460) animated:NO]; // 最后+1,循环第1页
    }else if (currentPage == self.count - 1){
        [self.scrollView scrollRectToVisible:CGRectMake(0,0,320,460) animated:NO]; // 序号0 最后1页
    }
    
    if (currentPage == self.count - 1) {
        current = currentPage;
    }else if ((self.count - 1 > currentPage >= (self.count - 2)) || (currentPage > self.count - 1 )) {
        current = currentPage - (self.count - 2);
        self.pageControl.currentPage = currentPage - (self.count - 2);
    }else{
        current = currentPage;
        self.pageControl.currentPage = currentPage;
    }
    
    if ((current > 0 && current < self.count - 1) || (current > self.count - 1)) {
        self.pageControl.currentPage = current - 1;
        self.detailLabel.text = self.allDetails[current - 1];
    }else if (current == self.count - 1) {
        self.pageControl.currentPage = 0;
        self.detailLabel.text = self.allDetails[0];
    }else{
        self.pageControl.currentPage = self.count - 2;
        self.detailLabel.text = self.allDetails[self.count - 3];
    }
    
    for (int i = 0; i < self.pageControl.numberOfPages; i++) {
        [(UIImageView *)self.pageControl.subviews[i] setSize:CGSizeMake(8, 8)];
    }

}

#pragma mark -
- (void)setPageControlPosition:(ICPageControlPosition)pageControlPosition
{
    NSString *vFormat = nil;
    NSString *hFormat = nil;
    
    switch (pageControlPosition) {
        case ICPageControlPosition_TopLeft: {
            vFormat = @"V:|-0-[pageControl]";
            hFormat = @"H:|-[pageControl]";
            break;
        }
            
        case ICPageControlPosition_TopCenter: {
            vFormat = @"V:|-0-[pageControl]";
            hFormat = @"H:|[pageControl]|";
            break;
        }
            
        case ICPageControlPosition_TopRight: {
            vFormat = @"V:|-0-[pageControl]";
            hFormat = @"H:[pageControl]-|";
            break;
        }
            
        case ICPageControlPosition_BottomLeft: {
            vFormat = @"V:[pageControl]-0-|";
            hFormat = @"H:|-[pageControl]";
            break;
        }
            
        case ICPageControlPosition_BottomCenter: {
            vFormat = @"V:[pageControl]-(-5)-|";
            hFormat = @"H:|-100-[pageControl]-100-|";
            break;
        }
            
        case ICPageControlPosition_BottomRight: {
            vFormat = @"V:[pageControl]-0-|";
            hFormat = @"H:[pageControl]-|";
            break;
        }
            
        default:
            break;
    }
    
    [self removeConstraints:self.pageControlConstraints];
    
    NSArray *pageControlVConstraints = [NSLayoutConstraint constraintsWithVisualFormat:vFormat
                                                                               options:kNilOptions
                                                                               metrics:nil
                                                                                 views:@{@"pageControl": self.pageControl}];
    
    NSArray *pageControlHConstraints = [NSLayoutConstraint constraintsWithVisualFormat:hFormat
                                                                               options:kNilOptions
                                                                               metrics:nil
                                                                                 views:@{@"pageControl": self.pageControl}];
    
    [self.pageControlConstraints removeAllObjects];
    [self.pageControlConstraints addObjectsFromArray:pageControlVConstraints];
    [self.pageControlConstraints addObjectsFromArray:pageControlHConstraints];
    [self addConstraints:self.pageControlConstraints];
    
    
}

- (void)setHidePageControl:(BOOL)hidePageControl
{
    self.pageControl.hidden = hidePageControl;
    
    [self.scrollView scrollRectToVisible:CGRectMake(320,0,320,self.scrollView.frame.size.height) animated:NO]; // 默认从序号1位置放第1页,序号0位置位置放第4页
}

-(void)openThePageControllAndIsOpenImageDetails:(BOOL)openImageDetails andTheDetails:(NSArray *)details andState:(int)state
{
    //    self.pageControl.frame = CGRectMake(ScreenWidth - 60, ScreenHeight - 30, 60, 30);
    
    if (self.detailView) {
        [self.detailView removeFromSuperview];
    }
    self.detailView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 38, self.frame.size.width, 38)];
    self.detailView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.detailView];
    
    if (state == 3) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,  self.frame.size.width, 38)];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.image = [UIImage imageNamed:@"videohome_gallery_bg.png"];
        [self.detailView addSubview:imageView];
    }
    
    if (openImageDetails) {
        self.detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.detailView.frame.size.width - 100, self.detailView.frame.size.height)];
        self.detailLabel.backgroundColor = [UIColor clearColor];
        self.detailLabel.font = [UIFont systemFontOfSize:16.0];
        self.detailLabel.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        self.detailLabel.text = details[0];
        self.allDetails = details;
        [self.detailView  addSubview:self.detailLabel];
    } else {
        self.detailView.backgroundColor = [UIColor clearColor];
    }
    if (state == 1) {
        self.pageControl.frame  = CGRectMake(0, 0, 160, self.detailView.frame.size.height);
    }else if (state == 2){
        self.pageControl.frame = CGRectMake(140, self.frame.size.height - 26, 40, 30);
    }else if (state == 3){
        [self bringSubviewToFront:self.pageControl];
        self.pageControl.frame = CGRectMake(self.detailView.frame.size.width - 210, self.frame.size.height - 35, 320, 38);
        
    }
}

@end

