//
//  CJFillerView.m
//  MarketManage
//
//  Created by 赵春景 on 15-8-28.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "CJFillerView.h"
#import "UIImage+MJ.h"
#import "CJAttributeHeaderFile.h"//宏定义的头文件



@interface CJFillerView ()

{
    /** 属性界面 全局的frame */
    CGRect _frame;
    /** 头标题文字 */
    UILabel *_label;
    /** 上一个View的最大y 值 */
    CGFloat _height;
    /** 记录按钮的第一行的最大Y值 */
    CGFloat _minHeight;
    /** 记录按钮的最后一行的最大Y值 */
    CGFloat _maxHeight;
    
    /** 传过来的照片 默认状态 */
    UIImage *_image;
    /** 传过来的照片 选中状态 */
    UIImage *_imageSelect;
    /** 传过来的照片 没有该属性时的照片 */
    UIImage *_imageNo;
    
    /** 标题的名字 外部传入 */
    NSString *_titleName;
    /** 标题的子标题 */
    NSString *_subTitleName;
    /** 用来接收外部传的数据 */
    NSArray *_dataArray;
    /** 外部传入的tag 头数 */
    NSInteger _numTag;
    /** 添加按钮的数组 */
    NSMutableArray *_btnArray;
    /** 用来记录第一行按钮的选中状态 */
    NSString *_oneOldBtnName;
    
}

@end

@implementation CJFillerView


- (instancetype)initWithFrame:(CGRect)frame titleName:(NSString *)titleName subTitleName:(NSString *)subTitleName dataArray:(NSArray *)dataArray numTag:(NSInteger)numTag oneSelsctBtnName:(NSString *)oneSelsctBtnName
{
    if (self = [super initWithFrame:frame]) {
        
        _frame = frame;
        _titleName = titleName;
        _subTitleName = subTitleName;
        _dataArray = [NSArray arrayWithArray:dataArray];
        _btnArray = [NSMutableArray array];
        _numTag = numTag;
        _oneOldBtnName = oneSelsctBtnName;
        
        //        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        /**
         * 添加头标题的ViewLabel
         */
        [self makeViewLabel];
        
        if (_dataArray.count) {
            /**
             * 添加自定义的button  根据图片的尺寸来决定button的大小
             */
            [self makeButton];
        }
        
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect frameSelf = self.frame;
    frameSelf.size.height = _height + 20 *SP_HEIGHT;
    self.frame = frameSelf;
}

/**
 * 添加头标题的ViewLabel
 */
- (void)makeViewLabel
{
    if (_numTag != 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.size.width, 0.5)];
        view.backgroundColor = [UIColor colorWithRed:232 / 255.0 green:232 / 255.0 blue:233 / 255.0 alpha:1];
        [self addSubview:view];
    }
    
    CGFloat lableX = LeftGap *SP_WIDTH;
    CGFloat lableY = 17 * SP_HEIGHT;
    CGFloat lableW = 65 *SP_WIDTH;
    CGFloat lableH = 20;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(lableX, lableY, lableW, lableH)];
    
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:14];
    [self addSubview:label];
    label.text = _titleName;
    _label = label;
    _height = CGRectGetMaxY(_label.frame);
    
    //红字部分字体
    UILabel *nameLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), lableY, SCREENWIDTH - lableW - lableX * 2, lableH)];
    nameLable.textColor = [UIColor colorWithRed:170/255.0 green:0 blue:0 alpha:1];
    nameLable.textAlignment = NSTextAlignmentLeft;
    nameLable.font = [UIFont systemFontOfSize:12];
    [self addSubview:nameLable];
    nameLable.text = _subTitleName;
    self.fillerSubLabel = nameLable;
    
    //类型多的时候出现的下拉按钮
    CGFloat btnY = lableY;
    CGFloat btnW = 40 *SP_WIDTH;
    CGFloat btnH = lableH;
    CGFloat btnX = SCREENWIDTH - btnW;
    UIButton *btnLable = [UIButton buttonWithType:UIButtonTypeCustom];
    btnLable.frame = CGRectMake(btnX, btnY, btnW, btnH);
    [btnLable setBackgroundColor:[UIColor clearColor]];
    [btnLable setImage:[UIImage imageNamed:@"mall_list_ico_arrow1"] forState:UIControlStateNormal];
    [btnLable setImage:[UIImage imageNamed:@"mall_list_ico_arrow2"] forState:UIControlStateSelected];
    [btnLable addTarget:self action:@selector(btnLableClick:) forControlEvents:UIControlEventTouchUpInside];
    btnLable.tag = 200;
    [self addSubview:btnLable];
    self.fillerLableBtn = btnLable;
    
    if (!_dataArray.count) {
        [self layoutSubviews];
    }
    
}
/** 类型多的时候出现的下拉按钮的点击事件 */
- (void)btnLableClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected) {
        _height = _maxHeight;
        
        for (id btn in self.subviews) {
            if ([btn isKindOfClass:[UIButton class]]) {
                UIButton *btnBig = (UIButton *)btn;
                if (btnBig.tag != 200) {
                    [btnBig removeFromSuperview];
                }
            }
        }
        for (UIButton *btn in _btnArray) {
            [self addSubview:btn];
        }
        
    } else {
        _height = _minHeight;
        for (id btn in self.subviews) {
            if ([btn isKindOfClass:[UIButton class]]) {
                UIButton *btnBig = (UIButton *)btn;
                if (btnBig.tag != 200) {
                    [btnBig removeFromSuperview];
                }
            }
        }
        for (int i = 0; i < 3; i++) {
            UIButton *btn = _btnArray[i];
            [self addSubview:btn];
        }
    }
    [self layoutSubviews];
    self.blockFillerDownBtnClick(sender);
}


/**
 * 添加自定义的button  根据图片的尺寸来决定button的大小
 */
- (void)makeButton
{
    
    _image = [UIImage resizedImageWithName:@"mall_list_btn_default"];
    _imageSelect = [UIImage resizedImageWithName:@"mall_list_btn_selected"];
    CGFloat W = (SCREENWIDTH - 50 * SP_WIDTH) / 3;
    CGFloat H = _image.size.height;
    if (_numTag != 0) {
        H = H * 1.5;
    }
    
    
    /** 按钮的宽度＋ 间隔的宽度 */
    CGFloat btnWidth = (W + 15 * SP_WIDTH);
    
    /** 按钮的高度 ＋ 间隔的高度 */
    CGFloat btnHeight = H + 8 * SP_HEIGHT;
    
    /** 计算一行能够加载多少个btn */
    NSInteger num = 3;
    
    /** btn的个数 */
    int btnNum = (int)_dataArray.count;
    
    for (int i = 0; i < btnNum; i++) {
        CGFloat X = LeftGap  + (i % num) * btnWidth;
        CGFloat Y = _height + 10 * SP_HEIGHT + (i / num) * btnHeight;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(X, Y, W, H);
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn setBackgroundImage:_image forState:UIControlStateNormal];
        [btn setBackgroundImage:_imageSelect forState:UIControlStateSelected];
        if (_numTag == 0) {
            [btn setTitle:_dataArray[i] forState:UIControlStateNormal];
            [btn setTitle:_dataArray[i] forState:UIControlStateSelected];
            if ([_dataArray[i] isEqualToString:_oneOldBtnName]) {
                btn.selected = YES;
//                _oldBtn = btn;
            } else {
                btn.selected = NO;
            }
        }else {
            //限制最多显示10个字
            NSString *textName = [MarketAPI labelTextNumConfineWithTextNum:10 textName:_dataArray[i][@"cate_name"]];
            
            [btn setTitle:IfNullToString( textName) forState:UIControlStateNormal];
            [btn setTitle:IfNullToString( textName) forState:UIControlStateSelected];
            if ([_dataArray[i][@"cate_name"] isEqualToString:_subTitleName]) {
                btn.selected = YES;
                _oldBtn = btn;
            } else {
                btn.selected = NO;
            }
            btn.titleLabel.numberOfLines = 2;
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5 * SP_WIDTH, 0, 5 *SP_WIDTH);
        }
        
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.tag = _numTag + i;
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i < 3) {
            [self addSubview:btn];
        }
        [_btnArray addObject:btn];
        
        
        if (i == 0) {
            _minHeight = CGRectGetMaxY(btn.frame);
        }
        //判断是否是最后一个btn 是最后一个设置view的frame
        if (i == btnNum - 1) {
            _maxHeight = CGRectGetMaxY(btn.frame);
            _height = _minHeight;
            [self layoutSubviews];
            
            if (_numTag == 0) {
                for (UIButton *btn in _btnArray) {
                    if (btn.selected) {
                        
//                        [[NSNotificationCenter defaultCenter]postNotificationName:@"Button1111111" object:btn];
                        [self btnClick:btn];
                    }
                }
            }
            
        }
    }
}

- (void)btnClick:(UIButton *)sender
{
    if (_oldBtn.titleLabel.text != sender.titleLabel.text) {
        _oldBtn.selected = NO;
        sender.selected = YES;
        _oldBtn = sender;
        if (_numTag != 0) {
            self.fillerSubLabel.text = _dataArray[sender.tag % _numTag][@"cate_name"];
            self.blockBtnText(sender);
        } else {
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"Button1111111" object:nil userInfo:@{@"btn":sender}];
        }

    }
}
-(void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Button1111111" object:nil];
}

@end
