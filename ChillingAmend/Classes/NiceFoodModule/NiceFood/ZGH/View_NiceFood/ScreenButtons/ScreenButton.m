//
//  ScreenButton.m
//  PRJ_NiceFoodModule
//
//  Created by 刘雅楠 on 15/6/18.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "ScreenButton.h"

#define ImageScale 0.4
#define ArrowH 5

@interface ScreenButton()



@end

@implementation ScreenButton

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        
        //    设置箭头
        _arrow = [[UIImageView alloc] initWithFrame:CGRectMake(TopMenuItemW * 2 * ImageScale, (TopMenuH - ArrowH) / 2, ArrowH * 2, ArrowH)];
        [_arrow setImage:[UIImage imageNamed:@"programmecard_title_ico_down"]];
        [self addSubview:_arrow];
        
//        设置监听事件
//        [self addObserver:self forKeyPath:@"selected" options:0 context:nil];
        
    }
    return self;
}



- (void)dealloc{
//    移除监听
//    [self removeObserver:self forKeyPath:@"selected"];
}

#pragma mark --监听触发事件   监听按钮选中状态  触发动画
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(ScreenButton *)object change:(NSDictionary *)change context:(void *)context{
    
    if (self.selected == YES) { //选中时触发动画
        
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
        _arrow.transform = CGAffineTransformMakeRotation(M_PI);
        } completion:^(BOOL finished) {
            
        }];
    } else { //接触选中时触发动画
        
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
            _arrow.transform = CGAffineTransformMakeRotation(0);
        } completion:^(BOOL finished) {
            
        }];
    }
}

//设置按钮文字
- (void)setTitle:(NSString *)title{

    _title = title;
    
    [self setTitle:title forState:UIControlStateNormal];
    
}

//设置按钮图片
- (void)setImage:(NSString *)image{
    
    _image = image;
    
    [self setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    self.imageView.contentMode = UIViewContentModeCenter;
}

- (void)setImageSelected:(NSString *)imageSelected{
    
    _imageSelected = imageSelected;
    
    [self setImage:[UIImage imageNamed:imageSelected] forState:UIControlStateSelected];

}


//设置按钮中title比例
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    CGFloat X = contentRect.size.width * ImageScale;
    CGFloat W = contentRect.size.width * ImageScale;
    CGFloat H = contentRect.size.height;
    
    return CGRectMake(X, 0, W, H);
}

//设置按钮中image比例
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    CGFloat W = contentRect.size.width * ImageScale;
    CGFloat H = contentRect.size.height;
    
    return CGRectMake(0, 0, W, H);
}

//取消按钮高亮
- (void)setHighlighted:(BOOL)highlighted{}


- (void)setFrame:(CGRect)frame{
    
    frame.size = CGSizeMake(TopMenuItemW, TopMenuH);
    [super setFrame:frame];
}


@end
