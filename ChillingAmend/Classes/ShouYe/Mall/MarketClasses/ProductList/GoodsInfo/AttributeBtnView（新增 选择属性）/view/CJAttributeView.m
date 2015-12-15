//
//  CJAttributeView.m
//  MarketManage
//
//  Created by 赵春景 on 15-7-24.
//  Copyright (c) 2015年 Rice. All rights reserved.
//  添加 颜色  尺寸 等 模块的按钮

#import "CJAttributeView.h"
#import "CJAttributeHeaderFile.h"//宏定义的头文件
#import "UIImage+MJ.h"
#import "CJAttributeModle.h"//  商品属性 一级模型
#import "CJAttributeSpecModel.h"//  商品属性 二级模型

@interface CJAttributeView ()

{
    /** 属性界面 全局的frame */
    CGRect _frame;
    /** 头标题文字 */
    UILabel *_label;
    /** 上一个View的最大y 值 */
    CGFloat _height;
    
    /** 标题的名字 外部传入 */
    NSString *_titleName;
    
    /** 全局的宽度，记录btn的下一个按钮的最大X值 */
    CGFloat _width;
    /** 传入的第几组  也就是商品属性一级模型元素数组的第几个元素 */
    int _group;
    /** 用来记录不相同规格数据的数组 */
    NSMutableArray *_recordArray;
    
    /** 按钮的宽度 */
    CGFloat _W;
    /** 按钮的高度 */
    CGFloat _H;
    /** 按钮的高度 ＋ 间隔的高度 */
    CGFloat _btnHeight;
    /** btn的个数 */
    NSUInteger _btnNum;
    /** 全局的btn */
    CJMyButton *_btn;
    /** 全局的一级数据模型 */
    CJAttributeModle *_model;
    /** 全局的二级数据模型 */
    CJAttributeSpecModel *_specModel;
    
    
    
}

@end

@implementation CJAttributeView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.blockViewClick();
}

- (instancetype)initWithFrame:(CGRect)frame andLSYGoodsInfo:(LSYGoodsInfo *)goods titleName:(NSString *)titleName group:(int)group CJAttributeModel:(CJAttributeModle *)attributeModel
{
    if (self = [super initWithFrame:frame]) {
        
        _frame = frame;
        _titleName = titleName;
        self.goods = goods;
        _group = group;
        self.getAttributeModel = attributeModel;
        
        _recordArray = [NSMutableArray array];
        self.btnArrayM = [NSMutableArray array];
        self.backgroundColor = [UIColor whiteColor];
        /**
         * 添加头标题的ViewLabel
         */
        [self makeViewLabel];
        
        /**
         * 添加自定义的button  根据图片的尺寸来决定button的大小
         */
        [self makeButton];
        
    }
    return self;
}

//自动布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect frameSelf = self.frame;
    frameSelf.size.height = _height;
    self.frame = frameSelf;
    
}


/**
 * 添加头标题的ViewLabel
 */
- (void)makeViewLabel
{
    CGFloat lableX = LeftGap;
    CGFloat lableY = 15 * SP_WIDTH;
    CGFloat lableW = 80 *SP_WIDTH;
    CGFloat lableH = 20;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(lableX, lableY, lableW, lableH)];
    
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:15];
    [self addSubview:label];
    label.text = _titleName;
    _label = label;
    _height = CGRectGetMaxY(_label.frame);
}

/**
 * 添加自定义的button  根据图片的尺寸来决定button的大小
 */
- (void)makeButton
{
    /** 按钮的宽度 */
    _W = 30 * SP_WIDTH;
    /** 按钮的高度 */
    _H = 30 ;
    
    /** 按钮的高度 ＋ 间隔的高度 */
    _btnHeight = _H + 10 ;
    
    _width = LeftGap;
    _height += 10;
    
    
#warning 需要添加按钮的个数
    /** btn的个数 */
    _btnNum = self.goods.attr_spec.count;
    //int btnNum = 20;
    for (int i = 0; i < _btnNum; i++) {
        _model = self.goods.attr_spec[i];
        _specModel = _model.spec_idArray[_group];
        
        if (self.btnArrayM.count ==0) {
            [self makeBtnWithNum:i andTitleName:_specModel.value];
        } else {
            //记录循环次数
            int j = 1;
            
            //循环检测存储数组中有没有该按钮
            for (CJMyButton *btn in self.btnArrayM) {
                if ([btn.titleLabel.text isEqualToString:_specModel.value]) {
                    //判断是否是默认选中的btn
//                    [self judgeDefaultSelecteBtn];
                    //判断是否是商品详情页已选模型 并将设为选中状态
                    [self judgeSelecteBtn];
                    
                    if (_group == 0) {
                        //检测到有相同的 把相应的模型放到 自定义btn中的数组中
                        [btn.buttonArray addObject:_model];
                    }
                    
                    break;
                }
                if (j == self.btnArrayM.count) {
                    //  创建按钮
                    [self makeBtnWithNum:i andTitleName:_specModel.value];
                }
                j++;
            }
            
        }
        //判断是否是最后一个btn 是最后一个设置view的frame
        if (i == _btnNum - 1) {
            _height = CGRectGetMaxY(_btn.frame);
            [self layoutSubviews];
        }
        //判断是否是默认选中的btn
//        [self judgeDefaultSelecteBtn];
        //判断是否是商品详情页已选模型 并将设为选中状态
        [self judgeSelecteBtn];
    }
}
/**
 * 判断是否是默认选中的btn
 */
- (void)judgeDefaultSelecteBtn
{
    if ([_model.defaultP isEqualToString:@"1"]) {
        for (CJMyButton *btn in self.btnArrayM) {
            if ([btn.titleLabel.text isEqualToString:_specModel.value]) {
                btn.selected = YES;
                _oldBtn = btn;
                btn.buttonModelArray = [NSMutableArray array];
            }
        }
    }
}
/**
 * 判断是否是商品详情页已选模型 并将设为选中状态
 */
- (void)judgeSelecteBtn
{
    if (self.getAttributeModel.spec_idArray.count != 0) {
        CJAttributeSpecModel *specModel = self.getAttributeModel.spec_idArray[_group];
        for (CJMyButton *btn in self.btnArrayM) {
            if ([btn.titleLabel.text isEqualToString:specModel.value]) {
                btn.selected = YES;
                _oldBtn = btn;
                btn.buttonModelArray = [NSMutableArray array];
            }
        }
    }
}


/**
 * 创建按钮
 */
- (void)makeBtnWithNum:(int)i andTitleName:(NSString *)titleName
{
    CJMyButton *btn = [CJMyButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [btn setBackgroundImage:[UIImage resizedImageWithName:@"mall_list_colour_normal2"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage resizedImageWithName:@"mall_list_size_selected"] forState:UIControlStateSelected];
    [btn setTitle:titleName forState:UIControlStateNormal];
    [btn setTitle:titleName forState:UIControlStateSelected];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    
    //计算文字的宽度
    NSString *textStr = btn.titleLabel.text;
    CGSize size = [textStr sizeWithFont:btn.titleLabel.font constrainedToSize:CGSizeMake(CGFLOAT_MAX, btn.frame.size.height) lineBreakMode:NSLineBreakByWordWrapping];
    
    //限定文字的最小宽度
    if (size.width < 25) {
        size.width = 25;
    }
    _W = size.width + 10 *SP_WIDTH;
    
    //判断按钮的位置坐标
    if ((_width + _W + 14 * SP_WIDTH) > ScreenW) {
        _width = LeftGap;
        _height += _btnHeight;
    } else if (_width != LeftGap) {
        _width += 14 * SP_WIDTH;
    }
    CGFloat X = _width;
    CGFloat Y = _height;
    
    btn.frame = CGRectMake(X, Y, _W, _H);
    _width = CGRectGetMaxX(btn.frame);
    
    
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    btn.buttonArrayBtn = [NSMutableArray array];
    btn.buttonArray = [NSMutableArray array];
    btn.buttonModelArray = [NSMutableArray array];
    if (_group == 0) {
        //本个按钮里面的数组  用来记录模型的
        [btn.buttonArray addObject:_model];
    }
    
    //存储创建的btn
    [self.btnArrayM addObject:btn];
    //    //记录btn的title名字  （可用上面的数组代替）
    //    [_recordArray addObject:titleName];
    
    
    
    _btn = btn;
    
}


- (void)btnClick:(CJMyButton *)sender
{
    if (_oldBtn.titleLabel.text != sender.titleLabel.text) {
        _oldBtn.selected = NO;
        sender.selected = YES;
        _oldBtn = sender;
        self.blockBtnText(_oldBtn);
    } else {
        _oldBtn.selected = !sender.selected;
        self.blockBtnText(_oldBtn);
    }
}

/**
 * 当按钮选中后调用这个方法 判断按钮是否是置非状态
 */
- (void)attributeViewWithCJAttributeViewBtnArray:(NSMutableArray *)btnArray
{
    for (CJMyButton *btn in btnArray) {
        if (btn.isDefault == YES) {//如果判断是否不存在 为yes btn设置为不激活状态
            [btn setBackgroundImage:[UIImage resizedImageWithName:@"mall_list_size_default"] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithRed:197 / 255.0 green:197 / 255.0 blue:197 / 255.0 alpha:1] forState:UIControlStateNormal];
            btn.enabled = NO;
            if (btn.selected) {
                btn.selected = NO;
                _oldBtn = nil;
            }
        } else {
            btn.enabled = YES;
            [btn setBackgroundImage:[UIImage resizedImageWithName:@"mall_list_colour_normal2"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage resizedImageWithName:@"mall_list_size_selected"] forState:UIControlStateSelected];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        }
    }
}


@end
