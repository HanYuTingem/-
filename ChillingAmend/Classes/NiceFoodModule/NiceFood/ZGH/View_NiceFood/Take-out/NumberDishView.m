//
//  NumberDishView.m
//  HCheap
//
//  Created by Apple on 14/12/11.
//  Copyright (c) 2014年 qiaohongchao. All rights reserved.
//

#import "NumberDishView.h"

@implementation NumberDishView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)reloadCopiesNumber
{
    [self removeAddBtn];
    if (_model.copies > 0) {
        [self removeSelectBtn];
        [self createAddBtn];
    }else{
        [self createSelectBtn];
//        [self removeAddBtn];
    }
}

// 创建添加按钮
- (void)createSelectBtn
{
    if (_selectDishBtn == nil) {
        _selectDishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectDishBtn.frame = CGRectMake(self.frame.size.width - 40, 0, 40, 40);
        _selectDishBtn.backgroundColor = [UIColor clearColor];
        [_selectDishBtn setImage:[UIImage imageNamed:@"wm_btn_tianjia.png"] forState:UIControlStateNormal];
        [_selectDishBtn addTarget:self action:@selector(selectDishAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_selectDishBtn];
    }
}

//  移除选中按钮
- (void)removeSelectBtn
{
    if (_selectDishBtn != nil) {
        [_selectDishBtn removeFromSuperview];
        _selectDishBtn = nil;
    }
}

//  选中按钮事件
- (void)selectDishAction:(UIButton *)sender
{
    _model.copies++;
    [self createAddBtn];
    [self removeSelectBtn];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"setup" object:nil userInfo:(NSDictionary *)_model];
    NSLog(@"%d", _model.copies);
}

// 创建数量修改按钮
- (void)createAddBtn
{
    if (_numberImageBgView == nil) {
        _numberImageBgView = [[UIImageView alloc] initWithFrame:CGRectMake(44, 0, 40, 40)];
        UIImage *images = [UIImage imageNamed:@"dd_btn_bg.png"];
        _numberImageBgView.image = images;
        [self addSubview:_numberImageBgView];
    }
    
    if (_leftLessBtn == nil) {
        _leftLessBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftLessBtn.frame =CGRectMake(8, 0, 40, 40);
        [_leftLessBtn setImage:[UIImage imageNamed:@"dd_btn_jia.png"] forState:UIControlStateNormal];
        [_leftLessBtn setImage:[UIImage imageNamed:@"dd_btn_jia_anxia.png"] forState:UIControlStateHighlighted];
        [_leftLessBtn addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_leftLessBtn];
    }
    
    if (_rightAddBtn == nil) {
        _rightAddBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightAddBtn.frame = CGRectMake(80, 0, 40, 40);
        [_rightAddBtn setImage:[UIImage imageNamed:@"dd_btn_jian.png"] forState:UIControlStateNormal];
        [_rightAddBtn setImage:[UIImage imageNamed:@"dd_btn_jian_anxia.png"] forState:UIControlStateHighlighted];
        [_rightAddBtn addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_rightAddBtn];
    }
    
    if (_numberLabel == nil) {
        _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(44, 0, 40, 40)];
        _numberLabel.backgroundColor = [UIColor clearColor];
        _numberLabel.text = [NSString stringWithFormat:@"%d",_model.copies];
        _numberLabel.textColor = [UIColor colorWithRed:244/255.0 green:75/255.0 blue:102/255.0 alpha:1];
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_numberLabel];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _numberLabel.text = [NSString stringWithFormat:@"%d",_model.copies];
}

// 移除数量修改按钮
- (void)removeAddBtn
{
    if (_rightAddBtn != nil) {
        [_rightAddBtn removeFromSuperview];
        _rightAddBtn = nil;
    }
    
    if (_leftLessBtn != nil) {
        [_leftLessBtn removeFromSuperview];
        _leftLessBtn = nil;
    }
    
    if (_numberImageBgView != nil) {
        [_numberImageBgView removeFromSuperview];
        _numberImageBgView = nil;
    }
    
    if (_numberLabel != nil) {
        [_numberLabel removeFromSuperview];
        _numberLabel = nil;
    }
}

// 加减事件
- (void)changeAction:(UIButton *)sender
{
    if (sender == _rightAddBtn) {
        if (_model.copies >= 99) {
            
        }else{
            _model.copies++;
            _numberLabel.text =[NSString stringWithFormat:@"%d",_model.copies];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"add" object:nil userInfo:(NSDictionary *)_model];
            
        }
    }else if (sender == _leftLessBtn){
        if (_model.copies <= 1) {
            _model.copies--;
            [self removeAddBtn];
            [self createSelectBtn];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"remove" object:nil userInfo:(NSDictionary *)_model];
            NSLog(@"移除");
        }else{
            _model.copies--;
            _numberLabel.text = [NSString stringWithFormat:@"%d",_model.copies];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"sub" object:nil userInfo:(NSDictionary *)_model];
            
        }
    }

    NSLog(@"%d", _model.copies);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
