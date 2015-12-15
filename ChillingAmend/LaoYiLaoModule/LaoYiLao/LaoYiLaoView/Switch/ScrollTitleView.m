//
//  ScrollTitleView.m
//  LaoYiLao
//
//  Created by wzh on 15/11/20.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import "ScrollTitleView.h"
#define AnimateDuration 0.3

@implementation ScrollTitleView{
    int _currentIndex;
    UIView *_backView;
//    NSArray *_itemsArray;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
    
        _defaultIndex = 0;
    }
    return  self;
}

- (void)createItem:(NSArray *)itemsArray{
    _itemsArray = itemsArray;
    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width/itemsArray.count, self.frame.size.height)];
    _backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_backView];
    for (int i = 0;  i < itemsArray.count; i++ ) {
        
        
        UIButton *itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        itemBtn.frame = CGRectMake(i * self.frame.size.width/itemsArray.count, 0, self.frame.size.width/itemsArray.count, self.frame.size.height);
        itemBtn.titleLabel.font = UIFont28;
        [itemBtn setTitle:itemsArray[i] forState:UIControlStateNormal];
        [itemBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
//        [itemBtn addTarget:self action:@selector(buttonDragInside:event:) forControlEvents:UIControlEventTouchDragInside];
//        [itemBtn addTarget:self action:@selector(buttonDragEnter:) forControlEvents:UIControlEventTouchDragEnter];

        itemBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        itemBtn.tag = i;
        if(itemBtn.tag == _defaultIndex){
            itemBtn.selected = YES;
        }
        [itemBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [itemBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];

        [itemBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    
        [self addSubview:itemBtn];
        
 
        if(i != 0){
            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width/itemsArray.count  * i , 0, 1, self.frame.size.height)];
            lineView.backgroundColor = [UIColor whiteColor];
            [self addSubview:lineView];
        }
    }
}

- (void)buttonClicked:(UIButton *)button{
    [self rollingBackViewWithIndex:(int)button.tag];
}

//- (void)buttonDragInside:(UIButton *)button event:(UIEvent *)event{
//    UITouch *touch = [[event allTouches] anyObject];
//    //获取当前点
//    CGPoint point = [touch locationInView:self];
//    //获取前一点
//    CGPoint prePoint = [touch previousLocationInView:self];
////    ZHLog(@"%2")
//    ZHLog(@"buttonDragInside");
//}
//- (void)buttonDragEnter:(UIButton *)button{
//    ZHLog(@"buttonDragEnter");
//
//}
- (void)rollingBackViewWithIndex:(int)selectIndex{
    [self selectIndex:selectIndex];

    [UIView animateWithDuration:AnimateDuration animations:^{
        _backView.frame = CGRectMake(self.frame.size.width / _itemsArray.count * selectIndex, _backView.frame.origin.y, _backView.frame.size.width, _backView.frame.size.height);
        self.userInteractionEnabled = NO;

    } completion:^(BOOL finished) {
        self.selectIndexWithBlock(selectIndex);
        self.userInteractionEnabled = YES;

    }];
}

- (void)selectIndex:(int)selectIndex{
    for (UIView *subView in self.subviews) {
        if([subView isKindOfClass:[UIButton class]]){
            ((UIButton *)subView).selected = NO;
            if(selectIndex == ((UIButton *)subView).tag){
                ((UIButton *)subView).selected = YES;
            }
        }
    }
}

- (void)setDefaultIndex:(int)defaultIndex{
    _defaultIndex = defaultIndex;    
}
@end
