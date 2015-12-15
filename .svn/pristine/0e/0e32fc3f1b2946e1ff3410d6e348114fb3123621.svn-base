//
//  ZXYPaySuccessViewController.m
//  MarketManage
//
//  Created by Rice on 15/1/17.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "ZXYPaySuccessViewController.h"
#import "LSYGoodsInfoViewController.h"
#import "ZXYOrderListViewController.h"
#import "ZXYRecommendView.h"
#import "bSaveMessage.h"

@interface ZXYPaySuccessViewController ()
{
    ASIFormDataRequest *mRequest;
  
}
@property (weak, nonatomic) IBOutlet UILabel *shareMsgLabel;
@property (weak, nonatomic) IBOutlet UILabel *orederTypeMsgLabel;
@property (weak, nonatomic) IBOutlet UIButton *lookOrderBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *recommendScorllview;

@property (weak, nonatomic) IBOutlet UIView *recommendView;
/** 对勾图片 */
@property (weak, nonatomic) IBOutlet UIImageView *yesImage;
/** 支付成功 label */
@property (weak, nonatomic) IBOutlet UILabel *succeedLabel;


@property (strong, nonatomic) NSMutableArray *dataAry;

@property (copy, nonatomic) NSString *imageHostUrl;


@end

@implementation ZXYPaySuccessViewController

#pragma mark - LifeCylce

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.mallTitleLabel.text = @"支付成功";
    CGFloat X = (SCREENWIDTH - 20 - 10 - 80) / 2;
    [self.yesImage setFrame:CGRectMake(X, 10, 20, 20)];
    [self.succeedLabel setFrame:CGRectMake(CGRectGetMaxX(self.yesImage.frame) + 10, 9, 104, 21)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self requestRecommendGoods];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Init

//返回
- (void)leftBackCliked:(UIButton *)sender
{
    BOOL haveInfoVC = NO;
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[LSYGoodsInfoViewController class]]) {
            [self.navigationController popToViewController:vc animated:YES];
            haveInfoVC = YES;
            return;
        }
    }
    if (!haveInfoVC) {
        for (UIViewController *vc in self.navigationController.viewControllers) {
            if ([vc isKindOfClass:[ZXYOrderListViewController class]]) {
                [self.navigationController popToViewController:vc animated:YES];
                return;
            }
        }
    }
    [self.navigationController popViewControllerAnimated:YES];

}
/*数据处理
 */
-(void)initData
{
    [MarketAPI setGrayButton:self.lookOrderBtn];
    self.orederTypeMsgLabel.text = @"您的购买记录可在我的商城中查看";

    
}

/*跳转订单列表
 */
- (IBAction)toOrderListAcion:(id)sender {
    BOOL ispush = YES;
    for (UIViewController *orderlistVC  in self.navigationController.viewControllers) {
        if ([orderlistVC isKindOfClass:[ZXYOrderListViewController class]]) {
            ispush = NO;
            [self.navigationController popToViewController:orderlistVC animated:YES];
        }
    }
    if (ispush) {
        ZXYOrderListViewController *listVC = [[ZXYOrderListViewController alloc] initWithNibName:@"ZXYOrderListViewController" bundle:nil];
        [self.navigationController pushViewController:listVC animated:YES];
    }
}

/*推荐商品跳转商品详情
 */
-(void)didSelectProductWithId:(NSString *)productID;
{
    LSYGoodsInfoViewController *goodInfoVC = [[LSYGoodsInfoViewController alloc] init];
    goodInfoVC.needsPoPtoRoot = NO;
    goodInfoVC.goods_id = productID;
    [self.navigationController pushViewController:goodInfoVC animated:YES];
}

#pragma mark - Request
/*
 "por" : "109",     //请求接口
 “proIden”:“”，  //产品标识
 “type”：1//1=支付成功页面商品推荐|2=首页推荐
 */
- (void)requestRecommendGoods
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"109" forKey:@"por"];
    [dict setObject:PROINDEN forKey:@"proIden"];
    [dict setObject:@"1" forKey:@"type"];
    [self requestparams:dict];
}

- (void)requestparams:(NSDictionary *)aDict
{
    mRequest=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:[SHANGCHENG_url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    mRequest.timeOutSeconds = REQUEST_TIMEOUTSECONDS;
    mRequest.delegate=self;
    mRequest.requestMethod=@"POST";
    if (aDict!=nil) {
        for(NSString *key in aDict){
            id value = [aDict objectForKey:key];
            [mRequest setPostValue:value forKey:key];
        }
    }
    [mRequest addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
    [mRequest startAsynchronous];
    [self startActivity];
}

- (void)requestFinished:(ASIHTTPRequest *)request;
{
    [self stopActivity];
    NSString *tEndString=[[NSString alloc] initWithData:request.responseData encoding:NSUTF8StringEncoding];
    tEndString = [tEndString stringByReplacingOccurrencesOfString:@"\n" withString:@"\n"];
    NSDictionary * dict = [tEndString JSONValue];
    NSLog(@"%@",dict);
    if (!dict){
        NSLog(@"接口错误");
        return;
    }
    if ([dict[@"code"] integerValue] == 0 && dict[@"code"] != nil) {
        self.imageHostUrl = dict[@"host"];
        [self setDataAryWithAry:dict[@"list"]];
        if(self.dataAry.count <=0){
            _recommendView.hidden = YES;
        }else{
            [self createRecommendGoods];
            
        }
    }else{
        [self showMsg:dict[@"message"]];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request;
{
    [self stopActivity];
    [self showMsg:@"请求失败，请检查网路设置"];
}

-(void)setDataAryWithAry:(NSArray *)ary
{
    self.dataAry = [[NSMutableArray alloc] init];
    for (int i = 0; i < ary.count; i++) {
        ZXYRecommendModel * recommendModel = [ZXYRecommendModel createObjWithDic:ary[i] withImageHost:self.imageHostUrl];
        [self.dataAry addObject:recommendModel];
    }
}

/*推荐商品
 */
-(void)createRecommendGoods
{
    [self.recommendScorllview setContentSize:CGSizeMake(135 * self.dataAry.count + 20, FRAMNE_H(self.recommendScorllview))];
    for (int i = 0 ; i < self.dataAry.count; i++) {
        ZXYRecommendView *recommendView = [[ZXYRecommendView alloc] init];
        [recommendView setFrame:CGRectMake(10 + i * 135, 10, 125, 190)];
        recommendView.delegate = self;
        recommendView.recommendModel = self.dataAry[i];
        [recommendView setData];
        [self.recommendScorllview addSubview:recommendView];
    }
}


@end
