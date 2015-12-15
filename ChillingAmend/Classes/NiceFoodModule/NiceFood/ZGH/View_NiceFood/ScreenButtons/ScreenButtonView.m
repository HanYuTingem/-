//
//  ScreenButtonView.m
//  PRJ_NiceFoodModule
//
//  Created by 刘雅楠 on 15/6/17.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "ScreenButtonView.h"
#import "Parameter.h"
#import "AreaClassModel.h"
#import "IndustryClassModel.h"



@implementation ScreenButtonView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _areaIndex = 0;
        _areaSecondIndex = 0;
        _classIndex = 1;
        _classSecondIndex = 0;
        _typeIndex = 0;


        self.backgroundColor = [UIColor whiteColor];
        
        //        区域
        _area = [self setScreenItem:@"附近" image:@"fujin" index:0];
        
        //        行业
        _profession = [self setScreenItem:@"美食" image:@"meishi" index:1];

        //        筛选
        _screen = [self setScreenItem:@"筛选" image:@"shaixuan" index:2];

        
//        添加按钮之间的分割线
        [self addCuttinglineWithIndex:1];
        [self addCuttinglineWithIndex:2];
        
        
//        筛选栏上下分割线
        [self addTopAndBottomCuttinglineWithIndex:@"top"];
        [self addTopAndBottomCuttinglineWithIndex:@"bottom"];
        
        

        
        
    }
    return self;
}


//筛选栏上下分割线
- (void)addTopAndBottomCuttinglineWithIndex:(NSString *)index{
    
    UIView * view = [[UIView alloc] init];

    if ([index isEqualToString:@"top"]) {
        view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 1);
    } else if ([index isEqualToString:@"bottom"]){
        view.frame = CGRectMake(0, TopMenuH, SCREEN_WIDTH, 1);
    }
    
    view.backgroundColor = RGBColor(207, 207, 207);
    [self addSubview:view];

}

//添加按钮间的分割线
- (void)addCuttinglineWithIndex:(int)index{
    
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(TopMenuItemW * index, 10 / 2, 2, TopMenuH - 10)];
    
    view.image = [UIImage imageNamed:@"order_list_img_Classification_line"];
    
    [self addSubview:view];
    
}

#pragma mark --工厂方法设置item属性
- (ScreenButton *)setScreenItem:(NSString *)title image:(NSString *)image index:(int)index{
    
    ScreenButton *item = [[ScreenButton alloc] initWithFrame:CGRectMake(TopMenuItemW * index, 0, 0, 0)];
    item.title = title;
    item.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;//文字缩进方式 尾部缩进
    item.image = image;
    item.imageSelected = [NSString stringWithFormat:@"%@Selected", image];
    item.tag = index + 101;
    
    [item   addTarget:self
               action:@selector(buttonClick:)
     forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:item];
    
    return item;
}

- (void)clickScreenListView{

    [self buttonClick:_tempBtn];
    
    NSLog(@"点击事件");
}




#pragma mark --按钮点击事件
- (void)buttonClick:(ScreenButton *)btn{
    
    [_backView removeFromSuperview];
    [_back removeFromSuperview];

    
    
    if (btn.selected == YES) {
        
        btn.selected = NO;
        
//        按钮小箭头旋转动画
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
            btn.arrow.transform = CGAffineTransformMakeRotation(0);
        } completion:^(BOOL finished) {
            
        }];
        
        
    } else {
        
//        按钮小箭头旋转动画
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
            btn.arrow.transform = CGAffineTransformMakeRotation(M_PI);
        } completion:^(BOOL finished) {
            
        }];
        
//        按钮小箭头旋转动画
        if (_tempBtn != btn) {
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                _tempBtn.arrow.transform = CGAffineTransformMakeRotation(0);
            } completion:^(BOOL finished) {
                
            }];
        }
        
//        按钮点击动画
        if (btn.tag == 101) {
            
//            NSLog(@"%@ %@", _areaArray, _areaSecondArray);
            
            _backView = [[ScreenListView alloc] initWithFirstDatas:_areaArray secondDatas:_areaSecondArray firstIndex:_areaIndex andBlock:^(NSInteger firstIndex, NSInteger secondIdex) {
                _areaIndex = firstIndex;
                _areaSecondIndex = secondIdex;
                btn.title = _areaSecondArray[firstIndex][secondIdex];
                [self buttonClick:btn];
                [self NotificationWithIndex];
                
            }];
            [self.superview addSubview:_backView];
            
        } else if (btn.tag == 102) {
            _backView = [[ScreenListView alloc] initWithFirstDatas:_classArray secondDatas:_classSecondArray firstIndex:_classIndex andBlock:^(NSInteger firstIndex, NSInteger secondIdex) {
                _classIndex = firstIndex;
                _classSecondIndex = secondIdex;
                if (_classIndex > 0) {
                    btn.title = _classSecondArray[firstIndex][secondIdex];
                } else {
                    btn.title = _classArray[firstIndex];
                }
                [self buttonClick:btn];
                [self NotificationWithIndex];
            }];
            [self.superview addSubview:_backView];
            
        } else if (btn.tag == 103) {
            _backView = [[ScreenListView alloc] initWithFirstDatas:_typeArray secondDatas:nil firstIndex:_typeIndex andBlock:^(NSInteger firstIndex, NSInteger secondIdex) {
                _typeIndex = firstIndex;
                btn.title = _typeArray[firstIndex];
                [self buttonClick:btn];
                [self NotificationWithIndex];
                
            }];
            [self.superview addSubview:_backView];
        }
        
        
        _back = [[UIView alloc] initWithFrame:CGRectMake(0, (SCREEN_HEIGHT - NavigationH-TopMenuH) * TableHightScale, SCREEN_WIDTH, (SCREEN_HEIGHT - NavigationH-TopMenuH) * (1 - TableHightScale))];
//        _back.backgroundColor = [UIColor redColor];
        [self.superview addSubview:_back];
        _back.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget: self action:@selector(clickScreenListView)];
        [_back addGestureRecognizer:tapGesture];

        
        _tempBtn.selected = NO;
        btn.selected = YES;
        _tempBtn = btn;
        
        
    }
    [self.superview bringSubviewToFront:self];
}


//发送通知的方法
- (void)NotificationWithIndex{
        
    if (_areaIndex == 0) {
        
        BMKCloudNearbySearchInfo *near = [Parameter getNearShopListWithAreaDatas:_areaClassModel classDatas:_industryClassModel areaIndex:_areaIndex areaSecondIndex:_areaSecondIndex classIndex:_classIndex classSecondIndex:_classSecondIndex typeIndex:_typeIndex pageIndex:0];
        
        NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:near, @"near", nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"near" object:nil userInfo:dic];
        
    } else {
        
        BMKCloudLocalSearchInfo *location =[Parameter getLocationShopListWithAreaDatas:_areaClassModel classDatas:_industryClassModel areaIndex:_areaIndex areaSecondIndex:_areaSecondIndex classIndex:_classIndex classSecondIndex:_classSecondIndex typeIndex:_typeIndex pageIndex:0];
        
        NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:location, @"location", nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"location" object:nil userInfo:dic];
    }
    
    
    
}



// 范围锁死
- (void)setFrame:(CGRect)frame{
    frame.origin.x = 0;
    frame.origin.y = 0;
    frame.size = CGSizeMake(SCREEN_WIDTH, TopMenuH);
    [super setFrame:frame];
}



@end
