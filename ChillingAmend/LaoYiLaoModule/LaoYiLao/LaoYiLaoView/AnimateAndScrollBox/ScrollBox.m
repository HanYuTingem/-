//
//  ScrollBox.m
//  LaoYiLao
//
//  Created by wzh on 15/11/2.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import "ScrollBox.h"
#import "ScrollBoxItemView.h"



//标题View的Frame
#define TitleViewX 0
#define TitleViewY 0
#define TitleViewW kkViewWidth
#define TitleViewH 35

#define ScrollBoxItemH 57


#define TitleContentLabX 0 //无所谓
#define TitleContentLabY 0 // 无所为
#define TitleContentLabW 180
#define TitleContentLabH 30

#define TitleLeftViewOrRightViewMid 4
#define TitleLeftViewX 30

#define ItsmsCount 18 * 2
@interface ScrollBox ()<UIScrollViewDelegate>{
    int _currentItemIndex;    //记录当前是第几页
    NSMutableArray * _tmpItemArray;
    
}

@end

@implementation ScrollBox

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        imageView.image = [UIImage imageNamed:@"lao_curtain"];
        [self addSubview:imageView];
        
        self.backgroundColor = [UIColor blueColor];
        _tmpItemArray = [NSMutableArray array];
        _titleView = [[UIView alloc]initWithFrame:CGRectMake(TitleViewX, TitleViewY, TitleViewW, TitleViewH)];
        _titleView.backgroundColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1.00f];
        _titleView.backgroundColor = [UIColor clearColor];
        [self addSubview:_titleView];
        
        UILabel *contentlab = [[UILabel alloc]initWithFrame:CGRectMake(TitleContentLabX, TitleContentLabY, TitleContentLabW, TitleContentLabH)];
//        contentlab.backgroundColor = [UIColor brownColor];
        contentlab.center = CGPointMake(_titleView.center.x, _titleView.center.y);
        contentlab.textAlignment = NSTextAlignmentCenter;
        contentlab.text = [NSString stringWithFormat:@"看看谁捞到了明星的饺子"];
        contentlab.textColor = [UIColor whiteColor];
        contentlab.font = UIFont32;
        [_titleView addSubview:contentlab];
        
//        UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(TitleLeftViewX, 0, (kkViewWidth - TitleContentLabW) / 2 - TitleLeftViewOrRightViewMid - TitleLeftViewX, 0.5)];
//        leftView.center = CGPointMake(leftView.center.x, _titleView.center.y);
//        leftView.backgroundColor = [UIColor colorWithRed:0.63f green:0.63f blue:0.63f alpha:1.00f];
//        [_titleView addSubview:leftView];
//        
//        
//        UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(contentlab.frame) + TitleLeftViewOrRightViewMid , 0, (kkViewWidth - TitleContentLabW) / 2 - TitleLeftViewOrRightViewMid - TitleLeftViewX, 0.5)];
//        rightView.center = CGPointMake(rightView.center.x, _titleView.center.y);
//        rightView.backgroundColor = [UIColor colorWithRed:0.63f green:0.63f blue:0.63f alpha:1.00f];
//        [_titleView addSubview:rightView];
        
        
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleView.frame)-1, kkViewWidth, ScrollBoxItemH * 3)];
        _scrollView.contentSize = CGSizeMake(kkViewWidth, ScrollBoxItemH * 5);
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.userInteractionEnabled = NO;
        _scrollView.contentOffset = CGPointMake(0, ScrollBoxItemH * 2);
        _scrollView.backgroundColor = [UIColor clearColor];
        [self addSubview:_scrollView];
        
        _moveTimer = [NSTimer scheduledTimerWithTimeInterval:TimeMid target:self selector:@selector(animalScrollViewitem) userInfo:nil repeats:YES];

    }
    return self;
}

- (void)addItemWithArray:(NSMutableArray *)itemArray{
    
    if(itemArray.count > ItsmsCount){
        NSRange range = NSMakeRange(0, ItsmsCount / 2);
        [itemArray removeObjectsInRange:range];
    }
    
    NSMutableArray *tmpArray = [NSMutableArray array];
    if(itemArray.count < 6){
        for (int  i = 0; i < 6 - itemArray.count;  i ++) {
            [tmpArray addObject:[itemArray lastObject]];
        }
    }
    [itemArray addObjectsFromArray:tmpArray];
//    ZHLog(@"itemArray.count ==%d",(int)itemArray.count);
    for (int i = 0; i <itemArray.count; i ++) {
        ScrollBoxItemView *scrollBoxItemView = [[ScrollBoxItemView alloc]init];
//        scrollBoxItemView.numberLab.text = [NSString stringWithFormat:@"%d",i];
        scrollBoxItemView.model = itemArray[i];
        
        [_tmpItemArray addObject:scrollBoxItemView];
    }
    
    [self loadScrollBoxWithItemArray:_tmpItemArray andCurrentItemIndex:_currentItemIndex];
    
//    [self performSelector:@selector(animalScrollViewitem) withObject:nil afterDelay:2];
}


- (void)loadScrollBoxWithItemArray:(NSMutableArray *)itemArray andCurrentItemIndex:(int)currentItemIndex{
    
        // 清空当前已有的imageVIew
    for(UIView *view in _scrollView.subviews)
    {
        if([view isKindOfClass:[UIView class]])
            [view removeFromSuperview];
    }
    UIView *leftView = [[UIView alloc]init];// 左页
    UIView *midView = [[UIView alloc]init];//中间页
    UIView *rightView = [[UIView alloc]init];//右页
    UIView *nextView = [[UIView alloc] init];//下一页
    UIView *preView = [[UIView alloc] init];//上一页
    
    
//    
//    //上一页
    int index;
    if(currentItemIndex - 2 < 0){
        if(currentItemIndex - 1 < 0){
            index = (int)itemArray.count - 2;
        }else{
            index = (int)itemArray.count - 1;
        }
    }else{
        index = currentItemIndex - 2;
    }
    
    preView = itemArray[index];
    preView.frame = CGRectMake(0, 0, kkViewWidth, ScrollBoxItemH);
    [_scrollView addSubview:preView];
    
    //左页
    leftView = itemArray[currentItemIndex - 1 < 0 ? itemArray.count - 1 : currentItemIndex - 1];
    leftView.frame = CGRectMake(0, ScrollBoxItemH, kkViewWidth, ScrollBoxItemH);
    [_scrollView addSubview:leftView];
    
    //中间页
    midView = itemArray[currentItemIndex];
    midView.frame = CGRectMake(0, ScrollBoxItemH * 2, kkViewWidth, ScrollBoxItemH);
    [_scrollView addSubview:midView];
    
    
    //右页
    rightView = itemArray[currentItemIndex + 1 < itemArray.count ? currentItemIndex + 1 : 0];
    rightView.frame = CGRectMake(0, ScrollBoxItemH * 3, kkViewWidth, ScrollBoxItemH);
    [_scrollView addSubview:rightView];
    
    
    //下一页
    nextView = itemArray[currentItemIndex + 2 < itemArray.count ? currentItemIndex + 2 : currentItemIndex + 2 == itemArray.count ? 0 : 1];
    nextView.frame = CGRectMake(0, ScrollBoxItemH * 4, kkViewWidth, ScrollBoxItemH);
    [_scrollView addSubview:nextView];
    

    
}

// 当减速结束时调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if(scrollView == _scrollView){//必须判断一下否则会与tableView的滚动视图混淆
        int index = scrollView.contentOffset.y / ScrollBoxItemH;
        //向上
        if(index == 3){
            _currentItemIndex = _currentItemIndex + 1 == _tmpItemArray.count ? 0 : _currentItemIndex + 1;
            [scrollView setContentOffset:CGPointMake(0, ScrollBoxItemH * 2)];

        }
        [self loadScrollBoxWithItemArray:_tmpItemArray andCurrentItemIndex:_currentItemIndex];
    }
}
- (void)animalScrollViewitem{

    if(_tmpItemArray && _tmpItemArray.count > 5){
        [UIView animateWithDuration:1 animations:^{
            _scrollView.contentOffset = CGPointMake(0, 3 * ScrollBoxItemH);//调用向上
        }];
        [self scrollViewDidEndDecelerating:_scrollView];
    }
//    ZHLog(@"抽奖信息正在滚动");
    
    //    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(animalMoveImage) object:nil];
    //和NSTimer效果一样
//    [self performSelector:@selector(animalMoveImage) withObject:nil afterDelay:2];
}


- (void)startTimer{
    [_moveTimer setFireDate:[NSDate distantPast]];//开启定时器

}

- (void)stopTimer{
    [_moveTimer setFireDate:[NSDate distantFuture]];//关闭定时器
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
