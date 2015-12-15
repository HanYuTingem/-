//
//  LSYConfirmOrderViewController.m
//  MarketManage
//
//  Created by liangsiyuan on 15/1/19.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "LSYConfirmOrderViewController.h"
#import "CrazyShoppingCartShopModel.h"
#import "CrazyShoppingCartShopCommodityModel.h"
#import "LYQCommodityListViewController.h"
#import "BSaveMessage.h"
#import "JSON.h"
#import "MyUILabel.h"
#import "DHConfirmOrderCell.h"
@interface LSYConfirmOrderViewController ()<UITableViewDataSource,UITableViewDelegate,LSYRealGoodsTableViewCellDelegate,LSYUserAdressTableViewCellDelegate,SelectAddDelegate,InvoiceMessageDelegate,LSYVirtualGoodsTableViewCellDelegate,UITextViewDelegate,UIAlertViewDelegate,UIGestureRecognizerDelegate,ShopingCartTableViewCellDelegate>


/** 获取默认地址/运费的模型*/
@property (nonatomic,strong) ZXYCommitOrderRequestModel *commitModel;
/** 发票的模型 */
@property (nonatomic,strong) ZXYInvoiceModel            *invoiceModel;
/** 商品清单 */
@property (nonatomic,strong) NSMutableArray             * freightListArray;
/** 是否正在加载运费的操作 */
@property (nonatomic,assign) BOOL                       loadingFeight;
/** 表格 */
@property (weak, nonatomic) IBOutlet UITableView        *tableView;
/** 合计价格*/
@property (weak, nonatomic) IBOutlet MyUILabel          *subPriceLabel;
/** 合计价格的宽度 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *subPriceLabelW;

/** 提交按钮*/
@property (weak, nonatomic) IBOutlet UIButton           *submitBtn;
/** 请求 */
@property (strong,nonatomic) ASIFormDataRequest         * request;
/** 不退换的商品提示 */
@property (strong, nonatomic) IBOutlet UILabel          *buyMessLabel;
/** 本业的商品的价格 */
@property (nonatomic, assign) float goodsCash;
/**  提交订单按钮 */
@property (weak, nonatomic) IBOutlet UIButton *gotoPayBtn;

@end

@implementation LSYConfirmOrderViewController

#pragma mark - LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self initRequetParam];
    [self addAGesutreRecognizerForYourView];
    [self getUserDefaultAddress];

    NSLog(@"%ld",(unsigned long)self.shopCountArr.count);
    NSLog(@"%@",self.shopCountArr);
    NSLog(@"%@",self.shoppingCartArray);
    self.gotoPayBtn.backgroundColor = [UIColor colorWithRed:0.72f green:0.02f blue:0.02f alpha:1.00f];
    
    for(NSDictionary *listModel in self.shopCountArr){
        NSLog(@"%@",listModel);
        NSString *listModelHead = listModel[@"listModel"];
        NSString *shopName = listModel[@"shop_name"];
        NSArray *listArr = ( NSArray *)listModelHead;
        NSLog(@"%@",shopName);
        NSLog(@"%@",listArr);
        
//        
//        NSString *list = [listModelHead substringFromIndex:1];
//        NSMutableArray *arr = (NSMutableArray *)list;
//        NSString *idenHeadStr = [listModelHead substringWithRange:NSMakeRange(0, 1)];
//        NSLog(@"%@",idenHeadStr);
    }
}
//添加点击事件
- (void)addAGesutreRecognizerForYourView
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesturedDetected:)]; // 手势类型随你喜欢。
    tapGesture.delegate = self;
    [self.view addGestureRecognizer:tapGesture];
}
//方法
- (void) tapGesturedDetected:(UITapGestureRecognizer *)recognizer

{
    [[[[UIApplication sharedApplication]delegate]window] endEditing:YES];
    // do something
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"resignFirstResponder" object:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Init
/**
 初始化请求参数 防止空值崩溃
 */
-(void)initRequetParam
{

    self.tableView.delegate = self;

    self.tableView.dataSource = self;
    self.buyMessLabel.frame = CGRectMake(10*SP_WIDTH,self.view.frame.size.height- 150, 300*SP_WIDTH, 21);
    self.buyMessLabel.text = [NSString stringWithFormat:@"*%@购买的商品，不支持退款",INTERGRAL_NAME],
    [self.tableView addSubview:self.buyMessLabel];
    
    _commitModel = [ZXYCommitOrderRequestModel shareInstance];
    [_commitModel setobject:NULL];
    
    
    //判断是否是从商品属性界面传过来的数据
    if (self.attributeModel.spec_idArray.count != 0) {
        _commitModel.goods_nums = self.attributeGoodsNums;
        self.goodsCash = [self.attributeModel.cash floatValue];
    } else {
        self.goodsCash = _goods.cash;
    }
    [self updateAmountPrice];
}

/**
 初始化数据
 */
-(void)initData
{
    self.mallTitleLabel.text = @"确认订单";
    _invoiceModel        = [ZXYInvoiceModel shareInstance];
    _loadingFeight       = NO;
    _freightListArray    = [[NSMutableArray alloc]init];
//    self.subPriceLabel.verticalAlignment = VerticalAlignmentTop;
    self.subPriceLabel.verticalAlignment = VerticalAlignmentMiddle;
    
    self.subPriceLabel.text=[MarketAPI judgeCostTypeWithCash:[NSString stringWithFormat:@"%.2f",self.goodsCash] andIntegral:[NSString stringWithFormat:@"%.0f",_goods.price]  withfreight:@"0"  withWrap:YES];
    self.subPriceLabelW.constant = [MarketAPI labelAutoCalculateRectWith:self.subPriceLabel.text FontSize:14 MaxSize:CGSizeMake(SCREENWIDTH - 121 - 45, 48)].width;
    //判断是否从购物车过来的 商品的总价格
    if(self.shoppingCartArray &&self.shoppingCartArray.count!=0){
        self.subPriceLabel.text = _buyShopingPriceCount;
        self.subPriceLabelW.constant = [MarketAPI labelAutoCalculateRectWith:_buyShopingPriceCount FontSize:14 MaxSize:CGSizeMake(SCREENWIDTH - 121 - 45, 48)].width;
    }
    [self.tableView registerNib:[UINib nibWithNibName:@"LSYVirtualGoodsTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LSYRealGoodsTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell2"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LSYUserAdressTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell3"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LYSShopingCartTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell4"];

    self.tableView.tableFooterView = [[UIView alloc] init];
}



/*
 导航条返回方法
 秒杀时离开提交订单页面 - 提示是否取消订单
 */

- (void)leftBackCliked:(UIButton *)sender
{
    if (self.isSeckilling) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确认取消该订单?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }else{
        [_invoiceModel setInvoiceType];
        [self.navigationController popViewControllerAnimated: YES];
    }

}
/*
 离开提交订单页面 选择取消订单 - 重置发票信息
 */
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [_invoiceModel setInvoiceType];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark -TablewViewDelegate
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return self.shopCountArr.count;
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

//    NSString *iden = [NSString stringWithFormat:@"%ld%ld",indexPath.section,indexPath.row];
//    DHConfirmOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
//    if (cell == nil) {
//        cell = [[DHConfirmOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
//        
//        
//    }
//
//    NSDictionary *dic = self.shopCountArr[indexPath.section];
//    
//    NSArray *listModel = dic[@"listModel"];
//    ListModel *model = listModel[indexPath.row];
//    [cell refreshUI:model];
//    return cell;
    
    
        switch (indexPath.row) {
            case ConfirmRowNone:
            {
                LSYUserAdressTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"Cell3"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell setUserAddress];
                cell.delegate=self;
                return cell;
            }
                break;
            case ConfirmRowOne:
            {
                if(self.shoppingCartArray &&self.shoppingCartArray.count!=0){

                    LYSShopingCartTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell4"];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.delegate= self;
                    cell.goodsArray = self.shoppingCartArray;
                    return cell;
                    
                }else{
                    LSYVirtualGoodsTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"Cell"];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    //是否秒杀
                    cell.isSeckilling = [NSString stringWithFormat:@"%d",(int)self.isSeckilling];
                    cell.isHaveAdd = @"1";
                    //如果快递判断是否有地址
                    if ([_commitModel.address isEqualToString:@""]) {
                        cell.isHaveAdd = @"0";
                    }
                    self.goods.goods_cashNew = [self.attributeModel.cash floatValue];
                      cell.goods=self.goods;
                    cell.count = (int)[_commitModel.goods_nums integerValue];
                    cell.delegate=self;
                    
                    //判断是否有商品属性 有商品属性隐藏加减计数器
                    if (self.attributeModel) {
                        //隐藏加减计数器
                        CGRect frame = cell.frame;
                        frame.size.height = 89;
                        cell.frame = frame;
                        cell.clipsToBounds = YES;
                        cell.numLabel.hidden = YES;
                        cell.buyNumNameLabel.hidden = YES;
                        cell.subtractionBtn.hidden = YES;
                        cell.addBtn.hidden = YES;
                        cell.goodsNumImage.hidden = YES;
                    }
                    
                    
                    
                    return cell;
                }
                
            }
                break;
            case ConfirmRowTwo:
            {
                LSYRealGoodsTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"Cell2"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.delegate=self;
                cell.freight.text = _loadingFeight ?[self showFreight]:@"";
                //若不开发票显示不开发票 若开发票显示发票抬头
                if ([_commitModel.invoice_category isEqual:@"不开发票"]) {
                    cell.faPiaoInfo.text = _commitModel.invoice_category;
                }else{
                    cell.faPiaoInfo.text = _commitModel.invoice_title;
                }
                cell.noteTextView.delegate  = self;
                return cell;
            }
                break;
            default:
            {
                LSYRealGoodsTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"Cell2"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
                break;
        }
    

   return nil;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell =
    [self tableView:tableView cellForRowAtIndexPath:indexPath];
    float height=cell.frame.size.height;
    [cell removeFromSuperview];
    return height;
}

#pragma mark - 点击scrollview的手势的回调 商品清单

- (void)didSelectGoodsScrollView
{
    LYQCommodityListViewController * commodityControl = [[LYQCommodityListViewController alloc]initWithNibName:@"LYQCommodityListViewController" bundle:nil];
    commodityControl.goodsPayDataArray = _freightListArray;
    commodityControl.shopCarToOrderArrar = self.shoppingCartArray;
    [self.navigationController pushViewController:commodityControl animated:YES];
    
    
}
/** 商品清单*/
- (void)didSecectGoodsContentView
{
    self.goods.countPrice = self.subPriceLabel.text;
    LYQCommodityListViewController * commodityControl = [[LYQCommodityListViewController alloc]initWithNibName:@"LYQCommodityListViewController" bundle:nil];
    commodityControl.goodsPayDataArray = _freightListArray;
    [self.navigationController pushViewController:commodityControl animated:YES];

}
#pragma mark - 支付
/**
 判断条件 符合发送提交订单请求
 */
- (IBAction)gotoPay:(id)sender
{
    if (self.goods.nums>0 &&[_commitModel.goods_nums integerValue] > self.goods.nums &&!self.shoppingCartArray) {
        [self showMsg:@"库存不足啦~亲"];
    }else if ( [_commitModel.address isEqualToString:@""]) {
        [self showMsg:@"还没有收货地址呢亲~\n先添加一个吧"];
    }else{
        [self commitOrder];
    }
}

#pragma mark - 传值代理
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
        [self showMsg:@"还没有收货地址呢亲~\n先添加一个吧"];
        return;
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
        _commitModel.goods_nums = [NSString stringWithFormat:@"%d",count];
        [self updateAmountPrice];
        [self getFreight];
    }
}


/**
 发票信息传值
 为请求参数赋值
 */
-(void)getInvoiceMsgModel:(ZXYInvoiceModel *)model
{
    _commitModel.invoice_type     = model.invoiceType;
    _commitModel.invoice_category = model.invoiceContent;
    _commitModel.invoice_title    = model.invoiceTitle;
    [self.tableView reloadData];
}

/**
 收货地址改变
 保存收货地址
 为请求参数赋值
 */
-(void)selectAddDic:(NSMutableDictionary *)dict
{
    [_commitModel setobject:dict];
    [self.tableView reloadData];
    [self getFreight];

}
/** 默认地址 */
-(void)getUserDefaultAddress
{
    [self startActivity];
    self.request = [MarketAPI requestMorenAddress5004WithController:self];
}
/** 获取运费*/
-(void)getFreight
{
    self.request = [MarketAPI requestFeight107WithController:self goodsArray:self.shoppingCartArray commitModel:_commitModel goodInfo:self.goods seckilling:self.isSeckilling];
}
/** 提交订单  2015.8 更改 */
-(void)commitOrder
{
    [self startActivity];
//    self.request = [MarketAPI requestFeight202Or605WithController:self goodsArray:self.shoppingCartArray commitModel:_commitModel goodInfo:self.goods my_sign:self.my_sign ms_sign:self.ms_sign  seckilling:_isSeckilling];
    
    //2015.8 更改
    NSLog(@"%@",self.attributeModel);
    self.request = [MarketAPI requestFeight202Or605WithController:self goodsArray:self.shoppingCartArray commitModel:_commitModel goodInfo:self.goods my_sign:self.my_sign ms_sign:self.ms_sign  seckilling:_isSeckilling attributeModel:self.attributeModel];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    [self stopActivity];

    NSString *tEndString=[[NSString alloc] initWithData:request.responseData encoding:NSUTF8StringEncoding];
    
    
    tEndString = [tEndString stringByReplacingOccurrencesOfString:@"\n" withString:@"\n"];
    
    
    NSDictionary * dict = [tEndString JSONValue];
    if (!dict){
        NSLog(@"接口错误");
        [self showMsg:@"请求失败,请重试"];
        return;
    }
    KKUserHostUrl = dict[@"host"];
    NSLog(@"提交订单  ---- dict -- %@",dict);
    if ([dict[@"code"] integerValue] == 0 && dict[@"code"] != nil) {
        switch (request.tag) {
            case 5004://获取默认地址
            {
                for (id key in [dict allKeys]) {
                    if ([key isEqual:@"id"]) {
                        [_commitModel setobject:dict];
                        
                        [self getFreight];
                        return;
                    }
                }
                [self getFreight];
                break;
            }
            case 107://运费
            {
                  _loadingFeight = YES;
                 if ([dict[@"code"] integerValue] == 0 && dict[@"code"] != nil) {
                     double priceCount = 0.00;
                     if(self.shoppingCartArray && self.shoppingCartArray.count!=0){
                         priceCount = [dict[@"totalFreight"] doubleValue];
                        
                     }else{
                         self.goods.countFreight =dict[@"totalFreight"];
                         priceCount =[dict[@"totalFreight"] doubleValue];
                     }
                     if([(NSArray*)dict[@"list"]count]!=0){
                         [_freightListArray removeAllObjects];
                         [_freightListArray addObjectsFromArray:dict[@"list"]];
                     }
                     
                     _commitModel.freight =dict[@"totalFreight"];
                     _commitModel.rsa_yunfei = dict[@"rsa_freight"];
                     if (_commitModel.rsa_yunfei == nil) {
                         _commitModel.rsa_yunfei = @"0.00";
                     }
                     
                     [self updateAmountPrice];
                 }
                break;
            }
            case 202://提交订单
            {
                [[NSNotificationCenter defaultCenter]postNotificationName:@"CrazyShoppingCartViewControllerReloadData" object:self];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"GoodsInfoViewControllerReloadData" object:self];

                _commitModel.orderNum = IfNullToString(dict[@"order_num"]) ;
                _commitModel.spending = IfNullToString(dict[@"spending"]);
                _commitModel.cash_apend = dict[@"cash_spend"];
                _commitModel.cat_ID    =IfNullToString(dict[@"is_act"]);
                if([_commitModel.cash_apend floatValue]!=0.00 ||[_commitModel.freight floatValue]!=0.00){
                    _commitModel.pay_type = @"1";
                }else{
                    _commitModel.pay_type = @"2";
                }
                self.goods.available = self.goods.available - [_commitModel.goods_nums intValue];
                self.goods.nums =self.goods.nums - [_commitModel.goods_nums intValue] ;
                [self pushPay];
                break;
            }
            
            
            default:
                break;
        }
    }else if([dict[@"code"] integerValue] == 8 && request.tag == 202){
        [self showMsg:@"被秒光了，去看看其他商品吧"];
    }else if([dict[@"code"] integerValue] == 30 && request.tag == 202){
        [self showMsg:@"支付超时，请重新购买"];
    }else{
        
            //@app ，下订单，如果商品数量为负数，我已加验证，返回code为98，参数有误，
        if(request.tag==202 &&self.shoppingCartArray&&self.shoppingCartArray.count!=0&&([dict[@"code"] integerValue]==13||[dict[@"code"] integerValue]==26||[dict[@"code"] integerValue]==5)){
            [self performSelector:@selector(ShoppingCartViewControllerReloadData) withObject:self afterDelay:1.0];
            [self showMsg:@"部分商品已失效，请重新确认商品"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"CrazyShoppingCartViewControllerReloadData" object:self];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"GoodsInfoViewControllerReloadData" object:self];

        }else{
            [self showMsg:dict[@"message"]];
        }
    }
    [self.tableView reloadData];

}
- (void)ShoppingCartViewControllerReloadData
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)requestFailed:(ASIHTTPRequest *)request
{
    [self stopActivity];
    NSLog(@"请求失败，请检查网路设置");
}

#pragma mark - PUSH
/**
 跳转发票信息
 秒杀只有现金商品 不判断发票
 */
-(void)getFaPiaoInfo
{
    

    NSLog(@"%@",_buyShopingPriceCount);
    if(_buyShopingPriceCount&&[_buyShopingPriceCount rangeOfString:@"￥"].location !=NSNotFound){
        
        InvoiceViewController * invoice=[[InvoiceViewController alloc]init];
        invoice.delegate = self;
        [self.navigationController pushViewController:invoice animated:YES];
        
    }else if(self.goodsCash == 0.00 && !self.isSeckilling){
        [self showMsg:@"仅现金购买的商品提供发票"];

    }else{
        InvoiceViewController * invoice=[[InvoiceViewController alloc]init];
        invoice.delegate = self;
        [self.navigationController pushViewController:invoice animated:YES];
    }
}

/**
 跳转收货地址
 */
-(void)getAdress:(NSString *)adress_Id
{
    LYQManageAddressController *addressVC = [[LYQManageAddressController alloc] initWithNibName:@"LYQManageAddressController" bundle:nil];
    addressVC.status = YES;
    addressVC.delegate = self;
    addressVC.addressID = adress_Id;
    [self.navigationController pushViewController:addressVC animated:YES];
}
/**
 支付
 */
-(void)pushPay
{
    LSYPayViewController *payVC = [[LSYPayViewController alloc] init];
    payVC.goodsInfo = self.goods;
    payVC.meonyStr = self.subPriceLabel.text;
    payVC.act_ID =  _commitModel.cat_ID;
    [self.navigationController pushViewController:payVC animated:YES];
}

#pragma mark - UITextFieldDelegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqual:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length > 50) {
        [self showMsg:@"留言请限制在50字以内"];
        textView.text = [textView.text substringToIndex:50];
        _commitModel.note = textView.text;
    }else if (textView.text.length > 0) {
        _commitModel.note = textView.text;
    }else{
        _commitModel.note = @"";
        textView.text = @"留言:限50字以内";
        textView.textColor = [UIColor lightGrayColor];
    }
    [UIView animateWithDuration:.3 animations:^{
        [self.tableView setCenter:CGPointMake(self.tableView.center.x, self.tableView.center.y + 170)];
    }];
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqual:@"留言:限50字以内"]) {
        textView.text = @"";
    }
    textView.textColor = [UIColor grayColor];
    [UIView animateWithDuration:.3 animations:^{
        [self.tableView setCenter:CGPointMake(self.tableView.center.x, self.tableView.center.y - 170)];
    }];
}

/** 根据状态判断更新总价 */
-(void)updateAmountPrice
{
    self.subPriceLabel.text = [MarketAPI judgeCostCashbuyType:self.isSeckilling crazy:self.shoppingCartArray?NO:YES ms_price:self.goods.ms_price cash:self.goodsCash goodNums:_commitModel.goods_nums price:_goods.price freigt:_commitModel.freight crazyPrice:_buyShopingPriceCount];
    self.subPriceLabelW.constant = [MarketAPI labelAutoCalculateRectWith:self.subPriceLabel.text FontSize:14 MaxSize:CGSizeMake(SCREENWIDTH - 121 - 45, 48)].width;
}

/**
 判断运费显示
 */
-(NSString *)showFreight
{

    if([_commitModel.freight doubleValue] == 0.00){
        return @"包邮";
    }else{
        return [NSString stringWithFormat:@"快递 %@元",_commitModel.freight];

    }
}

- (void)dealloc
{
    [_invoiceModel setInvoiceType];
    [self.request clearDelegatesAndCancel];

}
@end
