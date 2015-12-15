
//
//  ConfirmOrderViewController.m
//  MarketManage
//
//  Created by 许文波 on 15/7/28.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "ConfirmOrderViewController.h"
#import "DHConfirmOrderCell.h"
//#import "LSYUserAdressTableViewCell.h"
/** 收货地址 */
#import "shopManView.h"
/** 段头的内容 */
#import "ConfirmOrderHeadView.h"

/** Bottom   下面的视图 */
#import "buildBottomView.h"

/** 跳转收货地址 */
#import "LYQManageAddressController.h"
#import "ZXYCommitOrderRequestModel.h"
/** 地址模型 */
#import "MarketAPI.h"
#import "ZXYCommitOrderRequestModel.h"
#import "LSYPayViewController.h"
#import "MyUILabel.h"
/** 发票模型 */
#import "ZXYInvoiceModel.h"
@interface ConfirmOrderViewController ()<UITableViewDataSource,UITableViewDelegate,SelectAddDelegate,UITextViewDelegate,InvoiceMessageDelegate,InvoiceMessageDelegate>
{
    /** 用来存储cell */
    NSMutableDictionary *shopDic;
    UITableView *table;
}
/** 获取默认地址/运费的模型*/
@property (nonatomic,strong) ZXYCommitOrderRequestModel *commitModel;
@property (strong,nonatomic) ASIFormDataRequest         * request;
/** 合计价格*/
@property (strong, nonatomic)  MyUILabel          *subPriceLabel;
@property (nonatomic,strong) ZXYInvoiceModel            *invoiceModel;
/** 是否正在加载运费的操作 */
@property (nonatomic,assign) BOOL                       loadingFeight;
/** 商品清单 */
@property (nonatomic,strong) NSMutableArray             * freightListArray;

/** 标识用来记录哪一个发票信心被修改 */
@property(nonatomic,strong) NSMutableArray *idenArr;
/** 发票类型 数组 */
@property (nonatomic,strong) NSMutableArray *invoiceArray;
/** 留言信息的数组 */
@property (nonatomic,strong) NSMutableArray *messageArray;
@end

@implementation ConfirmOrderViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getUserDefaultAddress];

}
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.idenArr = [NSMutableArray arrayWithCapacity:0];
        _commitModel = [ZXYCommitOrderRequestModel shareInstance];
        [_commitModel setobject:NULL];
        _invoiceModel        = [ZXYInvoiceModel shareInstance];
        _loadingFeight       = NO;
        _freightListArray    = [[NSMutableArray alloc]init];
        shopDic = [NSMutableDictionary dictionaryWithCapacity:0];
        self.invoiceArray = [NSMutableArray arrayWithCapacity:0];
        self.messageArray = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeIden];
//    [self getInvoiceMsgModel:_invoiceModel];
    self.mallTitleLabel.text = @"确认订单";
    [self tableView];
    [self buildBottomView];
    
    /**  遮罩层  */
    [self MaskView];
    [self DHConfirmCell];
}

/** tableView 创建 */
-(void)tableView{
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT-64-49) style:UITableViewStyleGrouped];
    [self.view addSubview:table];
    table.delegate = self;
    table.dataSource = self;
    table.tableHeaderView = [self upView];
    table.tableFooterView = [self bottomLabel];
    
}
-(void)DHConfirmCell{
    
    for (int i = 0; i<self.shopCountArr.count; i++) {
        NSString *idenShop = [NSString stringWithFormat:@"shopCell%d",i];
        DHConfirmOrderCell *cell;
        cell = [[DHConfirmOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenShop];
        [shopDic setObject:cell forKey:idenShop];
    }
    NSLog(@"%@",shopDic);
}
-(void)MaskView{
    UIButton *maskButton = [UIButton buttonWithType:UIButtonTypeCustom];
    maskButton.frame = self.view.bounds;
//    maskButton.backgroundColor = [UIColor redColor];
    maskButton.tag = 7777;
    maskButton.hidden = YES;
    [maskButton addTarget:self action:@selector(maskBtnDown:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:maskButton];
}
/** 隐藏Button 隐藏键盘  */
-(void)maskBtnDown:(UIButton *)maskBtn{
    [self.view endEditing:YES];
    maskBtn.hidden = YES;
}

-(void)makeIden{
    for (int i = 0; i<self.shopCountArr.count; i++) {
        /** 1  表示 未编辑。0 标识编辑 */
        [self.idenArr addObject:@"1"];
    }
}
/** 头部的地址 */
-(UIView *)upView{

    NSLog(@"%@",_commitModel.connect);
    
    shopManView *shopMan = [[shopManView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, 95) arrowImageView:@"mall_list_ico_address2@x.png" userName:[NSString stringWithFormat:@"%@",_commitModel.connect_name] userTel:_commitModel.connect userAdress:[NSString stringWithFormat:@"%@%@",_commitModel.area,_commitModel.address] arrow:@"mall_list_ico_shop_arrow2@x.png"];
    
    shopMan.userInteractionEnabled = YES;
    UIButton *shopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shopButton.frame = shopMan.bounds;

    [shopButton addTarget:self action:@selector(changeAddress) forControlEvents:UIControlEventTouchUpInside];
    [shopMan addSubview:shopButton];
    return shopMan;
}
/** 底部的视图 */
-(UILabel *)bottomLabel{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/4, 0, 120*SP_WIDTH, 20)];
    label.textColor = [UIColor lightGrayColor];
    label.font = [UIFont  systemFontOfSize:14];
    label.text = @"*积分购买的商品，不支持退款";
    return label;
}
-(void)changeAddress{
    NSLog(@" 收货地址，");
    
    LYQManageAddressController *manageArress = [[LYQManageAddressController alloc] init];
    [self.navigationController pushViewController:manageArress animated:YES];
}
-(void)selectAddDic:(NSMutableDictionary *)dict
{
    [_commitModel setobject:dict];
    [table reloadData];
    
    NSLog(@"%@",dict);
//    [self getFreight];/** 获取运费 */
}
/*
 发票信息传值
 为请求参数赋值
 */
-(void)getInvoiceMsgModel:(ZXYInvoiceModel *)model
{
    _commitModel.invoice_type     = model.invoiceType;
    _commitModel.invoice_category = model.invoiceContent;
    _commitModel.invoice_title    = model.invoiceTitle;

    [table reloadData];
//    [self.idenArr removeAllObjects];
//    [self makeIden];
}
#pragma mark 收货地址，
-(void)getUserDefaultAddress
{
    self.request = [MarketAPI requestMorenAddress5004WithController:self];
}
//提交订单
-(void)commitOrder
{
    [self startActivity];
    
    NSLog(@"%@",_commitModel.invoice_type);
    NSLog(@"my_sign===%@   self.ms_sign===%@",self.my_sign,self.ms_sign);
    NSLog(@"%@",_commitModel.order_time);
    for (int i = 0; i < self.shopCountArr.count; i++) {
        NSString  *iden = [NSString stringWithFormat:@"shopCell%d",i];
        DHConfirmOrderCell *cell = [shopDic objectForKey:iden];
        [self.messageArray addObject:cell.Message.text];
        NSLog(@"%@",cell.invoicingLableText.text);
        NSLog(@"%@",cell.Message.text);
    }
    NSLog(@"%@",self.messageArray);
    
    
    self.request = [MarketAPI requestFeight202Or605WithController:self goodsArray:self.shoppingCartArray commitModel:_commitModel goodInfo:self.goods my_sign:self.my_sign ms_sign:self.ms_sign  seckilling:_isSeckilling];
}
-(void)tableViewConfirmCell:(DHConfirmOrderCell *)confirmCell{
    
}
-(void)getFreight
{
    self.request = [MarketAPI requestFeight107WithController:self goodsArray:self.shoppingCartArray commitModel:_commitModel goodInfo:self.goods seckilling:self.isSeckilling];
}

- (void)requestFinished:(ASIHTTPRequest *)request{
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
    
    
    if ([dict[@"code"] integerValue] == 0 && dict[@"code"] != nil) {
        switch (request.tag) {
            case 5004://获取默认地址
            {
                for (id key in [dict allKeys]) {
                    if ([key isEqual:@"id"]) {
                        [_commitModel setobject:dict];
                        [self getFreight];
                        table.tableHeaderView = [self upView];
                        [table reloadData];
                        return;
                    }
                }
                [self getFreight];
                break;
            }   case 107://运费
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
                    [table reloadData];
                    [self updateAmountPrice];
                }
                break;
            }

            case 202://提交订单
            {
                [[NSNotificationCenter defaultCenter]postNotificationName:@"CrazyShoppingCartViewControllerReloadData" object:self];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"GoodsInfoViewControllerReloadData" object:self];
                
                NSLog(@"%@",dict);
                
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
}
- (void)ShoppingCartViewControllerReloadData
{
    [self.navigationController popViewControllerAnimated:YES];
}

/** 根据状态判断更新总价 */
-(void)updateAmountPrice
{
    
    UILabel *label = (UILabel *)[self.view viewWithTag:1111];
    label.text = [NSString stringWithFormat:@"￥%.2f",[_commitModel.freight floatValue]+[self.buyShopingPriceCount floatValue]];


}
/** 创建底部视图 */
-(void)buildBottomView{
    buildBottomView *buildBottom = [[buildBottomView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT-49, SCREENWIDTH, 49) totalLabel:[NSString stringWithFormat:@"￥%@",self.buyShopingPriceCount ] OrderButton:@selector(orderButtonDown) target:self];
    [self.view addSubview:buildBottom];

}
/** 提交订单 */
-(void)orderButtonDown{
    
    if (self.goods.nums>0 &&[_commitModel.goods_nums integerValue] > self.goods.nums &&!self.shoppingCartArray) {
        [self showMsg:@"库存不足啦~亲"];
    }else if ( [_commitModel.address isEqualToString:@""]) {
        [self showMsg:@"还没有收货地址呢亲~\n先添加一个吧"];
    }else{
        [self commitOrder];
    }
  
    NSLog(@"提交订单");
}
//支付
-(void)pushPay{
    
    LSYPayViewController *payVC = [[LSYPayViewController alloc] init];
    payVC.goodsInfo = self.goods;
    payVC.meonyStr = [NSString stringWithFormat:@"%ld",[self.buyShopingPriceCount integerValue]+[_commitModel.freight integerValue]];
    NSLog(@"%@",_commitModel.cat_ID);
    payVC.act_ID =  _commitModel.cat_ID;
    
    [self.navigationController pushViewController:payVC animated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.shopCountArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *idenShop = [NSString stringWithFormat:@"shopCell%d",(int)indexPath.section];
    DHConfirmOrderCell*cell = (DHConfirmOrderCell *)[shopDic objectForKey:idenShop];
//    NSString *iden = [NSString stringWithFormat:@"%ld",indexPath.section];
//    DHConfirmOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
//    if (!cell) {
//        cell = [[DHConfirmOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
//    }
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    NSDictionary *dic = self.shopCountArr[indexPath.section];
    NSLog(@"%@",self.freightListArray);
    cell.Message.delegate =self;
    NSArray *listModel = dic[@"listModel"];
    [cell refreshUI:listModel];
    if (_loadingFeight == YES) {
        NSDictionary *dictExpress = _freightListArray[indexPath.section];
        [cell refreshUIExpress:dictExpress];
    }
    if ([_commitModel.invoice_category isEqualToString:@"不开发票"]) {
        
        cell.invoicingLableText.text = _commitModel.invoice_category;
    }else{
        if ([self.idenArr[indexPath.section] isEqualToString:@"0"]) {
            cell.invoicingLableText.text = _commitModel.invoice_title;
        }
    }
    cell.messageLabel.tag = 8000+indexPath.section;
    cell.invoicingLableText.tag = 4000+indexPath.section;
    cell.InvoicingBtn.tag = 3000+indexPath.section;
    cell.Message.tag = 2000+indexPath.section;

//    UIButton *btn = (UIButton *)[cell viewWithTag:3000+indexPath.section];
    
    [cell.InvoicingBtn addTarget:self action:@selector(selectInvoice:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
#pragma mark uitextView  代理
- (BOOL)textView:(UITextView *)atextView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (atextView.text.length >= 50 && range.length == 0)
    {
        return NO; // return NO to not change text
    }
    else
    {
        return YES;
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"%f",scrollView.contentOffset.y);
}
-(void)textViewDidBeginEditing:(UITextView *)textView{
    
    UIButton *maskBtn = (UIButton *)[self.view viewWithTag:7777];
    maskBtn.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        CGPoint offset = table.contentOffset;
        offset.y +=(textView.tag-2000)*(50.0);
        table.contentOffset = offset;
    } completion:^(BOOL finished) {
    }];
}
-(void)textViewDidChangeSelection:(UITextView *)textView{
    
    if (textView.text.length>0) {
        UILabel *label = (UILabel *)[self.view viewWithTag:(textView.tag-2000)+8000];
        label.text = @"";
        if (textView.text.length>=50) {
            [self showMsg:@"限50字以内"];
        }
    }else if (textView.text.length <= 0){
        UILabel *label = (UILabel *)[self.view viewWithTag:(textView.tag-2000)+8000];
        label.text = @"留言：限50字以内";
    }
}
#pragma mark - PUSH
-(void)selectInvoice:(UIButton *)InvoiceBtn{
    NSLog(@"%ld",InvoiceBtn.tag);

    [self.idenArr removeAllObjects];
    [self makeIden];
    [self.idenArr replaceObjectAtIndex:InvoiceBtn.tag - 3000 withObject:@"0"];
    /*
     跳转发票信息
     秒杀只有现金商品 不判断发票
     */
//    NSDictionary *invoice =  _freightListArray[Invoice.tag - 3000];
//    if(_buyShopingPriceCount&&[_buyShopingPriceCount rangeOfString:@"￥"].location !=NSNotFound){
    
        InvoiceViewController * invoice=[[InvoiceViewController alloc]init];
        invoice.delegate = self;

        [self.navigationController pushViewController:invoice animated:YES];
//        
//    }else if(self.goods.cash == 0.00 && !self.isSeckilling){
//        [self showMsg:@"仅现金购买的商品提供发票"];
//        
//    }else{
//        InvoiceViewController * invoice=[[InvoiceViewController alloc]init];
//        invoice.delegate = self;
//        [self.navigationController pushViewController:invoice animated:YES];
//    }
//

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 230.f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 38.f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
  
    NSDictionary *dic = self.shopCountArr[section];
    NSString *headStr = dic[@"shop_name"];
    ConfirmOrderHeadView *headView = [[ConfirmOrderHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 44) shopImageView:@"mall_list_ico_shop" shopName:headStr];
    return headView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark  textField 的代理

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
