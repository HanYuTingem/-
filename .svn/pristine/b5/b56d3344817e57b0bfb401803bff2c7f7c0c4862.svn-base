//
//  LYQMyCollectionViewController.m
//  Chiliring
//
//  Created by nsstring on 14-9-11.
//  Copyright (c) 2014年 Sinoglobal. All rights reserved.
//

#import "LYQMyCollectionViewController.h"
#import "LYQCollectionCell.h"
#import "UIImageView+WebCache.h"
#import "LYQCollectionModel.h"
#import "MJRefresh.h" 
#import "LSYGoodsInfoViewController.h"
#import "BSaveMessage.h"
#import "CrazyBasisAlertView.h"

@interface LYQMyCollectionViewController ()
<UITableViewDataSource,UITableViewDelegate>

{
    NSIndexPath * indexpatch;//点击对应的行的NSIndexPath 属性
    
    NSString * Indexpage;//刚开始第一 设置为1
    
    NSString * countPage;//请求回来查看总的页数
    
    
    MJRefreshFooterView *_footer; // 上拉刷新
}

@property (copy, nonatomic) NSString *imageHost;

@property (weak, nonatomic) IBOutlet UIView *noCollectionRecordView;


@property (weak, nonatomic) IBOutlet UITableView *collectionTableView;//收藏的表格Tableview

@property (nonatomic,strong) NSMutableArray * collectionArray;//收藏存贮数据

@property (strong,nonatomic) ASIFormDataRequest  * request;

@end

@implementation LYQMyCollectionViewController


@synthesize collectionArray = _collectionArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        _collectionArray = [[NSMutableArray alloc]init];
    }
    return self;
}

#pragma mark - 初始化导航栏
/*
 设置导航条
 */

-(void)setNavigationBarStyle
{
    
    self.mallTitleLabel.text = @"我的收藏";
   
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
     Indexpage = @"1";//设置进来的时候第一页
    _collectionTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_collectionTableView setFrame:CGRectMake(0, 44, SCREENWIDTH, SCREENHEIGHT - 44)];
    
    //添加下拉刷新 及上提加载的方法
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, FRAMNE_W(_collectionTableView),20)];
    _collectionTableView.backgroundColor = [UIColor clearColor];
    _collectionTableView.tableHeaderView = headerView;

    [self addFooter];

    // Do any additional setup after loading the view from its nib.
}

#pragma mark - 刷新加载
// 上拉加载更多
- (void)addFooter
{
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.collectionTableView;
    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        //  后台执行：
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self footerRereshing];
//        });
    };
    _footer = footer;
}

//对于下拉刷新的时候 跳用
- (void)headerRereshing
{
    Indexpage = @"1";//下拉的时候页数设置为1

    [self reloateData];
    // 2.2秒后刷新表格UI  对于 请求完成的时候 需要开启线程更新UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [_collectionTableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
//        [_collectionTableView headerEndRefreshing];
    });

}

//上提加载的时候 获取对应的页数 数据
- (void)footerRereshing
{
    
    //加入我总的页数大过我上次加载的页数 你可以再去加载下一页 我还有数据 ～
    if ([countPage intValue]>[Indexpage intValue]){
        Indexpage =[NSString stringWithFormat:@"%d",[Indexpage intValue]+1];
    }else
    {
        [self showMsg:@"到底啦"];
        [_footer endRefreshing];
        return;
    }
    [self reloateData];
    // 2.2秒后刷新表格UI 对于 请求完成的时候 需要开启线程更新UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [_collectionTableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [_footer endRefreshing];
    });

}
//当页面开始显示的时候 去设置控健的frame 在viewdidload 里面 不管用
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNavigationBarStyle];
    Indexpage = @"1";//下拉的时候页数设置为1
    
    //请求加载数据
    [self reloateData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//返回按钮的点击事件
- (void)LeftBtnCliked:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//创建模型返回数据
-(void)getOrderModelWithDict:(NSDictionary*)result
{
    
    for (NSDictionary * subDict in result){
        
        LYQCollectionModel * CollectionModel = [[LYQCollectionModel alloc]init];
        
        CollectionModel.goodsImgaeurl =[NSString stringWithFormat:@"%@%@",self.imageHost,subDict[@"img_url"]];
        CollectionModel.goodsName =IfNullToString(subDict[@"name"]);
        CollectionModel.goods_nums =IfNullToString(subDict[@"bum_convert"]);
        NSInteger lajiaobi =(int)ceil([IfNullToString(subDict[@"price"]) floatValue]);
        CollectionModel.goodsspending =[NSString stringWithFormat:@"%ld",(long)lajiaobi];
        CollectionModel.orderCreateTime =IfNullToString(subDict[@"create_time"]);
        CollectionModel.orderId =IfNullToString(subDict[@"id"]);
        CollectionModel.goodsId = IfNullToString(subDict[@"obj_id"]);
        CollectionModel.goodscash = IfNullToString(subDict[@"cash"]);
        
        [_collectionArray addObject:CollectionModel];
    }
    
    
}
#pragma  mark - collectTabelView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _collectionArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
//        return 110*SP_WIDTH;
        return 100 * SP_WIDTH;
    }
    return 100*SP_WIDTH;
    
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *collectionIndfier = @"collectionIndfier";
    
    LYQCollectionCell * cell = [tableView dequeueReusableCellWithIdentifier:collectionIndfier];
    
    if (cell == nil ){
        
        cell = [[[NSBundle mainBundle]loadNibNamed:@"LYQCollectionCell" owner:self options:nil]lastObject];
        cell.goodsImageView.layer.masksToBounds = YES;
        cell.goodsImageView.layer.borderWidth = 1;
        cell.goodsImageView.layer.borderColor = CrazyColor(230, 230, 230).CGColor;
        cell.cellIamgeWCos.constant = 237 * SP_WIDTH;

    }
    if (indexPath.row == 0) {
        [cell.bgview setFrame:CGRectMake(0, 10, SCREENWIDTH, 90)];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    LYQCollectionModel * collectionModel = [_collectionArray objectAtIndex:indexPath.row];
    [cell.goodsImageView setImageWithURL:[NSURL URLWithString:collectionModel.goodsImgaeurl] placeholderImage:[UIImage imageNamed:@"L_dingdandefult.png"]];
    
    cell.goodsNameLabel.verticalAlignment = VerticalAlignmentTop;
    cell.goodsNameLabel.text = collectionModel.goodsName;
    cell.redeemLabel.text = [NSString stringWithFormat:@"已兑换 %@",collectionModel.goods_nums];
    cell.remainingRedeemLabel.text =[self judgeCostTypeWithCash:collectionModel.goodscash andIntegral:collectionModel.goodsspending];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
    
}

#pragma mark - CollectionTabelView DataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LSYGoodsInfoViewController * detailViewControl = [[LSYGoodsInfoViewController alloc]initWithNibName:@"LSYGoodsInfoViewController" bundle:nil];
    LYQCollectionModel * model =[_collectionArray objectAtIndex:indexPath.row];
    detailViewControl.goods_id = model.goodsId;
    [self.navigationController pushViewController:detailViewControl animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete ){
        
        [CrazyBasisAlertView CrazyBasisAlertViewShowTitle:@"" content:@"你确定要删除该商品吗？"buttonTextArray:@[@"取消",@"确定"] leftSelectBlock:^(CrazyBasisButton *confirmButton) {
            
        } rigthSelectBlock:^(CrazyBasisButton *cancelBlock) {
            indexpatch = indexPath;
            [self requestCollectionList];
        }];
    }
}

#pragma mark - 数据判断
-(NSString *)judgeCostTypeWithCash:(NSString *)cash andIntegral:(NSString *)integral
{
    NSString *cashResult = @"";
    NSString *integralResult = @"";
    if ([cash floatValue] == 0.0) {
        cashResult = @"";
    }else{
        cashResult = [NSString stringWithFormat:@"￥ %.2f",[cash floatValue]];
    }
    if ([integral integerValue] == 0) {
        integralResult = @"";
    }else{
        integralResult = [NSString stringWithFormat:@"%@ %@",integral,INTERGRAL_NAME];
    }
    if ([cashResult isEqual:@""]) {
        return integralResult;
    }
    if ([integralResult isEqual:@""]) {
        return cashResult;
    }
    return [[cashResult stringByAppendingString:@" + "] stringByAppendingString:integralResult];
}

#pragma mark - Request
/*删除收藏
 */
-(void)requestCollectionList
{
    LYQCollectionModel * model =[_collectionArray objectAtIndex:indexpatch.row];
    _request = [MarketAPI requestDeleteCollectList507WithController:self goodId:model.goodsId];
}

//请求加载数据
- (void)reloateData
{
    _request = [MarketAPI requestCollectList506WithController:self pageIndex:Indexpage];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *tEndString=[[NSString alloc] initWithData:request.responseData encoding:NSUTF8StringEncoding];
    tEndString = [tEndString stringByReplacingOccurrencesOfString:@"\n" withString:@"\n"];
    NSDictionary * dict = [tEndString JSONValue];
    NSLog(@"LSYGoodsInfoView::%@",dict);
    if (!dict){
        NSLog(@"接口错误");
        return;
    }
    if ([dict[@"code"] integerValue] == 0 && dict[@"code"] != nil) {
        
        switch (request.tag) {
            case 506:
            {
                self.imageHost = dict[@"host"];
                if([Indexpage isEqualToString:@"1"]){
                    [_collectionArray removeAllObjects];
                }
                [self getOrderModelWithDict:[dict objectForKey:@"list"]];
                countPage = IfNullToString([dict objectForKey:@"pageNums"]);
                
                if ([[dict objectForKey:@"list"]count] == 0 ){
                    
                    _noCollectionRecordView.hidden = NO;
                    _collectionTableView.hidden = YES;
                }
                [_collectionTableView reloadData];
                break;
            }
            case 507:
            {
                [_collectionArray removeObjectAtIndex:indexpatch.row];
                [_collectionTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexpatch] withRowAnimation:UITableViewRowAnimationFade];
                
                if ([_collectionArray count] == 0 ){
                    
                    _noCollectionRecordView.hidden = NO;
                    _collectionTableView.hidden = YES;
                }
                break;
            }
            default:
                break;
        }
        
    }else{
        [self showMsg:dict[@"message"]];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request;
{
    [self showMsg:@"请求失败，请检查网路设置"];
}

@end
