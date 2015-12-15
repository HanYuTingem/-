//
//  LSYContentView.m
//  MarketManage
//
//  Created by liangsiyuan on 15/1/16.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "LSYContentView.h"
#import "LSYContentTableViewCell.h"
#import "MJRefresh.h"
#import "NSDate+LSY.h"
#import "ZXYWarmingView.h"
@interface LSYContentView()
{
    MJRefreshHeaderView *_header; // 下拉刷新
    MJRefreshFooterView *_footer; // 上拉刷新
}
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *staName;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UIView *timeView;
@property (weak, nonatomic) IBOutlet UILabel *mmLabel;
@property (weak, nonatomic) IBOutlet UILabel *ssLabel;
@property (weak, nonatomic) IBOutlet UILabel *hhLabel;
@property (nonatomic,assign)BOOL couldGoGoodsInfo;
@property (nonatomic,assign)int status;
@property(nonatomic,strong)NSTimer* timer;
@end

@implementation LSYContentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"LSYContentView" owner:self options:nil][0];
        [self setFrame:frame];
        [self.tableView registerNib:[UINib nibWithNibName:@"LSYContentTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
        self.tableView.delegate=self;
        self.tableView.dataSource=self;
        self.goodsArray=[NSMutableArray array];
        self.dict=[NSDictionary dictionary];
        self.tableView.tableFooterView=[[UIView alloc]init];


        [self setupRefresh];
    }
    return self;
}

#pragma mark - 刷新加载
// 上拉加载更多
- (void)addFooter
{
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.tableView;
    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        //  后台执行：
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self footerRereshing];
//        });
    };
    _footer = footer;
}

// 下拉刷新
- (void)addHeader
{
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.tableView;
    header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        //  后台执行：
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self headerRereshing];

//        });
    };
    //    [header beginRefreshing];
    _header = header;
}
- (void)setupRefresh
{
    // 下拉刷新(进入刷新状态就会调用self的headerRereshing)
    // dateKey用于存储刷新时间，可以保证不同界面拥有不同的刷新时间
    [self addHeader];
    [self addFooter];
}

- (void)headerRereshing
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(tablewViewNeedReloadDate:)]) {
        self.pageIndex=0;
        [self.delegate tablewViewNeedReloadDate:self.pageIndex];
    }
    [self.tableView reloadData];
    [_header endRefreshing];

}
- (void)footerRereshing
{
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(tablewViewNeedReloadDate:)]) {
        self.pageIndex++;
        [self.delegate tablewViewNeedReloadDate:self.pageIndex];
    }
    [self.tableView reloadData];
    [_footer endRefreshing];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.goodsArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentify = @"Cell";
    LSYContentTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:cellIdentify];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.host=[self.dict objectForKey:@"host"];
    cell.goodsDic=[self.goodsArray objectAtIndex:indexPath.row];
    UIImageView * ivUnder=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,self.bounds.size.width, 1)];
    ivUnder.image=[UIImage imageNamed:@"zxy_line.png"];
    cell.exclusiveTouch=YES;

    [self addSubview:ivUnder];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell =
    [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    float height=cell.frame.size.height;
    [cell removeFromSuperview];
    
    return height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.status!=3) {
        if (self.delegate&&[self.delegate respondsToSelector:@selector(gotoGoodsInfo:status:)]) {

            [self.delegate gotoGoodsInfo:[self.goodsArray objectAtIndex:indexPath.row]status:self.status==1?NO:YES];
            
        }
    }else{
        [[ZXYWarmingView shareInstance]showMsg:@"活动已结束"];
    }
    
}
/*
 判断活动倒计时状态
 */
-(void)setDict:(NSDictionary *)dict
{
    _dict=dict;
    if (self.oldPageTag==self.PageTag&&self.pageIndex>0) {
       [_goodsArray addObjectsFromArray:[dict objectForKey:@"list"]];
    }else {
        [_goodsArray removeAllObjects];
        _goodsArray=[dict objectForKey:@"list"];
        self.oldPageTag=self.PageTag;
        self.pageIndex=0;
    }
    NSString * time=[NSString stringWithFormat:@"%@",[dict objectForKey:@"end_time"] ];
    [self updateLabel];
    int status= [[dict objectForKey:@"status"]intValue];
    self.status=status;
    [self changeViewByTime:time];
}
#pragma mark - 根据时间状态修改显示
-(void)changeViewByTime:(NSString*)time
{
    switch (self.status) {
            //未开始
        case 1:
        {
            self.staName.text=@"即将开始";
            self.stateLabel.text=@"距离本场开始";
            self.stateLabel.hidden=NO;
            [self changeDateFormat:time];
        }
            break;
            //已开始
        case 2:
        {
            self.staName.text=@"抢购中";
            self.stateLabel.text=@"距离本场结束";
            self.stateLabel.hidden=NO;
            [self changeDateFormat:time];
        }
            break;
            //结束
        case 3:
        {
            self.staName.text=@"已经结束";
            self.stateLabel.hidden=YES;
            self.dateLabel.hidden=YES;
            self.timeView.hidden=YES;
            self.start_time=0;
        }
            break;
            
        default:
            break;
    }
    if (_start_time>0) {
        [self startCountDown];
    }
    [self.tableView reloadData];
}
#pragma mark - 倒计时
-(void)startCountDown
{
    if (self.start_time>0&&!self.timer) {
        self.timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFrieMethod) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}

-(void)timeFrieMethod
{
    self.start_time--;
    [self updateLabel];
    //到0销毁定时器
    if (self.start_time==0) {
        [self.timer invalidate];
        self.timer=nil;
        switch (self.status) {
            case 1:
            {
                self.status++;
                NSString * time=[NSString stringWithFormat:@"%d",[[_dict objectForKey:@"act_end_time"]intValue]-[[_dict objectForKey:@"act_start_time"]intValue]];
                [self changeViewByTime:time];
            }
                break;
            case 2:
            {
                self.status++;
                [self changeViewByTime:@"0"];
            }
                break;
            default:
                break;
        }
//        if (self.delegate&&[self.delegate respondsToSelector:@selector(tablewViewNeedReloadDate:)]) {
//            [self.delegate tablewViewNeedReloadDate:0];
//        }
    }
}

-(void)updateLabel
{
    NSString * time= [NSDate dateWithStringHMS:[NSString stringWithFormat:@"%lld",self.start_time]];
    self.hhLabel.text=[time substringWithRange:NSMakeRange(0, 2)];
    self.mmLabel.text=[time substringWithRange:NSMakeRange(3, 2)];
    self.ssLabel.text=[time substringWithRange:NSMakeRange(6, 2)];
}
//判断时间是不是日期格式
-(void)changeDateFormat:(NSString*)time
{
    if (time!=nil&&time!=NULL&&![time isEqualToString:@"(null)"]) {
        NSRange range = [time rangeOfString:@"-"];
        if(range.location==NSNotFound){
            _start_time=[time longLongValue];
            self.dateLabel.hidden=YES;
            self.timeView.hidden=NO;
        }
        else
        {
            self.dateLabel.text=time;
            self.dateLabel.hidden=NO;
            self.timeView.hidden=YES;
        }
    }

}


@end
