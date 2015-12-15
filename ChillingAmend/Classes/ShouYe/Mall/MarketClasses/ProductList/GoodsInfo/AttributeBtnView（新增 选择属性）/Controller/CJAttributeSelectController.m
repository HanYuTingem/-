//
//  CJAttributeSelectController.m
//  MarketManage
//
//  Created by 赵春景 on 15-7-23.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "CJAttributeSelectController.h"
#import "CJAttributeHeaderFile.h"//头文件
#import "CJAttributeHeadView.h" //头部View
#import "CJAttributeView.h" //自定义的属性按钮view
#import "CJAttributeNumAddView.h" // 加减号方格计数器
#import "ZXYCommitOrderRequestModel.h" //提交订单请求数据
#import "CrazyShoppingAddorRemoveModel.h"//购物车添加或删除
#import "CJAttributeModle.h"//商品属性 一级数组模型
#import "CJAttributeSpecModel.h"//商品属性 二级数组模型
#import "CJMyButton.h"//自定义btn
#import "LSYConfirmOrderViewController.h"//提交订单页
#import "ConfirmOrderViewController.h"//15.8修改的提交订单页

#define LOAD_FAILURE @"加载失败"

@interface CJAttributeSelectController () <CJAttributeNumAddViewDelegate,UITextFieldDelegate>

{
    /** 全局的头部view */
    CJAttributeHeadView *_headerView;
    /** 全局的最大Y值 */
    CGFloat _height;
    /** 真正的计数器的最大Y值 */
    CGFloat _numViewHeight;
    /** 最后一个按钮的试图的最大Y值 */
    CGFloat _lastBtnMaxY;
    /** 键盘的高度 */
    int _keyHeight;
    /** 记录上一层按钮View的全局View */
    CJAttributeView *_oldView;
    /** 用来添加view的数组 */
    NSMutableArray *_viewArray;
    /** 全局的加减计数 */
    CJAttributeNumAddView *_addView;
    /** 最终选定的模型 */
    CJAttributeModle *_lastModel;
    /** 用来记录点击按钮是选中状态下 用来存储模型数组 */
    NSMutableArray *_dataArray;
    
    /** 全局的自定义按钮 */
    CJMyButton *_myButton;
    /** 用来记录按钮是否有选中状态 按钮没有选中状态No 价格变为传过来的价格 */
    BOOL _btnSelecteType;
    /** 按钮的选中状态的个数 */
    int _selecteTypeNum;
    
}

/** 底部scrollView */
@property (weak, nonatomic) IBOutlet UIScrollView *bigScrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bigScrollViewH;

/** 获取默认地址/运费的模型 提交订单请求数据 */
@property (nonatomic,strong) ZXYCommitOrderRequestModel *commitModel;
/** 网络请求 */
@property (strong,nonatomic)GCRequest * lsyMainRequest;


@end

@implementation CJAttributeSelectController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _viewArray = [NSMutableArray array];
    _dataArray = [NSMutableArray array];
    
    self.mallTitleLabel.text = @"选择属性";
    if (self.attributeSelect == AttributeSelectAdd) {
       self.mallTitleLabel.text = @"加入购物车";
    } else if (self.attributeSelect == AttributeSelectBuyNow) {
        self.mallTitleLabel.text = @"立即购买";
    }
    
    self.bigScrollViewH.constant = ScreenHeight - 64 - 48;
    
    /**
     * 添加下面的加入购物车  和 立即购买按钮
     */
    [self makeAddAndBuyBtn];
    
    /**
     * 添加头部View
     */
    [self makeHeaderView];
    /**
     * 添加自定义的属性按钮
     */
    [self makeAttributeView];
    
    /**
     * 添加加减号方格计数器
     */
    [self makeNumAddView];
    [self addKeyBoardSEL];
    
    /**
     * 自定义的属性按钮 状态的判定 tag为第几组
     */
    CJAttributeModle *model = self.goods.attr_spec[0];
    [self attributeViewBtnEnableWithTag:(int)model.spec_idArray.count - 1];
    
}

/**
 * 监听键盘的状态
 */
- (void)addKeyBoardSEL
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
/** 键盘弹出 */
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    _keyHeight = keyboardRect.size.height;
//    CGRect bounds = self.bigScrollView.bounds;
//    if (SCREENHEIGHT > 568) {
//        bounds.origin.y = _keyHeight - 48;
//    } else if(SCREENHEIGHT == 480){
//        bounds.origin.y = _keyHeight + 70;
//    } else if(SCREENHEIGHT == 568) {
//        bounds.origin.y = _keyHeight - 8;
//    }
//    self.bigScrollView.bounds = bounds;
    
    
    self.buyNowBtn.hidden = YES;
    self.addShoppingCartBtn.hidden = YES;
    if (_numViewHeight > SCREENHEIGHT - _keyHeight) {
        CGRect viewBounds = self.view.bounds;
        viewBounds.origin.y = _keyHeight;
        self.view.bounds = viewBounds;
    }
    
}
/** 键盘隐藏 */
- (void)keyboardWillHide:(NSNotification *)aNotification
{
//    CGRect bounds = self.bigScrollView.bounds;
//    bounds.origin.y = 0;
//    self.bigScrollView.bounds = bounds;
    
    self.buyNowBtn.hidden = NO;
    self.addShoppingCartBtn.hidden = NO;
    if (self.attributeSelect == AttributeSelectAdd) {
        self.buyNowBtn.hidden = YES;
    } else if (self.attributeSelect == AttributeSelectBuyNow) {
        self.addShoppingCartBtn.hidden = YES;
    }
    if (_numViewHeight > SCREENHEIGHT - _keyHeight) {
        CGRect viewBounds = self.view.bounds;
        viewBounds.origin.y = 0;
        self.view.bounds = viewBounds;
    }
    
    [self repertoryBeyond];
    
}

/**
 * 添加加减号方格计数器  addView 的高度随便写  高度会自动计算
 */
- (void)makeNumAddView
{
    _lastBtnMaxY = _height;
    NSString *nums = nil;
    if (self.getAttributeModel.spec_idArray.count == 0) {
        nums = @"1";
    } else {
        nums = self.getAttributeGoodsNums;
    }
    
    CJAttributeNumAddView *addView = [[CJAttributeNumAddView alloc] initWithFrame:CGRectMake(0, _height, SCREENWIDTH, 200) WithAttributeGoodsNums:nums];
    addView.numLabel.delegate = self;
    [self.bigScrollView addSubview:addView];
    _addView = addView;
    _height = CGRectGetMaxY(addView.frame);
    _numViewHeight = _height;
    if (_height < SCREENHEIGHT - 64 - 48) {
        _numViewHeight = _height;
        //重新计算addView的高度
        CGRect frame = addView.frame;
        frame.size.height += (SCREENHEIGHT - 64 - 48  - _height);
        addView.frame = frame;
        _height = CGRectGetMaxY(self.bigScrollView.frame) ;
    }
    self.bigScrollView.contentSize = CGSizeMake(0, _height);
    
#pragma mark 数量计数器的  文字的回调
    addView.blockNumAddViewText = ^(NSString *textStr){
        NSLog(@"addView.blockNumAddViewTex ==== %@    %@",textStr,_addView.numLabel.text);
        if (self.restriction != 0 && [textStr integerValue] > self.restriction) {
            [self showMsg:@"超出限购啦亲"];
            _addView.numLabel.text = [NSString stringWithFormat:@"%d",[_addView.numLabel.text intValue]];
        }
    };
    //提示信息的回调
    addView.blockPrompt = ^{
        if (_dataArray.count == 1) {
            [self showMsg:@"超出商品库存了亲"];
        } else {
            [self showMsg:@"请选择商品属性"];
        }
    };
    
    //键盘收起的事件的回调
    addView.blockViewClickAdd = ^{
        [self.view endEditing:YES];
        [self repertoryBeyond];
    };
    
    //是否秒杀
    addView.isSeckilling = [NSString stringWithFormat:@"%d",(int)self.isSeckilling];
    //    addView.isHaveAdd = @"1";
    //    //如果快递判断是否有地址
    //    if ([_commitModel.address isEqualToString:@""]) {
    //        addView.isHaveAdd = @"0";
    //    }
    addView.goods=self.goods;
    addView.count = (int)[_commitModel.goods_nums integerValue];
    addView.delegate=self;
    
}

#pragma mark - 代理传值
/**
 商品数量改变
 快递无收货地址 不请求运费 不改变个数
 秒杀订单      不请求运费 不改变个数
 符合条件请求运费
 更新总价
 */
-(void)goodsNumChange:(int)count
{
    if (count == 0) {
        //        [self showMsg:@"还没有收货地址呢亲~\n先添加一个吧"];
        //        return;
    }else if(count > 10000){
        
        if(self.goods.available == self.goods.restriction){
            [self showMsg:[NSString stringWithFormat:@"超出限购啦亲"]];
        }else{
            [self showMsg:[NSString stringWithFormat:@"宝贝限购%d件，您已购买%d件",count - 10000,self.goods.restriction -self.goods.available]];
        }
        return;
    }else if(count==1000){
        [self showMsg:@"库存不足"];
        return;
    }
    if (!self.isSeckilling) {
        //        _commitModel.goods_nums = [NSString stringWithFormat:@"%d",count];
        //        [self updateAmountPrice];
        //        [self getFreight];
    }
}
/**
 * 判断是否超出库存 yes为超出库存
 */
- (BOOL)repertoryBeyond
{
    if ((_lastModel.nums.intValue < _addView.numLabel.text.intValue) && _lastModel.spec_idArray.count) {
        //
        CJAttributeModle *model = self.goods.attr_spec[0];
        if (_dataArray.count == 1 && model.spec_idArray.count == _selecteTypeNum) {
            [self showMsg:@"超出商品库存了亲"];
        } else {
            [self showMsg:@"请选择商品属性"];
        }
        _addView.numLabel.text = @"1";
        return YES;
    } else if (_addView.numLabel.text.intValue == 0) {
        [self showMsg:@"购买不能为0件"];
        _addView.numLabel.text = @"1";
        return YES;
    } else if ((self.goods.nums < _addView.numLabel.text.intValue) && _dataArray.count > 1) {
        [self showMsg:@"超出商品库存了亲"];
        _addView.numLabel.text = @"1";
        return YES;
    }else if (self.restriction != 0 && [_addView.numLabel.text intValue] > self.restriction){
        [self showMsg:@"超出限购啦亲"];
        _addView.numLabel.text = @"1";
        return YES;
    }
    return NO;
}
/**
 * 添加自定义的属性按钮
 */
- (void)makeAttributeView
{
    if (self.goods.attr_spec.count != 0) {
        CJAttributeModle *model = self.goods.attr_spec[0];
        _height = CGRectGetMaxY(_headerView.frame) + 1;
        //
        //判断是什么样的图片
        int i = 0;
        for (CJAttributeSpecModel *specModel in model.spec_idArray) {
            
            //添加自定义的属性按钮的view
            CJAttributeView *view = [[CJAttributeView alloc] initWithFrame:CGRectMake(0, _height, SCREENWIDTH, 110) andLSYGoodsInfo:self.goods titleName:specModel.key group:i CJAttributeModel:self.getAttributeModel];
            view.getAttributeModel = self.getAttributeModel;
            
            //键盘收起的事件的回调
            view.blockViewClick = ^{
                [self.view endEditing:YES];
                [self repertoryBeyond];
            };
            
            [self.bigScrollView addSubview:view];
            _height = CGRectGetMaxY(view.frame);
            
            if (i == 0) {
                _oldView = view;
            } else {
                
                //遍历上一级数组
                for (CJMyButton *oldButton in _oldView.btnArrayM) {
                    for (CJAttributeModle *model in oldButton.buttonArray) {
                        CJAttributeSpecModel *oldspecModel = model.spec_idArray[i];
                        for (CJMyButton *btn in view.btnArrayM) {
                            btn.buttonArray = [NSMutableArray array];
                        }
                        
                        int j = 0;
                        //遍历本级数组
                        for (CJMyButton *btn in view.btnArrayM) {
                            if ([btn.titleLabel.text isEqualToString:oldspecModel.value]) {
                                [btn.buttonArray addObject:model];
                                //设置按钮
                                btn.isDefault = NO;
                                break;
                            } else {
                                if (j == view.btnArrayM.count - 1) {
                                    btn.isDefault = YES;
                                }
                            }
                        }//
                    }
                }
                _oldView = view;
            }
            view.tag = i;
            [_viewArray addObject:view];
            i++;
            
#pragma mark 属性按钮的点击事件的回调
            //属性按钮的点击事件的回调
            view.blockBtnText = ^(CJMyButton *clickBtn){
                _myButton = clickBtn;
                //属性按钮 状态的判定 tag为第几组  按钮的激活与非激活状态
                [self attributeViewBtnEnableWithTag:(int)clickBtn.superview.tag];
            };
        }
    }
}

/**
 * 属性按钮 状态的判定 tag为第几组  按钮的激活与非激活状态
 */
- (void)attributeViewBtnEnableWithTag:(int)myTag
{
    if (self.goods.attr_spec.count != 0) {
        CJAttributeModle *model = self.goods.attr_spec[0];
        
        //首先要得到数据
        //        for (int i = 0; i < model.spec_idArray.count; i++) {
        //        if (!_myButton.selected) {
        _dataArray.array = self.goods.attr_spec;
        //        }
        _btnSelecteType = NO;
        _selecteTypeNum = 0;
        for (int j = 0; j < model.spec_idArray.count; j++) {
            NSLog(@" j === %d  myTag === %d",j,myTag);
            if (!_myButton.selected) {
                myTag = -1;
            }
            //                if (j != myTag) {
            
            CJAttributeView *view = _viewArray[j];
            //用来临时存储模型的数组
            NSMutableArray *tempArray = [NSMutableArray array];
            
            for (CJMyButton *btn in view.btnArrayM) {
                if (btn.selected) {
                    _btnSelecteType = YES;
                    _selecteTypeNum++;
                    int k = 0;
                    for (CJAttributeModle *btnModel in _dataArray) {
                        CJAttributeSpecModel *btnSpecModel = btnModel.spec_idArray[j];
                        if ([btn.titleLabel.text isEqualToString:btnSpecModel.value]) {
                            [tempArray addObject:btnModel];
                        }
                        if (k == _dataArray.count - 1) {
                            _dataArray.array = tempArray;
                            NSLog(@"dataArray.count == %ld",(unsigned long)_dataArray.count);
                        }
                        k++;
                    }
                }
            }
            
            //                }
            //设置按钮的状态
            if (j == model.spec_idArray.count - 1) {
                
                NSLog(@"_dataArray ---- %ld",(unsigned long)_dataArray.count);
                
                for (int n = 0; n < model.spec_idArray.count; n++) {
                    
                    NSLog(@" n === %d  myTag === %d",n,myTag);
                    
                    //本组按钮相关的数据 除本组外的其他数据
                    NSMutableArray *selfArray = [NSMutableArray arrayWithArray:self.goods.attr_spec];
                    for (int i = 0; i < model.spec_idArray.count; i++) {
                        if (i != n) {
                            CJAttributeView *selfView = _viewArray[i];
                            NSMutableArray *selfTempArray = [NSMutableArray array];
                            for (CJMyButton *selfBtn in selfView.btnArrayM) {
                                if (selfBtn.selected) {
                                    _btnSelecteType = YES;
                                    for (CJAttributeModle *selfModel in selfArray) {
                                        CJAttributeSpecModel *selfSpecModel = selfModel.spec_idArray[i];
                                        //判断与本按钮相关数据的比较 并且库存不能为0
                                        if ([selfBtn.titleLabel.text isEqualToString:selfSpecModel.value] && ![selfModel.nums isEqual:@"0"]) {
                                            [selfTempArray addObject:selfModel];
                                        }
                                    }
                                    selfArray.array = selfTempArray;
                                }
                            }
                            
                        }
                    }
                    //通过上面得到的数据来确定 本组数据选中按钮的相关数据
                    CJAttributeView *viewLast = _viewArray[n];
                    int k = 0;
                    for (CJMyButton *btn in viewLast.btnArrayM) {
                        btn.buttonModelArray = [NSMutableArray array];
                        for (CJAttributeModle *btnModel in selfArray) {
                            CJAttributeSpecModel *btnSpecModel = btnModel.spec_idArray[n];
                            //判断与本按钮相关数据的比较 并且库存不能为0
                            if ([btn.titleLabel.text isEqualToString:btnSpecModel.value] && ![btnModel.nums isEqual:@"0"]) {
                                [btn.buttonModelArray addObject:btnModel];
                            }
                        }
                        NSLog(@"btn.buttonModelArray.count ====== ----- %ld",(unsigned long)btn.buttonModelArray.count);
                        if (btn.buttonModelArray.count != 0) {
                            btn.isDefault = NO;
                        } else {
                            btn.isDefault = YES;
                        }
                        if (k == viewLast.btnArrayM.count - 1) {
                            [viewLast attributeViewWithCJAttributeViewBtnArray:viewLast.btnArrayM];
                        }
                        k++;
                    }
                    //                        }
                }
                //最后一组数据  判断价格区间
                if (_dataArray.count == 1) {
                    CJAttributeModle *lastModel = [_dataArray lastObject];
                    _headerView.priceLabel.text = [MarketAPI judgeCostTypeWithCash:[NSString stringWithFormat:@"%f",[lastModel.cash floatValue]] andIntegral:[NSString stringWithFormat:@"%.0f",self.goods.price] withfreight:@"0" withWrap:NO];
                    _addView.modle = lastModel;
                    _lastModel = lastModel;
                } else {
                    //按钮一个也没有选中时 价格为初始价格
                    if (!_btnSelecteType) {
                        _headerView.priceLabel.text = [MarketAPI judgeCostTypeWithCash:[NSString stringWithFormat:@"%f",self.goods.cash] andIntegral:[NSString stringWithFormat:@"%.0f",self.goods.price] withfreight:@"0" withWrap:NO];
                    }
#if 0               //判断价格区间  现取消
                    CJAttributeModle *minCashModel = [_dataArray firstObject];
                    CJAttributeModle *maxCashModel = [_dataArray firstObject];
                    for (CJAttributeModle *modelCash in _dataArray) {
                        if ([minCashModel.cash longLongValue] > [modelCash.cash longLongValue]) {
                            minCashModel = modelCash;
                        } else if ([maxCashModel.cash longLongValue] < [modelCash.cash longLongValue]){
                            maxCashModel = modelCash;
                        }
                    }
                    if ([minCashModel.cash isEqualToString:maxCashModel.cash]) {
                        _headerView.priceLabel.text = [NSString stringWithFormat:@"￥%@",minCashModel.cash];
                    } else {
                        _headerView.priceLabel.text = [NSString stringWithFormat:@"￥%@~￥%@",minCashModel.cash,maxCashModel.cash];
                    }
#endif
                }
                
            }
        }
        
    }
    //    }
}


/**
 * 添加头部View
 */
- (void)makeHeaderView
{
    
    NSLog(@"CJAttribute self.goods === %f",self.goods.cash);
    CJAttributeHeadView *headerView = [[CJAttributeHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 110)];
    headerView.goods = self.goods;
    [self.bigScrollView addSubview:headerView];
    _headerView = headerView;
    
    _headerView.priceLabel.text = [MarketAPI judgeCostTypeWithCash:[NSString stringWithFormat:@"%f",self.goods.cash] andIntegral:[NSString stringWithFormat:@"%.0f",self.goods.price] withfreight:@"0" withWrap:NO];
}

/**
 * 添加下面的加入购物车  和 立即购买按钮
 */
- (void)makeAddAndBuyBtn
{
    UIButton *addShoppingCartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    addShoppingCartBtn.frame = CGRectMake(0, SCREENHEIGHT - 48, SCREENWIDTH *0.5, 48);
    [addShoppingCartBtn setBackgroundImage:[UIImage imageNamed:@"mall_content_btn_normal2"] forState:UIControlStateNormal];
    [addShoppingCartBtn setBackgroundImage:[UIImage imageNamed:@"mall_content_btn_selected2"] forState:UIControlStateHighlighted];
    [addShoppingCartBtn setTintColor:[UIColor whiteColor]];
    [addShoppingCartBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [addShoppingCartBtn setTitle:@"加入购物车" forState:UIControlStateHighlighted];
    addShoppingCartBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    
    [addShoppingCartBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addShoppingCartBtn];
    _addShoppingCartBtn = addShoppingCartBtn;
    
    UIButton *buyNowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    buyNowBtn.frame = CGRectMake(CGRectGetMaxX(addShoppingCartBtn.frame), SCREENHEIGHT - 48, SCREENWIDTH *0.5, 48);
    [buyNowBtn setBackgroundImage:[UIImage imageNamed:@"mall_content_btn_normal1"] forState:UIControlStateNormal];
    [buyNowBtn setBackgroundImage:[UIImage imageNamed:@"mall_content_btn_selected1"] forState:UIControlStateHighlighted];
    [buyNowBtn setTintColor:[UIColor whiteColor]];
    [buyNowBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [buyNowBtn setTitle:@"立即购买" forState:UIControlStateHighlighted];
    buyNowBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [buyNowBtn addTarget:self action:@selector(buyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buyNowBtn];
    _buyNowBtn = buyNowBtn;
    
    //判断是否是就一个（确认加入购物车按钮的界面）
    if (self.attributeSelect == AttributeSelectAdd) {
        //确认加入购物车按钮的界面
        _buyNowBtn.hidden = YES;
        
        addShoppingCartBtn.frame = CGRectMake(0, SCREENHEIGHT - 48, SCREENWIDTH , 48);
        [addShoppingCartBtn setTitle:@"确认添加" forState:UIControlStateNormal];
        [addShoppingCartBtn setTitle:@"确认添加" forState:UIControlStateHighlighted];
        [addShoppingCartBtn setBackgroundImage:[UIImage imageNamed:@"mall_content_btn_normal1"] forState:UIControlStateNormal];
        [addShoppingCartBtn setBackgroundImage:[UIImage imageNamed:@"mall_content_btn_selected1"] forState:UIControlStateHighlighted];
    } else if (self.attributeSelect == AttributeSelectBuyNow) {
        //立即购买(一个按钮)的界面
        _addShoppingCartBtn.hidden = NO;
        buyNowBtn.frame = CGRectMake(0, SCREENHEIGHT - 48, SCREENWIDTH , 48);
        [buyNowBtn setTitle:@"立即购买" forState:UIControlStateNormal];
        [buyNowBtn setTitle:@"立即购买" forState:UIControlStateHighlighted];
    }
}

#pragma mark - 加入购物车  和  立即购买的  点击事件
/**
 * 加入购物车的点击事件
 */
- (void)addBtnClick
{
    
    if ([self repertoryBeyond]) {
        return;
    }
    if (_dataArray.count == 1 && [self setAllSelecteButton]) {
        
        if (kkUserCenterId && ![kkUserCenterId isEqual:@""]) {
            //添加购物车
            
            //用来存储最后确定的商品的所有属性信息  需要上传
            NSMutableArray *lastArr = [NSMutableArray array];
            for (CJAttributeSpecModel *lastSpecModel in _lastModel.spec_idArray) {
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:lastSpecModel.key,@"key",lastSpecModel.value,@"value", nil];
                [lastArr addObject:dic];
            }
            
            
            
            [CrazyShoppingAddorRemoveModel crazyShoppingAddorRemoveModelType:CrazyShoppingAddorRemoveModelTypeAdd loadController:nil goodsId:self.goods.goods_id goodsAttributeArray:lastArr goodsAttributeId:_lastModel.ModeleId goodsAttributeNums:_addView.numLabel.text isupdate:self.isupdate completeBlock:^(NSDictionary *infoDic) {
                
                NSLog(@"infoDic=%@",infoDic);
                
                NSLog(@"_addView.numLabel.text = %@",_addView.numLabel.text);
                
                if(!infoDic){
                    [self showMsg:@"商品已失效"];
                    return ;
                }
                if ([infoDic[@"code"] integerValue] == 0) {//添加成功并返回上级页面
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"CrazyShoppingCartViewControllerReloadData" object:nil];
                    [self showMsg:@"添加购物车成功"];
                    self.goods.goodCardNum    =[NSString stringWithFormat:@"%d",[self.goods.goodCardNum intValue] + 1];
                    
                    //block传值 将最后选择的模型传回详情页 改变按钮的状态
                    self.blockAttribute(_lastModel,_addView.numLabel.text);
                    [self.navigationController popViewControllerAnimated:YES];
                    
                }//5、商品已下架；13、库存不足
                else if ([infoDic[@"code"] integerValue] == 103 ||[infoDic[@"code"] integerValue] == 5) {
                    [self showMsg:@"商品已失效"];
                }
                else if ([infoDic[@"code"] integerValue] == 26)
                {
                    [self showMsg:@"超出限购啦亲"];
                    
                }else if ([infoDic[@"code"] integerValue] == 104)
                {
                    [self showMsg:@"购物车满了\n先去结算一些吧"];
                }else
                {
                    [self showMsg:infoDic[@"message"]];
                }
            }];
            
        } else {
            //调转登陆页面
            [MarketAPI jumLoginControllerWithNavPush:self.navigationController];
        }
    } else {
        [self showMsg:@"请选择商品属性"];
    }
    
}

/** 判断按钮是否全部选中 YSE为全部选中 */
- (BOOL)setAllSelecteButton
{
    NSMutableArray *btnSelecteArr = [NSMutableArray array];
    for (CJAttributeView *view in _viewArray) {
        for (CJMyButton *myBtn in view.btnArrayM) {
            if (myBtn.selected) {
                [btnSelecteArr addObject:myBtn];
            }
        }
    }
    
    CJAttributeModle *model = self.goods.attr_spec[0];
    
    return model.spec_idArray.count == btnSelecteArr.count ? YES : NO;
}

/**
 * 立即购买的点击事件
 */
- (void)buyBtnClick
{
    
    if ([self repertoryBeyond]) {
        return;
    }
    if (_dataArray.count == 1 && [self setAllSelecteButton]) {
        NSLog(@"立即购买的点击事件");
        if (kkUserCenterId && ![kkUserCenterId isEqual:@""]) {
            if (self.goods.isSeckilling) {
                if ([self.bugWarring isEqualToString:@""]||self.bugWarring==nil) {//
                    [self seckillingBuy];
                }else{
                    [self showMsg:self.bugWarring];
                }
            }else if(self.goods.restriction >0 &&self.goods.available ==0){
                
                [self showMsg:[NSString stringWithFormat:@"宝贝限购%d件，您已购买%d件",self.goods.restriction,self.goods.restriction -self.goods.available]];
                
            }else{
                if (self.alreadySubmit) {//跳转提交订单页
                    LSYConfirmOrderViewController * confirm=[[LSYConfirmOrderViewController alloc]init];
                    //                    ConfirmOrderViewController *confirm = [[ConfirmOrderViewController alloc] init];
                    confirm.goods=self.goods;
                    //将最后确定的模型传入
                    confirm.attributeModel = _lastModel;
                    confirm.attributeGoodsNums = _addView.numLabel.text;
                    [self.navigationController pushViewController:confirm animated:YES];
                }
            }
        }else{
            
            //调转登陆页面
            [MarketAPI jumLoginControllerWithNavPush:self.navigationController];
            //劳燕子
            
//            [self toLoginVC];
            
        }
    } else {
        [self showMsg:@"请选择商品属性"];
    }
}

#pragma mark - 网络请求
/**
 *初始化请求参数 防止空值崩溃
 */
-(void)initRequetParam
{
    _commitModel = [ZXYCommitOrderRequestModel shareInstance];
    [_commitModel setobject:NULL];
}

/** 立即购买 */
-(void)seckillingBuy
{
    self.lsyMainRequest = [MarketAPI requestSeckillingBuy604WithController:self good_id:self.goods.goods_id];
}
///** 秒杀信息 */
//-(void)getMiaoShaInfo
//{
//    [self startActivity];
//    self.lsyMainRequest = [MarketAPI requestMiaoShaPost603WithController:self good_id:_lastModel.ModeleId hd_ID:_hd_id];
//}


-(void)GCRequest:(GCRequest *)aRequest Finished:(NSString *)aString
{
    
    [self stopActivity];
    NSDictionary * dict = [aString JSONValue];
    
    if (!dict){
        NSLog(@"接口错误");
        return;
    }
    switch (aRequest.tag) {
        case 604:
        {
            if ([dict[@"code"]integerValue]==0) {
                //立即秒杀
                [self gotoSekillGoodsInfo:dict];
                
            }else if([dict[@"code"]integerValue]==103){
                [self showMsg:@"超出限购了\n你不能买这么多啊亲"];
                self.bugWarring=@"超出限购了\n你不能买这么多啊亲";
            }else if([dict[@"code"]integerValue]==100){
                [self showMsg:@"已抢光"];
                self.bugWarring=@"已抢光";
            }else if([dict[@"code"]integerValue]==96){
                [self showMsg:@"活动未开始"];
                self.bugWarring=@"活动未开始";
            }
        }
            break;
        default:
            break;
    }
    
}
-(void)GCRequest:(GCRequest *)aRequest Error:(NSString *)aError
{
    [self stopActivity];
    [self showMsg:@"请求失败，请检查网路设置"];
}


/** 提交订单 秒杀商品 并跳转到提交订单详情页 */
- (void)gotoSekillGoodsInfo:(NSDictionary*)dict
{
    self.ms_sign= [dict objectForKey:@"ms_sign"];
    NSString * pay_time=[dict objectForKey:@"pay_time"];
    NSString * my_sign=[dict objectForKey:@"my_sign"];
    [self showMsg:[NSString stringWithFormat:@"抢购成功，请在%@分钟内付款",pay_time]];
    LSYConfirmOrderViewController * con=[[LSYConfirmOrderViewController alloc]init];
    //    ConfirmOrderViewController *con = [[ConfirmOrderViewController alloc] init];
    con.isSeckilling=YES;
    con.my_sign=my_sign;
    con.goods=self.goods;
    con.ms_sign=self.ms_sign;
    //将最后确定的模型传入
    con.attributeGoodsNums = _addView.numLabel.text;
    con.attributeModel = _lastModel;
    
    [self.navigationController pushViewController:con animated:YES];
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"---- %f",_addView.frame.origin.y);
}


@end
