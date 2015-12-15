//
//  CrazyShoppingCartListCellView.m
//  MarketManage
//
//  Created by fielx on 15/4/15.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "CrazyShoppingCartListCellView.h"
#import "jsonMyModel.h"
#define IMAGE_FRAME CGRectMake(42,17, 80, 80)

#define BUTTON_FRAME CGSizeMake(18, 18)
//

@implementation CrazyShoppingCartListCellView

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.backgroundColor = [UIColor whiteColor];
        self.mImageView.frame = IMAGE_FRAME;
        
        self.editView = [[UIView alloc] initWithFrame:CGRectMake(130, 50+37, 180, 50)];
        [self.mBgView addSubview:self.editView];
//        self.editView.backgroundColor = [UIColor purpleColor];
//        self.editView.hidden = YES;
        self.mPrice = [[CrazyBasisLabel alloc]init];
        [self.editView addSubview:self.mPrice];
        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(myDelegate:) name:@"CrazyShoppingCartFootViewTypeDelete" object:nil];
        
        self.mSelectButton.frame = (CGRect){DISTANCEX,0,BUTTON_FRAME};
        [self.mSelectButton crazyButtonSetNormalImage:@"crazy_mall_pay-for_norma" selectImage:@"crazy_mall_pay-for_selected"];
        [self.mSelectButton crazyButtonSizeExpand:3];
        
        //设置居中
        [CrazyBasisFrameTool CrazyBasisFrameToolCenter:CrazyBasisFrameToolRelativePositionVerticalCenter mainView:self.mImageView moveView:self.mSelectButton];
        
        
        self.mNameLabel.frame = CGRectMake(CGRectGetMaxX(self.mImageView.frame) + INTERVAL, IMAGE_FRAME.origin.y, SCREENWIDTH - CGRectGetMaxX(self.mImageView.frame) - INTERVAL - DISTANCEX, 40);
        self.mNameLabel.verticalCrazyAlignment = 0;
        
        
        CrazyPurchaseQuantityView *qView = [[CrazyPurchaseQuantityView alloc]initWithImage:[UIImage imageNamed:@"crazy_mall_order_number_btn"]];
        qView.frame = CGRectMake(0, 25, 0, 0);
        self.mQuantityView = qView;
        [self.editView addSubview:qView];

        self.editView.frame = CGRectMake(130, 50+37, 180, 50);
//        self.mPrice.frame = CGRectMake(CGRectGetMinX(self.mNameLabel.frame), CGRectGetMinY(qView.frame) - INTERVAL - 18,CGRectGetWidth(self.mNameLabel.frame) , 20);
        self.mPrice.frame = CGRectMake(5, 0, 100, 20);
        self.mPrice.verticalCrazyAlignment = VerticalCrazyAlignmentBottom;

        self.mBgView.frame = (CGRect){0,0,CELLSIZE};
        
        self.mBgView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        
//        self.mRestrictionmLabel = [CrazyBasisLabel labelAddInController:self andTitle:@"" andFrame:CGRectMake(13, CGRectGetMaxY(qView.frame) + 8 , CGRectGetWidth(self.mImageView.frame)  + 20, 20) andTextAlignment:NSTextAlignmentCenter andTextColor:C1 andRow:1 andFont:12 andBackGroundColor:nil andCorner:NO];
        
        self.mImageView.layer.masksToBounds = YES;
        self.mImageView.layer.borderWidth = 1;
        self.mImageView.layer.borderColor = CrazyColor(230, 230, 230).CGColor;

        
        /** 添加可编辑的视图 */
        
//        WithFrame:CGRectMake(130, 50, 180, 50)
        self.showView = [[UIView alloc] initWithFrame:CGRectMake(130, 50+37, 180, 50)];
        [self.mBgView addSubview:self.showView];
  
        self.colorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 20)];
        self.colorLabel.text = @"颜色：黄色";
        [self.showView addSubview:self.colorLabel];
        
        self.nowLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 80, 20)];
        [self.showView  addSubview:self.nowLabel];
        self.nowLabel.text = @"29.9";
        self.agoLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 30, 80, 20)];
        [self.showView addSubview:self.agoLabel];
        self.agoLabel.text = @"78.8";
        self.showView .hidden = YES;
        //        self.showView.hidden = YES;
       
    }
    return self;
    
}

-(void)tapSelectButton:(CrazyBasisButton *)button
{
//    if (!self.mModel.mIsPurchase) {
//        return;
//    }
    
    [super tapSelectButton:button];
    
    
    
    self.mModel.mIsSelect = button.selected;
    
    if ([self.delegate respondsToSelector:@selector(crazyShoppingCartListCellView:isSelect:)]) {
        [self.delegate crazyShoppingCartListCellView:self isSelect:button.selected];
    }
}

/** 赋值 */
-(void)crazyBasisCellContent:(id)info
{
    
    NSLog(@"%@",info);
    
//    ListModel *model  = (ListModel *)info;
    
//    NSLog(@"%@",model.goods_name);
//    self.mNameLabel.text = model.goods_name;
        CrazyShoppingCartShopCommodityModel *model = (CrazyShoppingCartShopCommodityModel *)info;
    self.mModel = model;
//
//    self.mQuantityView.delegate = self;
//    
//    self.mSelectButton.selected = model.mIsSelect;
//    
//    [self.mImageView crazyBasisImageViewLoadHostUrlString:model.mImageUrl placeholderImageString:@"defaultimg_11"];
//    
//    self.mNameLabel.text = model.mName;
//    
//    self.mPrice.text = model.mShowPrice;
//    
    self.mQuantityView.mMaxNumber = model.mMaxNumber;
    self.mQuantityView.mCurrentNumber = model.mNumber;
    self.mQuantityView.mAvailable = model.mAvailable;
    
    NSLog(@"%d",model.mAvailable);
    self.mQuantityView.mMaxRestrictionmNumber = [model.mRestrictionmNumber integerValue];
    
//    self.mRestrictionmLabel.hidden = ![model.mRestrictionmNumber integerValue];
//    self.mRestrictionmLabel.text = [NSString stringWithFormat:@"限购%@件",model.mRestrictionmNumber];
}

/** 刷新隐藏显示 */
-(void)setIsShowOrEdit:(BOOL)isShowOrEdit{
    
    if (!isShowOrEdit) {
        self.editView.hidden = YES;
        self.showView.hidden = NO;
    }else
    {
        self.editView.hidden = NO;
        self.showView.hidden = YES;
    }
}
/** 是否上移 */
-(void)setIfUpMove:(BOOL)ifUpMove{
    if (!ifUpMove) {
        
        self.sectionView.frame =CGRectMake(0, 0, SCREENWIDTH, 37);
    }else
    {
        self.sectionView.frame  = CGRectMake(0, 0, 0, 0);
        
    }
}
#pragma mark 数量视图代理
-(void)crazyPurchaseQuantityView:(CrazyPurchaseQuantityView *)qView currentNumber:(int)currentNumber
{
    //发送通知 访问服务器改变数量
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CrazyShoppingCartListCellViewChangeGoodsNumber" object:self];
    
}

//请求数据完成后刷新
-(void)CrazyShoppingCartListCellViewReload
{
    [self.mQuantityView CrazyPurchaseQuantityViewReload];
    self.mModel.mNumber = self.mQuantityView.mCurrentNumber;
    
    //代理 刷新小计
    if ([self.delegate respondsToSelector:@selector(crazyShoppingCartListCellViewchangeNumber:)]) {
        [self.delegate crazyShoppingCartListCellViewchangeNumber:self];
    }
}

//-(void)myDelegate:(NSNotification *)no
//{
//    NSDictionary *dic = [no userInfo];
//    if (![dic[@"delete"] boolValue]) {
//        if (!self.mModel.mIsOriginally) {
//              self.mSelectButton.selected = self.mModel.mIsOriginally;
//        }
//    }
//}


@end
