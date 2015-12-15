//
//  CJAttributeNumAddView.m
//  MarketManage
//
//  Created by 赵春景 on 15-7-24.
//  Copyright (c) 2015年 Rice. All rights reserved.

//  加减号方格计数器

#import "CJAttributeNumAddView.h"
#import "CJAttributeHeaderFile.h"
#import "CJAttributeModle.h"

@interface CJAttributeNumAddView ()<UITextFieldDelegate>

{
    /** 属性界面 全局的frame */
    CGRect _frame;
    /** 头标题文字 */
    UILabel *_label;
    /** 上一个View的最大y 值 */
    CGFloat _height;
    /** 加减号中间的数字label */
//    UILabel *_numLabel;
}

@end

@implementation CJAttributeNumAddView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.blockViewClickAdd();
}

- (instancetype)initWithFrame:(CGRect)frame WithAttributeGoodsNums:(NSString *)attributeGoodsNums
{
    if (self = [super initWithFrame:frame]) {
        
        self.getAttributeGoodsNums = attributeGoodsNums;
        self.backgroundColor = [UIColor whiteColor];
        /**
         * 添加头标题的ViewLabel
         */
        [self makeViewLabel];
        /**
         * 添加加减号方格计数器
         */
        [self makeNumBtnView];
        
    }
    return self;
}

/**
 * 添加头标题的ViewLabel
 */
- (void)makeViewLabel
{
    CGFloat lableX = LeftGap;
    CGFloat lableY = 15 *SP_WIDTH;
    CGFloat lableW = 40 *SP_WIDTH;
    CGFloat lableH = 20;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(lableX, lableY, lableW, lableH)];
    
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:15];
    [self addSubview:label];
    label.text = @"数量";
    _label = label;
    _height = CGRectGetMaxY(_label.frame) + 14 *SP_WIDTH;
}


/**
 * 添加加减号方格计数器
 */
- (void)makeNumBtnView
{
    
    /** 三个方格 计数的图片 */
    UIImage *image = [UIImage imageNamed:@"mall_order_number_btn"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(LeftGap, _height, image.size.width, image.size.height)];
    imageView.image = image;
    imageView.userInteractionEnabled = YES;
    [self addSubview:imageView];
    
    /**
     * 添加➖按钮
     */
    CGFloat btnW = image.size.width / 3;
    CGFloat btnH = image.size.height;
    
    UIButton *minusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    minusBtn.frame = CGRectMake(0, 0, btnW, btnH);
    minusBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [minusBtn setTitle:@"-" forState:UIControlStateNormal];
    [minusBtn setTitle:@"-" forState:UIControlStateHighlighted];
    [minusBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [minusBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [minusBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    minusBtn.tag = 100;
    [imageView addSubview:minusBtn];
    
    /**
     * 添加中间数字显示
     */
//    UILabel *numLable = [[UILabel alloc] initWithFrame:CGRectMake(btnW, 0, btnW, btnH)];
////    numLable.text = @"1";
//    numLable.text = self.getAttributeGoodsNums;
//    numLable.textAlignment = NSTextAlignmentCenter;
//    numLable.textColor = [UIColor blackColor];
//    numLable.font = [UIFont systemFontOfSize:13];
//    [imageView addSubview:numLable];
//    _numLabel = numLable;
    
    UITextField *numTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(btnW, 0, btnW, btnH)];
    numTextFiled.text = self.getAttributeGoodsNums;
    numTextFiled.textAlignment = NSTextAlignmentCenter;
    numTextFiled.textColor = [UIColor blackColor];
    numTextFiled.font = [UIFont systemFontOfSize:13];
    [imageView addSubview:numTextFiled];
    numTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    _numLabel = numTextFiled;
    
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(btnW * 2, 0, btnW, btnH);
    addBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [addBtn setTitle:@"+" forState:UIControlStateNormal];
    [addBtn setTitle:@"+" forState:UIControlStateHighlighted];
    [addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [addBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    addBtn.tag = 101;
    [imageView addSubview:addBtn];
    
    CGRect frame = self.frame;
    frame.size.height = CGRectGetMaxY(imageView.frame) + LeftGap;
    self.frame = frame;
    
    
}
/**
 * 加减按钮的点击事件
 */
- (void)btnClick:(UIButton *)sender
{
        UIButton *minusBtn = (UIButton *)[self viewWithTag:100];
        int num = [_numLabel.text intValue];
    
    if (sender.tag == 100) {//减号的计算
                if (num == 1) {
                    minusBtn.enabled = NO;
                } else {
                    _numLabel.text = [NSString stringWithFormat:@"%d",--num];
                }
        
//        if (self.count>1) {
//            self.count--;
//            [self updateLabel];
//        }
        
        
    } else if(sender.tag == 101) {//加法的计算
        minusBtn.enabled = YES;
        num++;
        
        if (num > self.modle.nums.intValue) {
            self.blockPrompt();
            num--;
        }
        _numLabel.text = [NSString stringWithFormat:@"%d",num];
        
//        if (self.count<99) {
//            if(self.goods.restriction > 0 && self.goods.available >0 &&self.count>=self.goods.available){
//                [self.delegate goodsNumChange:10000 + self.goods.restriction];
//
//            }else if(self.goods.nums <= self.count){
//
//                [self.delegate goodsNumChange:1000];
//
//            }else{
//                self.count++;
//                [self updateLabel];
//            }
//            
//        }
        
    }
    
    self.blockNumAddViewText(_numLabel.text);
    
}

-(void)updateLabel
{
    
    if ([self.isSeckilling integerValue] > 0) {//秒杀 购买数量固定为1
        if (self.delegate && [self.delegate respondsToSelector:@selector(goodsNumChange:)]) {
            [self.delegate goodsNumChange:1];
        }
        self.numLabel.text=[NSString stringWithFormat:@"%d",1];
    }
    else if([self.isHaveAdd integerValue] != 1 ){//无地址
        if (self.delegate && [self.delegate respondsToSelector:@selector(goodsNumChange:)]) {
            [self.delegate goodsNumChange:0];
        }
    }else{
        if (self.delegate && [self.delegate respondsToSelector:@selector(goodsNumChange:)]) {
            [self.delegate goodsNumChange:self.count];
        }
        self.numLabel.text=[NSString stringWithFormat:@"%d",self.count];
    }
}

-(void)setCount:(int)count
{
    if ([self.isSeckilling integerValue] > 0) {//秒杀
        _count=1;
        self.numLabel.text=[NSString stringWithFormat:@"%d",1];
    }else if (self.goods.type == 2) {//虚拟
        _count=count;
        self.numLabel.text=[NSString stringWithFormat:@"%d",self.count];
        return;
    }else if([self.isHaveAdd integerValue] == 0)                                                                                                            {//没地址且不包邮
        return;
    }else{
        _count=count;
        self.numLabel.text=[NSString stringWithFormat:@"%d",self.count];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    int num = [textField.text intValue];
    if (num > self.modle.nums.intValue) {
        self.blockPrompt();
        _numLabel.text = @"1";
    }
}

@end
