//
//  LSYSeckillingListViewController.m
//  MarketManage
//
//  Created by liangsiyuan on 15/1/15.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "LSYSeckillingListViewController.h"
#import "LSYContentView.h"
#import "ASIFormDataRequest.h"
#import "MarketAPI.h"
#import "SBJSON.h"
#import "LSYGoodsInfoViewController.h"
#import "GCRequest.h"
#import "bSaveMessage.h"

#define ViewWidth self.view.frame.size.width
#define TablewViewY self.scrollView.bounds.size.height

@interface LSYSeckillingListViewController ()<ASIHTTPRequestDelegate,LSYConetntViewDelegate,GCRequestDelegate>
@property (nonatomic,strong)LSYGoodsInfoViewController * infoVC;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic,strong)  LSYContentView * mainTableView;
@property (nonatomic,strong) LSYContentView * mateTableView;
@property (nonatomic,strong) LSYMenuScrollView *menu;
@property (nonatomic,strong) GCRequest * lsyMainRequest;
@property (nonatomic,assign)  int selectedColumnIndex;
//服务器时间
@property (nonatomic,copy)  NSString * serverTime;
//菜单数组
@property (nonatomic,strong)NSArray * menuList;
//商品列表
@property (nonatomic,strong)NSDictionary * goodsList;
//区分是给谁加载的数据
@property(nonatomic,assign)BOOL isMainTableData;
//当前请求页码
@property(nonatomic,assign)int currentNum;
@end

@implementation LSYSeckillingListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"限时秒杀";
    
    self.menuList=[NSArray array];
    self.goodsList=[NSDictionary dictionary];
    
    //Scorllview初始化
    self.scrollView.maximumZoomScale=2.0;
    self.scrollView.minimumZoomScale=0.5;
    self.scrollView.delegate=self;
    self.scrollView.pagingEnabled=YES;
    self.scrollView.delaysContentTouches=YES;
    
    self.mallTitleLabel.text = @"限时秒杀";
    
       [self getServeicesData];
}

- (void)leftBackCliked:(UIButton *)sender{
    [self.lsyMainRequest cancelRequest];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.scrollView.delegate=self;
   
}


#pragma mark - 初始化界面
-(void)initializeUI
{
    if (!self.menu) {
        self.menu=  [[LSYMenuScrollView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 40)];
        self.menu.serverTime= self.serverTime;
        self.menu.array=self.menuList;
        self.menu.delegate=self;
        [self.view addSubview:self.menu];
    }
    
    self.mainTableView=[[LSYContentView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, TablewViewY-64)];
    self.mainTableView.delegate=self;
    [self.scrollView addSubview:self.mainTableView];
    self.mateTableView=[[LSYContentView alloc]initWithFrame:CGRectMake(ViewWidth, 0, self.view.frame.size.width, TablewViewY)];
    self.mateTableView.delegate=self;
    [self.scrollView addSubview:self.mateTableView];
    
    self.scrollView.contentSize=CGSizeMake(self.view.bounds.size.width*self.menuList.count,self.view.frame.size.height-self.menu.bounds.size.height-64);
}
#pragma mark - Menu数据请求
-(void)getServeicesData
{
    self.lsyMainRequest =[MarketAPI requestSeckillingList601WithController:self miaoshaId:self.miaoShaID];
}
#pragma mark - 商品列表数据请求
-(void)getGoodsInfoByTag:(int)tag andIndex:(int)index andPageNum:(int)num
{
    self.currentNum=num;
    if (index<0||index>self.menuList.count-1) {
        return;
    }
    self.childMiaoShaID = [[self.menuList objectAtIndex:index] objectForKey:@"id"];
    self.lsyMainRequest = [MarketAPI requestSeckillingActivyList602WithController:self huodongId:[[self.menuList objectAtIndex:index] objectForKey:@"id"] pageIndex:num tag:tag];
 
}
-(void)GCRequest:(GCRequest *)aRequest Finished:(NSString *)aString
{
    NSDictionary * dic = [aString JSONValue];
    if (!dic){
        NSLog(@"接口错误");
        return;
    }
    if ([dic[@"code"] integerValue] == 0 || dic[@"code"] != nil) {
        switch (aRequest.tag) {
            case 601:
            {
                self.serverTime= [dic objectForKey:@"server_time"];
                self.menuList= [dic objectForKey:@"list"];
                int i=0;
                for (NSDictionary * dic in self.menuList) {
                    if ([[dic objectForKey:@"id"]isEqualToString:self.childMiaoShaID]) {
                        self.selectedColumnIndex=i;
                        break;
                    }
                    i++;
                }
                //上来直接请求第一第二页的数据
                if (self.menuList.count>0) {
                    [self getGoodsInfoByTag:10 andIndex:self.selectedColumnIndex andPageNum:0];
                    [self initializeUI];
                }else{
                    [self showMsg:@"活动已过期"];
                }
                
            }
                break;
            case 10:
            {
                self.mainTableView.PageTag=self.selectedColumnIndex;
                self.mainTableView.pageIndex=self.currentNum;
                self.mainTableView.dict=dic;
                
                self.mainTableView.frame=CGRectMake(self.selectedColumnIndex*ViewWidth, 0, ViewWidth, TablewViewY);
                [self.scrollView scrollRectToVisible:CGRectMake(self.selectedColumnIndex*ViewWidth, 0, ViewWidth, TablewViewY) animated:NO];
                [self scorllMenu];
            }
                break;
                
            default:
            {
                self.goodsList=dic;
                self.mateTableView.dict=self.goodsList;
            }
                break;
        }
        
    }
   
    
}
-(void)GCRequest:(GCRequest *)aRequest Error:(NSString *)aError
{
  
}

#pragma mark - CellDelegate
-(void)gotoGoodsInfo:(NSDictionary *)dic status:(BOOL)status
{
    
    //如果活动结束 不让用户进入商品详情
    if ([[dic objectForKey:@"status"]intValue]!=4) {
        [self.lsyMainRequest cancelRequest];
        self.infoVC=[[LSYGoodsInfoViewController alloc]init];
        self.infoVC.goods_id=[dic objectForKey:@"id"];
        self.infoVC.hd_id=self.childMiaoShaID;
//        self.infoVC.isSeckilling=status;
        self.infoVC.isSeckilling=status;
        [self.navigationController pushViewController:self.infoVC animated:YES];

    }
}
-(void)tablewViewNeedReloadDate:(int)num
{
    [self getGoodsInfoByTag:10 andIndex:self.selectedColumnIndex andPageNum:num];
}
#pragma mark - ScrollviewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (![scrollView isKindOfClass:NSClassFromString(@"LSYMenuScrollView")]) {
        
        //刚刚滑倒一点边出来的时候把伴侣移到应该出现的位置
        if (scrollView.contentOffset.x>=self.selectedColumnIndex*ViewWidth) {
            
            self.mateTableView.frame=CGRectMake((self.selectedColumnIndex+1)*ViewWidth, 0, ViewWidth, TablewViewY);
            
        }else if (scrollView.contentOffset.x<=self.selectedColumnIndex*ViewWidth){
            
            self.mateTableView.frame=CGRectMake((self.selectedColumnIndex-1)*ViewWidth, 0, ViewWidth, TablewViewY);
        }
        
        //已经滑动完成 更改伴侣和主显示的位置
        BOOL leftTB = (scrollView.contentOffset.x >= self.selectedColumnIndex*ViewWidth+ViewWidth);
        if (leftTB) {
            self.selectedColumnIndex++;
            
            
            self.mateTableView.frame=CGRectMake((self.selectedColumnIndex+1)*ViewWidth, 0, ViewWidth, TablewViewY);
            [self getGoodsInfoByTag:10 andIndex:self.selectedColumnIndex andPageNum:0];
            
            [self scorllMenu];
        }
        BOOL rightTB = (scrollView.contentOffset.x <= self.selectedColumnIndex*ViewWidth-ViewWidth);
        if (rightTB) {
            self.selectedColumnIndex--;
            
            self.mateTableView.frame=CGRectMake((self.selectedColumnIndex-1)*ViewWidth, 0, ViewWidth, TablewViewY);
                        [self getGoodsInfoByTag:10 andIndex:self.selectedColumnIndex andPageNum:0];
            [self scorllMenu];
        }
        
        
    }
}
-(void)scorllMenu
{
    if (self.menuList.count>0) {
        [self.menu scrollRectToVisible:CGRectMake(self.selectedColumnIndex*BUTTONITEMWIDTH, 0, self.view.frame.size.width, 40) animated:YES];
        [self.menu changeColorsByTag:self.selectedColumnIndex];
    }
}
-(void)didSelectAtIndex:(int)index
{
    //Menu选择
    self.selectedColumnIndex=index;

    [self getGoodsInfoByTag:10 andIndex:self.selectedColumnIndex andPageNum:0];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc

{
    
    [self.lsyMainRequest setDelegate:nil];
    
    [self.lsyMainRequest  cancelRequest];
    
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
