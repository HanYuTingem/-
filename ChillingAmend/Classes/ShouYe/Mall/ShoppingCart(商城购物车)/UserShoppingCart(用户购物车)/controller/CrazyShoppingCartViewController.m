//
//  CrazyShoppingCartViewController.m
//  MarketManage
//
//  Created by fielx on 15/4/14.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "CrazyShoppingCartViewController.h"

#import "GCRequest.h"

#import "CrazyShoppingCartViewFile.h"

#import "CrazyShoppingCartListCellView.h"

#import "CrazyShoppingCartListNoDataView.h"

@implementation CrazyShoppingCartViewController
{
    BOOL _ifEdit;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"CrazyShoppingCartListCellChangeShowPrice" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self.tableView name:@"CrazyShoppingCartFootViewTotalSelect" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CrazyShoppingCartListCellWithSlelct" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CrazyShoppingCartListCellViewChangeGoodsNumber" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"PurchaseQuantityViewNotification" object:nil];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"GoodsInfoViewControllerReloadData" object:nil];

}
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        _ifEdit = NO;
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //全选 与 取消
    [[NSNotificationCenter defaultCenter]addObserver:self.tableView selector:@selector(reloadData) name:@"CrazyShoppingCartFootViewTotalSelect" object:nil];
    
    //改变总价
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeShowTotalPrice) name:@"CrazyShoppingCartListCellChangeShowPrice" object:nil];
    
    //是否全选
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(whetherTotalSelect) name:@"CrazyShoppingCartListCellWithSlelct" object:nil];
    
    //商品数量改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeGoodsNumber:) name:@"CrazyShoppingCartListCellViewChangeGoodsNumber" object:nil];
    
    //超出库存
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moreBigNumber:) name:@"PurchaseQuantityViewNotification" object:nil];
    
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CrazyShoppingCartViewControllerReloadData" object:nil];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
        
    [self.rightButton setTitle:@"修改" forState:UIControlStateNormal];
    [self.rightButton setTitle:@"完成" forState:UIControlStateSelected];
    self.mallTitleLabel.text = @"购物车";
    self.tableView.frame =CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64 - 60);
    self.mNoDataView = [[CrazyShoppingCartListNoDataView alloc]initWithFrame:self.tableView.frame imageString:@"mall_content_icon"];
    [self sendRequset];
    
    //操作完成 刷新数据
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendRequset) name:@"CrazyShoppingCartViewControllerReloadData" object:nil];
}


-(void)sendRequset
{
    NSString *url = [NSString stringWithFormat:@"por=%d&user_id=%@",110,kkUserCenterId];
    
    
    [CrazyBasisRequset requestGetInClass:self andWithUrlString:url Completion:^(NSDictionary *dic) {
        
        NSLog(@"%@",dic);
        
        NSLog(@"%@",url);
        [CrazyBasisImageView CrazySetUrlHost:dic[@"host"]];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self.mInfoArray removeAllObjects];
            NSArray *jsonArr = dic[@"json"];
            NSLog(@"%@",jsonArr);
            
            for(NSDictionary *dic in jsonArr){
                jsonMyModel *model = [[jsonMyModel alloc] initWithDictionary:dic error:nil];
                
                [self.mInfoArray addObject:model];
                NSLog(@"%@",model.shop_name);
                
                NSLog(@"%@",((ListModel *)model.list[0]).goods_name);
                
            }
            
            jsonMyModel *model =self.mInfoArray[0];
            NSLog(@"%ld",model.list.count);
            
            NSLog(@"%ld",self.mInfoArray.count);
            
            UITableView *table = (UITableView *)[self.view viewWithTag:6666];
            [table reloadData];

//            [feedDicts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//                CrazyShoppingCartShopModel *model = [[CrazyShoppingCartShopModel alloc] initWithDic:obj];
//                if (model.mArray.count && model.mArray.count > 0) {
//                    [self.mInfoArray addObject:model];
//                   
//                }
//            }];
             NSLog(@"%@",self.mInfoArray);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.rightButton.hidden =  !self.mInfoArray.count;
                [self.tableView reloadData];
                [self buildFootView];
                if (self.rightButton.selected) {
                    [self rightBackCliked:self.rightButton];
                }
                [self showNoDataView];
            });
        });
    } Failed:^(NSError *error) {
        
    }];
}

#pragma mark 跳转订单 与删除
-(void)crazyShoppingCartFootView:(CrazyShoppingCartFootView *)footView didSelectClearButton:(CrazyBasisButton *)button
{
    NSMutableArray *array = [self getSelectModelArray];
    if (!array.count) {
        [self showMsg:@"请至少选择一件商品"];
        return;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pushInfoViewController" object:nil userInfo:@{@"type":@"1",@"info":array,@"total":self.mFootView.mShowPriceLabel.text}];
}

#pragma mark 获取选中模型数组
-(NSMutableArray *)getSelectModelArray
{
    
    NSLog(@"%@",self.mInfoArray);
    NSLog(@"%ld",self.mInfoArray.count);
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
    for (CrazyShoppingCartShopModel *model in self.mInfoArray) {
        NSLog(@"%ld",model.mSelectArray.count);
        if (model.mSelectArray.count) {
            [array addObject:model];
        }
    }
    NSLog(@"%@",array);
    return array;
}

-(void)crazyShoppingCartFootView:(CrazyShoppingCartFootView *)footView didSelectDeleteButton:(CrazyBasisButton *)button
{
    //商品Id  格式为 ID,ID,ID,
    NSMutableString *goodsId = [NSMutableString stringWithCapacity:10];
    NSMutableArray *array = [self getSelectModelArray];
    for (CrazyShoppingCartShopModel *model in array) {
        for (CrazyShoppingCartShopCommodityModel *subModel in model.mSelectArray) {
            [goodsId appendString:[NSString stringWithFormat:@"%@,",subModel.mId]];
        }
    }
    NSLog(@"要删除的商品ID为%@",goodsId);
    if ([goodsId length] == 0) {
        [self showMsg:@"请选择要删除的商品"];
        return;
    }
    //提示框
    [CrazyBasisAlertView CrazyBasisAlertViewShowTitle:@"" content:@"确定要删除选中商品吗?" buttonTextArray:@[@"确定",@"取消"] leftSelectBlock:^(CrazyBasisButton *confirmButton) {
        //请求删除
        [CrazyShoppingAddorRemoveModel crazyShoppingAddorRemoveModelType:CrazyShoppingAddorRemoveModelTypeRemove loadController:self goodsId:goodsId completeBlock:^(NSDictionary * infoDic) {
            if ([infoDic[@"code"] integerValue] == 0) {
                //排除模型 刷新列表
                [self sendRequset];
            }
            else {
                [self showMsg:@"删除失败,请重新尝试"];
            }
        }];
    } rigthSelectBlock:^(CrazyBasisButton *cancelBlock) {
        
    }];

}

#pragma mark table代理
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CrazyShoppingCartShopModel *model = self.mInfoArray[indexPath.row];
    return model.mCellHeight;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *iden = @"myCell";
//    static NSString *iden = @"cell";
    
    CrazyShoppingCartListCellView *shopCarCell = [tableView dequeueReusableCellWithIdentifier:iden];
    if(!shopCarCell ){
        shopCarCell = [[CrazyShoppingCartListCellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }
//     [shopCarCell refreshUI:_ifEdit];
    return shopCarCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
#pragma mark 创建底部视图
-(void)buildFootView
{
    [self.mFootView removeFromSuperview];
    self.mFootView = [[CrazyShoppingCartFootView alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT - CONTROLLER_FOOT_VIEW_HEIGHT, SCREENWIDTH, CONTROLLER_FOOT_VIEW_HEIGHT)];
    self.mFootView.delegate = self;
    if (self.mInfoArray.count) {
        [self.view addSubview:self.mFootView];
    }
}

#pragma mark 接受通知 改变总价
-(void)changeShowTotalPrice
{
    float price = 0;
    float integral = 0;
    int  number = 0;
    for (CrazyShoppingCartShopModel *model in self.mInfoArray) {
        price += model.mTotalPrice;
        integral += model.mTotalIntegral;
        number += model.mSelectArray.count;
    }
    NSString *string = [CrazyShoppingCartShopTool CrazyShoppingCartShopToolShowPriceWithPrice:[NSString stringWithFormat:@"%f",price] integral:[NSString stringWithFormat:@"%f",integral] number:1];
    if ([string length] == 0) {
        string = @"￥0";
    }
    self.mFootView.mNumger = number;
    self.mFootView.mShowPriceLabel.text = string;
}

#pragma mark 是否全选
-(void)whetherTotalSelect
{
    //全部选择
    BOOL totalSelect = YES;
    
    for (CrazyShoppingCartShopModel *model in self.mInfoArray) {
        
        NSLog(@"%ld",model.mArray.count);
        NSLog(@"%ld",model.mSelectArray.count);
        if (model.mArray.count != model.mSelectArray.count) {
            totalSelect = NO;
        }
    }
    self.mFootView.mSelectButton.selected = totalSelect;

//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        //全部选择
//        BOOL totalSelect = YES;
//        for (CrazyShoppingCartShopModel *model in self.mInfoArray) {
//            
//            int noSelect = 0;
//            for (CrazyShoppingCartShopCommodityModel *minModel in model.mArray) {
//                if (minModel.mIsPurchase == NO) {
//                    noSelect ++;
//                }
//            }
//            
//            if (noSelect + model.mSelectArray.count != model.mArray.count) {
//                totalSelect = NO;
//            }
//        }
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.mFootView.mSelectButton.selected = totalSelect;
//
//        });
//    });
    
}

- (void)rightBackCliked:(UIButton*)sender
{
    if (!self.mInfoArray.count) {
        sender.selected = NO;
        return;
    }
    sender.selected = !sender.selected;
    self.mFootView.mState = sender.selected;
    
    NSLog(@"%u",sender.selected);
    _ifEdit = sender.selected;

    UITableView *table = (UITableView *)[self.view viewWithTag:6666];
    [table reloadData];
    
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"CrazyShoppingCartFootViewTypeDelete" object:nil userInfo:@{@"delete":[NSNumber numberWithBool:sender.selected]}];
//    [self whetherTotalSelect];

}

#pragma mark 改变商品数量
-(void)changeGoodsNumber:(NSNotification *)no
{
    
    
    NSLog(@"%@",no);
    CrazyShoppingCartListCellView *cell = [no object];
    NSLog(@"%d",cell.mQuantityView.mType);
    NSLog(@"%@",cell);
    NSLog(@"%@",cell.mQuantityView);
    NSString *url = [NSString stringWithFormat:@"por=%d&user_id=%@&goods_id=%@&num=%d",112,kkUserCenterId,cell.mModel.mId,cell.mQuantityView.mCurrentNumber +cell.mQuantityView.mType];
    [CrazyBasisRequset requestGetInClass:self andWithUrlString:url Completion:^(NSDictionary *dic) {
        NSLog(@"%@",dic);
        //请求成功 添加显示
        if ([dic[@"code"] integerValue] == 0) {
            [cell CrazyShoppingCartListCellViewReload];
        }
        else {
            [self showMsg:LOAD_FAILURE];
        }
    } Failed:^(NSError *error) {
        
    }];
}

#pragma mark 超过最大库存
-(void)moreBigNumber:(NSNotification *)no
{
    int restrictionm = [[no object][@"restrictionm"] integerValue];
    int avaulable = [[no object][@"avaulable"] integerValue];
    
    NSLog(@"%@",[no object][@"restrictionm"]);
    //判断限限购或者库存
    if (restrictionm) {
        if (restrictionm - avaulable > 0) {
            [self showMsg:[NSString stringWithFormat:@"宝贝限购%d件，您已购买%d件",restrictionm,restrictionm - avaulable]];
            return;
        }
        [self showMsg:[NSString stringWithFormat:@"限购%d件",restrictionm]];
        return;
    }
    [self showMsg:@"超出库存上限了亲"];
}
@end
