//
//  CrazyShoppingCartListCell.m
//  MarketManage
//
//  Created by fielx on 15/4/15.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "CrazyShoppingCartListCell.h"
#import "CrazyBasisCell.h"
#define CELL_FOOT_VIEW_DISTANCE_X 40

@implementation CrazyShoppingCartListCell
{
    CrazyShoppingCartListCellView *viewList;
    CrazyBasisCell *basisCell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.mPrice.textColor = C1;
//        self.showView.hidden = YES;
        //全选 与 取消
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadShowPrice) name:@"CrazyShoppingCartFootViewTotalSelect" object:nil];
        self.mPrice.text = @"小计:￥0";
        if (!namedic) {
            namedic = [[NSMutableDictionary alloc]init];
        }
        [self.mBgView cornerRadius:0 lineColor:CrazyColor(230, 230, 230) borderWidth:1];
    }
    return self;
    
}

#pragma mark 全选改变商品小计
-(void)totalSelect:(NSNotification *)no
{
    
    NSLog(@"%@",no);
    BOOL select = [[no userInfo][@"select"] boolValue];
    
    NSLog(@"%@",self.mModel.mArray);
    
    if (select == YES) {
        self.mModel.mSelectArray = [self.mModel.mArray mutableCopy];
    }
    else
    {
       [self.mModel.mSelectArray removeAllObjects];
    }
    [self reloadShowPrice];
    
}


-(void)crazyBasisCellContent:(id)info
{
    [self removeSubView];
    
    CrazyShoppingCartShopModel *model = (CrazyShoppingCartShopModel *)info;
    self.mModel = model;
    for (int i = 0; i < model.mArray.count; i ++) {
        CrazyShoppingCartShopCommodityModel *subModel = model.mArray[i];
        if (![namedic objectForKey:[NSString stringWithFormat:@"viewList%d",i]]) {
            viewList = [[CrazyShoppingCartListCellView alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mycell"];
            [namedic setValue:viewList forKey:[NSString stringWithFormat:@"viewList%d",i]];
            
        }else{
            viewList = (CrazyShoppingCartListCellView *)[namedic objectForKey:[NSString stringWithFormat:@"viewList%d",i]];
        }
        viewList.delegate = self;
        NSLog(@"%u",_ifShowOrEdit);
        viewList.isShowOrEdit = _ifShowOrEdit;

        [viewList crazyBasisCellContent:subModel];
        [self.mBgView addSubview:viewList];
        CGSize size;
        if ([subModel.mRestrictionmNumber length]) {
            size = CELL_BIG_SIZE;
        }
        else {
            size = CELLSIZE;
        }
        
        viewList.frame = (CGRect){0,[self viewOriginWithNumber:i],size};
        if (i>=1) {
//            viewList.sectionView.hidden = YES;
//            viewList.sectionView.frame = CGRectMake(0, 0, SCREENWIDTH, 37);
            viewList.ifUpMove = YES;
        }

    }
    

    //分割线
    self.mLineImageView.frame = CGRectMake(CELL_FOOT_VIEW_DISTANCE_X, model.mCellHeight - CELL_COLOR_INTERVAR - CELL_FOOT_VIEW_HEIGHT, SCREENWIDTH - CELL_FOOT_VIEW_DISTANCE_X, 1);
    [self.mBgView addSubview:self.mLineImageView];
    
    
    //小计
//    [self.mBgView addSubview:self.mPrice];
    [self reloadShowPrice];
//    self.mPrice.frame = CGRectMake(CELL_FOOT_VIEW_DISTANCE_X, CGRectGetMaxY(self.mLineImageView.frame), SCREENWIDTH - CELL_FOOT_VIEW_DISTANCE_X, CELL_FOOT_VIEW_HEIGHT);

    self.mBgView.frame = CGRectMake(0, 0,SCREENWIDTH,model.mCellHeight - CELL_COLOR_INTERVAR);
}
-(int)viewOriginWithNumber:(int)number
{
    int intervar = 0;
    for (int i = 0; i < number; i ++) {
        CrazyShoppingCartShopCommodityModel *model = self.mModel.mArray[i];
        if ([model.mRestrictionmNumber integerValue]) {
            intervar += 20;
        }   
    }
    return number*CELLSIZE.height - number*CELL_INTERVAR_VIEW + intervar;
}


-(void)removeSubView
{
    for (UIView *view in self.mBgView.subviews) {
        [view removeFromSuperview];
    }
}


/**
 *  拿到重用的cell
 */
-(CrazyShoppingCartListCellView *)getSubViewWithTag:(int)tag
{
    
    
    NSLog(@"%d",tag);
    if ([self viewWithTag:tag]) {
        return (CrazyShoppingCartListCellView *)[self viewWithTag:tag];
    }
    else {
        CrazyShoppingCartListCellView *view = [[CrazyShoppingCartListCellView alloc]init];
        view.tag = tag;
        return view;
    }
}


#pragma mark cell代理
-(void)crazyShoppingCartListCellView:(CrazyShoppingCartListCellView *)view isSelect:(BOOL)isSelect
{

    NSLog(@"%u",isSelect);
    NSLog(@"%@",view.mModel);

    NSLog(@"%@",self.mModel.mSelectArray);
    if (isSelect) {
        [self.mModel.mSelectArray addObject:view.mModel];
        view.backgroundColor = [UIColor redColor];
        
    }
    else {
        [self.mModel.mSelectArray removeObject:view.mModel];
        view.backgroundColor = [UIColor cyanColor];

    }
    [self reloadShowPrice];
    
    
    NSLog(@"%@",self.mModel.mSelectArray);
    // 按钮选中或取消选中  判断是否全选
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CrazyShoppingCartListCellWithSlelct" object:nil];
}

-(void)crazyShoppingCartListCellViewchangeNumber:(CrazyShoppingCartListCellView *)view
{
    [self reloadShowPrice];
}

#pragma mark 刷新小计
-(void)reloadShowPrice
{
    if ([self.mModel.mSelectArray count]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSString *str = self.mModel.mShowPrice;
            NSLog(@"%@",str);
            dispatch_async(dispatch_get_main_queue(), ^{
                 self.mPrice.text = str;
                [self sendNotificationChangeAllPrice];
            });
        });
    }
    else {
        self.mPrice.text = @"小计:￥0";
        self.mModel.mTotalIntegral = 0;
        self.mModel.mTotalPrice = 0;
        [self sendNotificationChangeAllPrice];
    }
}
#pragma mark 改变总价
-(void)sendNotificationChangeAllPrice
{
    [[NSNotificationCenter defaultCenter] postNotificationName:CrazyShoppingCartListCellChangeShowPrice object:nil];

}

@end
