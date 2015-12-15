//
//  CollectionViewController.m
//  ChillingAmend
//
//  Created by 孙瑞 on 15/9/21.
//  Copyright (c) 2015年 SinoGlobal. All rights reserved.
//

#import "CollectionViewController.h"
#import "MJRefresh.h"
#import "CollectionBusinessTableViewCell.h"
#import "CollectionMessageModel.h"
#import "CollectionTableViewCell.h"
#import "PRJ_VideoDetailViewController.h"
#import "CollectionCommodityTableViewCell.h"
#import "CommodityModel.h"
#import "LSYGoodsInfoViewController.h"
#import "BYC_BusinessModel.h"
#import "ListTableViewController.h"


#define kYOffset 0 // 提示框偏移量

@interface CollectionViewController () <UITableViewDelegate, UITableViewDataSource>
{
    /*
     *  收藏的类型 0:视频  1:商品  2:商户
     */
    NSInteger _collectionType;
    NSMutableArray *_collectionDataArray; // 收藏数组
    NSMutableArray *_delectedCollectionDataArray; // 要删除的collection
    MJRefreshHeaderView *_header; // 下拉刷新
    MJRefreshFooterView *_footer; // 上拉刷新
    NSInteger messagePageSize; // 页码
    NSMutableArray *mArray;
    BOOL isRefreshing; //是否是下拉刷新
}
@property (weak, nonatomic) IBOutlet UIButton *commodityBtn;
@property (weak, nonatomic) IBOutlet UIButton *videoBtn;
@property (weak, nonatomic) IBOutlet UIButton *businessBtn;

@property (weak, nonatomic) IBOutlet UIImageView *commoditySelectLine;
@property (weak, nonatomic) IBOutlet UIImageView *videoSelectLine;
@property (weak, nonatomic) IBOutlet UIImageView *businessSelectLine;

//@property (strong, nonatomic) UITableView *mainTableView;
/**
 *  删除Vedio收藏使用的请求
 */
@property (strong, nonatomic) GCRequest *mainRequestVedio;

/**
 *  删除商品使用的请求
 */
@property (strong, nonatomic) GCRequest *mainRequestShop;

/**
 *  删除商户使用的请求
 */
@property (strong, nonatomic) GCRequest *mainRequestMerchant;

@property (copy, nonatomic) NSString *hostImageurl;//图片头地址

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _collectionType = 1;
    
    // 导航栏
    [self setNavigationBarWithState:1 andIsHideLeftBtn:NO andTitle:@"收藏"];
    // 右键
    [self addRightBarButtonItemWithImageName:@"" andTargate:@selector(setEditing:animated:) andRightItemFrame:CGRectMake(SCREENWIDTH - 50, 20, 60, 44) andButtonTitle:@"编辑" andTitleColor:[UIColor colorWithRed:61/255.0 green:66/255.0 blue:69/255.0 alpha:1.0]];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.commodityBtn setSelected:YES];
    [self.videoBtn setSelected:NO];
    [self.businessBtn setSelected:NO];
    
    self.commodityBtn.exclusiveTouch = YES;
    self.videoBtn.exclusiveTouch = YES;
    self.businessBtn.exclusiveTouch = YES;
    
    messagePageSize = 1;
    [self setSelectLine:1];
    self.mainTableView.backgroundColor = [UIColor clearColor];
    self.mainTableView.allowsSelectionDuringEditing = YES;
    _collectionDataArray = [[NSMutableArray alloc] init];
    _delectedCollectionDataArray = [[NSMutableArray alloc] init];
    mArray = [NSMutableArray array];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addHeader];
    [self addFooter];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
    [self requestCollectionData];
}

#pragma mark - 设置选中项红线
- (void)setSelectLine:(NSInteger) selectNum {
    self.commoditySelectLine.hidden = YES;
    self.videoSelectLine.hidden = YES;
    self.businessSelectLine.hidden = YES;
    switch (selectNum) {
        case 0://视频
            self.videoSelectLine.hidden = NO;
            break;
        case 1://商品
            self.commoditySelectLine.hidden = NO;
            break;
        case 2://商户
            self.businessSelectLine.hidden = NO;
            break;
            
        default:
            break;
    }
}

- (IBAction)commodityBtnClick:(id)sender {
    [self showMsg:nil];
    _collectionType = 1;
    messagePageSize = 1;
    [self setSelectLine:1];
    [self.commodityBtn setSelected:YES];
    [self.videoBtn setSelected:NO];
    [self.businessBtn setSelected:NO];
    [_collectionDataArray removeAllObjects];
    [self requestCollectionData];
}

- (IBAction)videoBtnClick:(id)sender {
    [self showMsg:nil];
    _collectionType = 0;
    messagePageSize = 1;
    [self setSelectLine:0];
    [self.commodityBtn setSelected:NO];
    [self.videoBtn setSelected:YES];
    [self.businessBtn setSelected:NO];
    [_collectionDataArray removeAllObjects];
    [self requestCollectionData];
}

- (IBAction)businessBtnClick:(id)sender {
    [self showMsg:nil];
    _collectionType = 2;
    messagePageSize = 1;
    [self setSelectLine:2];
    [self.commodityBtn setSelected:NO];
    [self.videoBtn setSelected:NO];
    [self.businessBtn setSelected:YES];
    [_collectionDataArray removeAllObjects];
    [self requestCollectionData];
    
}

#pragma mark GCRequestDelegate
- (void)GCRequest:(GCRequest *)aRequest Finished:(NSString *)aString
{
    NSLog(@"collection = %@", aString);
    
    [self dismissWaitingView];
    NSMutableDictionary *dict = [aString JSONValue];
    if ( !dict ) {
        [self showStringMsg:@"网络连接失败" andYOffset:0];
        return;
    }
    [self hide];
    if ([[dict objectForKey:@"code"] intValue] == 0) { // 有返回
        
        NSLog(@"%@",dict);
        switch (aRequest.tag) {
            case 1302: // 视频收藏
            {
//                if (_header.refreshing) {
//                    
//                    isRefreshing = _header.refreshing;
//                }else{
//                    
//                    isRefreshing = _header.refreshing;
//                }
                if ([[dict objectForKey:@"collect"] count] != 0) { // 有收藏
                    for (int i = 0 ; i < [[dict objectForKey:@"collect"] count]; i++) {
                        CollectionMessageModel *collectionModel  = [[CollectionMessageModel alloc] init];
                        [collectionModel parse:[[dict objectForKey:@"collect"] objectAtIndex:i]];
                        if (collectionModel.collectionId && ![collectionModel.collectionId isEqual:@""]) {
                            collectionModel.isChecked = NO;
                            [mArray addObject:collectionModel];
                        }
                    }
                    self.rightButton.hidden = NO;
                }else{
                    if ( _footer.refreshing && _collectionDataArray.count > 0) {
                        
                        [self showStringMsg:@"已经加载全部视频收藏啦!" andYOffset:0];
                    }else {
                        self.rightButton.hidden = YES;
                        [_collectionDataArray removeAllObjects];
                        [self.mainTableView reloadData];
//                        [self showStringMsg:@"亲,暂无收藏的视频,去收藏几个吧!" andYOffset:0];
                        [self showStringMsg:@"暂无收藏的视频!" andYOffset:0];
                    }
                }
                
                if (mArray.count > 0) {
                    
                    [self modelOrderByCreateTime:mArray];
                }
                
            }
                break;
            case 1303: // 取消视频收藏
                [self showStringMsg:@"删除成功" andYOffset:kYOffset];
                if (_mainRequestVedio) {
                    [_mainRequestVedio cancelRequest];
                    self.mainRequestVedio = nil;
                }
                break;
            case 506: // 商品收藏
            {
//                if (_header.refreshing) {
//                    
//                    isRefreshing = _header.refreshing;
//                }
                if ( [[dict objectForKey:@"list"] count] != 0) { // 有收藏
                    self.hostImageurl = dict[@"host"];
                    for (int i = 0 ; i < [[dict objectForKey:@"list"] count]; i++) {
                        CommodityModel *commodityModel  = [[CommodityModel alloc] init];
                        [commodityModel parse:[[dict objectForKey:@"list"] objectAtIndex:i]];
                        if (commodityModel.collectionId && ![commodityModel.collectionId isEqual:@""]) {
                            commodityModel.isChecked = NO;
                            [mArray addObject:commodityModel];
                        }
                    }
                    self.rightButton.hidden = NO;
                }else{
                    
                    if ( _footer.refreshing && _collectionDataArray.count > 0) {
                        
                        [self showStringMsg:@"已经加载全部商品收藏啦!" andYOffset:0];
                    }else {
                        self.rightButton.hidden = YES;
                        [_collectionDataArray removeAllObjects];
                        [self.mainTableView reloadData];
//                        [self showStringMsg:@"亲,暂无收藏的商品,去收藏几个吧!" andYOffset:0];
                        [self showStringMsg:@"暂无收藏的商品!" andYOffset:0];
                    }
                }
                
                if (mArray.count > 0) {
                    
                    [self modelOrderByCreateTime:mArray];
                }
                
            }
                break;
            case 507: // 取消商品收藏
                [self showStringMsg:@"删除成功" andYOffset:kYOffset];
                if (_mainRequestShop) {
                    [_mainRequestShop cancelRequest];
                    self.mainRequestShop = nil;
                }
                break;
            case 606: //收藏的商户 NiceFood_ImageUrl
            {
//                if (_header.refreshing) {
//                    
//                    isRefreshing = _header.refreshing;
//                }else{
//                    
//                    isRefreshing = _header.refreshing;
//                }
                
                if ( [[dict objectForKey:@"collentionList"] count] != 0) { // 有商户
                    for (int i = 0 ; i < [[dict objectForKey:@"collentionList"] count]; i++) {
                        BYC_BusinessModel *businessModel  = [[BYC_BusinessModel alloc] init];
                        [businessModel parse:[[dict objectForKey:@"collentionList"] objectAtIndex:i]];
                        if (businessModel.collectionId && ![businessModel.collectionId isEqual:@""]) {
                            businessModel.isChecked = NO;
                            [mArray addObject:businessModel];
                        }
                    }
                    self.rightButton.hidden = NO;
                }else{
                    
                    if ( _footer.refreshing && _collectionDataArray.count > 0) {
                        
                        [self showStringMsg:@"已经加载全部商户收藏啦!" andYOffset:0];
                    }else {
                        self.rightButton.hidden = YES;
                        [_collectionDataArray removeAllObjects];
                        [self.mainTableView reloadData];
//                        [self showStringMsg:@"亲,暂无收藏的商户,去收藏几个吧!" andYOffset:0];
                        [self showStringMsg:@"暂无收藏的商户!" andYOffset:0];
                    }
                }
                
                if (mArray.count > 0) {
                    
                    if (messagePageSize == 1) {
                        [_collectionDataArray removeAllObjects];
                        if (_header.refreshing) {
                            [self showStringMsg:@"更新成功！" andYOffset:0];
                        }
                    }
                    [_collectionDataArray addObjectsFromArray:mArray];
                    [mArray removeAllObjects];
                    [self.mainTableView reloadData];
                }
                
            }
                break;
            case 607: //取消商户收藏
                [self showStringMsg:@"删除成功" andYOffset:kYOffset];
                if (_mainRequestMerchant) {
                    [_mainRequestMerchant cancelRequest];
                    self.mainRequestMerchant = nil;
                }
                break;
            default:
                break;
        }
    } else {
        [_collectionDataArray removeAllObjects];
        self.rightButton.hidden = YES;
        [self showStringMsg:[dict objectForKey:@"message"] andYOffset:kYOffset];
    }
}


- (void)GCRequest:(GCRequest *)aRequest Error:(NSString *)aError
{
    [self hide];
    [self dismissWaitingView];
    NSLog(@"%@", aError);
    [self showStringMsg:@"网络连接失败！" andYOffset:kYOffset];
}

//时间戳排序
- (void)modelOrderByCreateTime:(NSMutableArray *)array{
    
    NSArray *myary = [array sortedArrayUsingComparator:^(BYC_BaseModel * obj1, BYC_BaseModel * obj2){
        return (NSComparisonResult)[obj1.create_time compare:obj2.create_time options:NSNumericSearch];
    }];
    
    //防止多次创建
    if (!_collectionDataArray) {
        
        _collectionDataArray = [NSMutableArray array];
    }
//    //上拉加载更新的时候，移除之前的数据。
//    if (isRefreshing) {
//        [_collectionDataArray removeAllObjects];
//        [self showStringMsg:@"更新成功！" andYOffset:0];
//    }
    //这里把此数组清空重新赋值
    [mArray removeAllObjects];
    for (BYC_BaseModel *model in [myary reverseObjectEnumerator]) {
        
        [mArray addObject:model];
    }
    if (messagePageSize == 1) {
        [_collectionDataArray removeAllObjects];
        if (_header.refreshing) {
            [self showStringMsg:@"更新成功！" andYOffset:0];
        }
    }
    //这里重新copy一份内存。
    [_collectionDataArray addObjectsFromArray:mArray];
    [mArray removeAllObjects];
    [self.mainTableView reloadData];
}


/**
 *  懒加载Vedio、商品和商户的请求
 */

-(GCRequest *)mainRequestVedio{
    
    if (_mainRequestVedio == nil) {
        
        _mainRequestVedio = [[GCRequest alloc] init];
        _mainRequestVedio.delegate=self;
        _mainRequestVedio.tag = 1303;
    }
    
    return _mainRequestVedio;
}


-(GCRequest *)mainRequestShop
{
    
    if (_mainRequestShop == nil) {
        _mainRequestShop = [[GCRequest alloc] init];
        _mainRequestShop.delegate=self;
        _mainRequestShop.tag = 507;
    }
    return _mainRequestShop;
}

-(GCRequest *)mainRequestMerchant
{
    
    if (_mainRequestMerchant == nil) {
        _mainRequestMerchant = [[GCRequest alloc] init];
        _mainRequestMerchant.delegate=self;
        _mainRequestMerchant.tag = 607;
    }
    return _mainRequestMerchant;
}


/**
 *  控制器销毁的时候清除网络请求
 */
- (void)dealloc
{
    
    [self deallocRequestVedioAndShop];
    
}


/**
 *  返回清除当前控制器的网络请求
 */
- (void)backButtonClick:(UIButton *)button
{
    
    [super backButtonClick:button];
    
    [self deallocRequestVedioAndShop];
}

/**
 *  清除网络请求
 */
- (void)deallocRequestVedioAndShop
{
    
    if (_mainRequestVedio) {
        [_mainRequestVedio cancelRequest];
        self.mainRequestVedio = nil;
    }
    
    if (_mainRequestShop) {
        [_mainRequestShop cancelRequest];
        self.mainRequestShop = nil;
    }
    
    if (_mainRequestMerchant) {
        [_mainRequestMerchant cancelRequest];
        self.mainRequestMerchant = nil;
    }
}

#pragma mark - 刷新加载
// 上拉加载更多
- (void)addFooter
{
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = _mainTableView;
    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        //  后台执行：
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            messagePageSize = messagePageSize + 1;
            [self requestCollectionData];
        });
    };
    _footer = footer;
}

// 下拉刷新
- (void)addHeader
{
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = _mainTableView;
    header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        //  后台执行：
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            messagePageSize = 1;
            [self requestCollectionData];
        });
    };
    //    [header beginRefreshing];
    _header = header;
}

#pragma mark 等待界面消失
- (void)dismissWaitingView
{
    if (self.mainTableView.editing) {
        [_delectedCollectionDataArray removeAllObjects];
        [self.rightButton setTitle:@"编辑" forState:UIControlStateNormal];
        self.mainTableView.editing = NO;
        self.deletedView.hidden = YES;
    }
    if (_header.refreshing) {
        [self doneWithView:_header];
    }
    if (_footer.refreshing) {
        [self doneWithView:_footer];
    }
}

- (void)doneWithView:(MJRefreshBaseView *)refreshView
{
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [refreshView endRefreshing];
}

#pragma mark 获取收藏请求
- (void) requestCollectionData {
    if (![GCUtil connectedToNetwork]) {
        [self dismissWaitingView];
        [self showStringMsg:@"网络连接失败" andYOffset:kYOffset];
    } else {
        
        [self showMsg:nil];
        switch (_collectionType) {
            case 0:
                mainRequest.tag = 1302;
                [mainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI collectionUserId:kkUserCenterId andType:@"1" andPage:[NSString stringWithFormat:@"%ld", (long)messagePageSize] andSize:@"10"]];
                break;
            case 1:
                mainRequest.tag = 506;
                [mainRequest requestHttpWithPost:SHANGCHENG_url withDict:[BXAPI goodsCollectionUserCenterId:kkUserCenterId andPage:[NSString stringWithFormat:@"%ld", (long)messagePageSize] andPageSize:@"10"]];
                break;
                
            case 2:
                mainRequest.tag = 606;
                [mainRequest requestHttpWithPost:NiceFood_Url withDict:[BXAPI merchantCollectionUserCenterId:kkUserCenterId andPage:[NSString stringWithFormat:@"%ld", (long)messagePageSize]]];
                break;
                
            default:
                break;
        }
        
    }
}

#pragma mark 取消收藏
/**
 *  取消收藏
 *
 *  cancelType :  0:视频 1:商品 2:商户
 *
 *
 *  @param objId      被操作对象的ID
 */
- (void) cancelCollectionDataObjectId:(NSString*)objId cancelType:(NSInteger)cancelType
{
    if (![GCUtil connectedToNetwork]) {
        [self showStringMsg:@"网络连接失败" andYOffset:kYOffset];
    } else {
        [self showMsg:nil];
        
        switch (cancelType) {
            case 0:
            {
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    
                    [self.mainRequestVedio requestHttpWithPost:CHONG_url withDict:[BXAPI ZanOrCollectionCancleWithUserID:kkUserCenterId andObjId:objId andJoinType:@"2" andObjectType:@"1"]];
                });
            }
                break;
            case 1:
            {
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    
                    [self.mainRequestShop requestHttpWithPost:SHANGCHENG_url withDict:[BXAPI deleteGoodCollectionUserCenterId:kkUserCenterId andCollectionId:objId]];
                });
                
            }
                break;
            case 2:
            {
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    
                    [self.mainRequestMerchant requestHttpWithPost:NiceFood_Url withDict:[BXAPI deleteMerchantCollectionUserCenterId:kkUserCenterId andCollectionId:objId]];
                });
            }
                break;
                
            default:
                break;
        }
    }
}


#pragma mark 编辑收藏
- (void) setEditing:(BOOL)editting animated:(BOOL)animated
{
    [_delectedCollectionDataArray removeAllObjects];
    if (self.mainTableView.editing) {
        for (CollectionMessageModel *model in _collectionDataArray) {
            model.isChecked = NO;
        }
    }
    
    [self.deletedButton setTitle:@"删除" forState:UIControlStateNormal];
    [self.rightButton setTitle:(self.mainTableView.editing ? @"编辑":@"取消") forState:UIControlStateNormal];
    [self.mainTableView setEditing:!self.mainTableView.editing animated:YES];
    self.deletedView.hidden = !self.deletedView.hidden;
    [self.mainTableView performSelector:@selector(reloadData) withObject:nil afterDelay:0.3];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _collectionDataArray.count;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.mainTableView.editing) {
        return UITableViewCellEditingStyleNone;
    } else return UITableViewCellEditingStyleDelete;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 93;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    NSLog(@"_collectionDataArray = %@",_collectionDataArray);
    
    switch (_collectionType) {
        case 0:
        {
            static  NSString *collectionIndfier = @"collectionVedioIndfier";
            CollectionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:collectionIndfier];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"CollectionTableViewCell" owner:self options:nil]lastObject];
            }
            CollectionMessageModel *model = [_collectionDataArray objectAtIndex:indexPath.section];
            [cell parseWithPrizeModel:model];
            [cell setChecked:model.isChecked];
            return cell;
        }
            break;
        case 1:
        {
            static  NSString *collectionIndfier = @"collectionShoppingIndfier";
            CollectionCommodityTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:collectionIndfier];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"CollectionCommodityTableViewCell" owner:self options:nil]lastObject];
            }
            CommodityModel *model = [_collectionDataArray objectAtIndex:indexPath.section];
            [cell commodityWithCollectionCommodityModel:model andhostImageUrl:self.hostImageurl];
            [cell setChecked:model.isChecked];
            return cell;
        }
            break;
            
        case 2:
        {
            static  NSString *collectionBusinessIndfier = @"collectionBusinessIndfier";
            CollectionBusinessTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:collectionBusinessIndfier];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"CollectionBusinessTableViewCell" owner:self options:nil]lastObject];
            }
            BYC_BusinessModel *model = [_collectionDataArray objectAtIndex:indexPath.section];
            [cell businessWithCollectionBusinessModel:model];
            [cell setChecked:model.isChecked];
            
            return cell;
        }
            break;
        default:
            return nil;
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.mainTableView.editing) {
        switch (_collectionType) {
            case 0:
            {
                CollectionMessageModel *model = [_collectionDataArray objectAtIndex:indexPath.section];
                CollectionTableViewCell *cell = (CollectionTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
                model.isChecked = !model.isChecked;
                [cell setChecked:model.isChecked];
                if (model.isChecked) { // 选中
                    if (_delectedCollectionDataArray.count > 0) {
                        BOOL isCommon = NO; // 是否有相同
                        for (CollectionMessageModel *tempModel in _delectedCollectionDataArray) {
                            if ([model.collectionId isEqual:tempModel.collectionId]) {
                                isCommon = YES;
                            }
                        }
                        if (!isCommon) {
                            [_delectedCollectionDataArray addObject:model];
                            [self.deletedButton setTitle:[NSString stringWithFormat:@"删除（%lu）", (unsigned long)_delectedCollectionDataArray.count] forState:UIControlStateNormal];
                        }
                    } else {
                        [_delectedCollectionDataArray addObject:model];
                        [self.deletedButton setTitle:[NSString stringWithFormat:@"删除（%lu）", (unsigned long)_delectedCollectionDataArray.count] forState:UIControlStateNormal];
                        self.deletedButton.titleLabel.text = [NSString stringWithFormat:@"删除（%lu）", (unsigned long)_delectedCollectionDataArray.count];
                    }
                }
                else {
                    [_delectedCollectionDataArray removeObject:model];
                    [self.deletedButton setTitle:[NSString stringWithFormat:@"删除（%lu）", (unsigned long)_delectedCollectionDataArray.count] forState:UIControlStateNormal];
                }
            }
                break;
            case 1:
            {
                CommodityModel* model = [_collectionDataArray objectAtIndex:indexPath.section];
                CollectionCommodityTableViewCell *cell = (CollectionCommodityTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
                model.isChecked = !model.isChecked;
                [cell setChecked:model.isChecked];
                if (model.isChecked) { // 选中
                    if (_delectedCollectionDataArray.count > 0) {
                        BOOL isCommon = NO; // 是否有相同
                        for (CommodityModel *tempModel in _delectedCollectionDataArray) {
                            if ([model.collectionId isEqual:tempModel.collectionId]) {
                                isCommon = YES;
                            }
                        }
                        if (!isCommon) {
                            [_delectedCollectionDataArray addObject:model];
                            [self.deletedButton setTitle:[NSString stringWithFormat:@"删除（%lu）", (unsigned long)_delectedCollectionDataArray.count] forState:UIControlStateNormal];
                        }
                    } else {
                        [_delectedCollectionDataArray addObject:model];
                        [self.deletedButton setTitle:[NSString stringWithFormat:@"删除（%lu）", (unsigned long)_delectedCollectionDataArray.count] forState:UIControlStateNormal];
                        self.deletedButton.titleLabel.text = [NSString stringWithFormat:@"删除（%lu）", (unsigned long)_delectedCollectionDataArray.count];
                    }
                } else {
                    [_delectedCollectionDataArray removeObject:model];
                    [self.deletedButton setTitle:[NSString stringWithFormat:@"删除（%lu）", (unsigned long)_delectedCollectionDataArray.count] forState:UIControlStateNormal];
                }
            }
                break;
            case 2:
            {
                CollectionMessageModel *model = [_collectionDataArray objectAtIndex:indexPath.section];
                CollectionBusinessTableViewCell *cell = (CollectionBusinessTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
                model.isChecked = !model.isChecked;
                [cell setChecked:model.isChecked];
                if (model.isChecked) { // 选中
                    if (_delectedCollectionDataArray.count > 0) {
                        BOOL isCommon = NO; // 是否有相同
                        for (CollectionMessageModel *tempModel in _delectedCollectionDataArray) {
                            if ([model.collectionId isEqual:tempModel.collectionId]) {
                                isCommon = YES;
                            }
                        }
                        if (!isCommon) {
                            [_delectedCollectionDataArray addObject:model];
                            [self.deletedButton setTitle:[NSString stringWithFormat:@"删除（%lu）", (unsigned long)_delectedCollectionDataArray.count] forState:UIControlStateNormal];
                        }
                    } else {
                        [_delectedCollectionDataArray addObject:model];
                        [self.deletedButton setTitle:[NSString stringWithFormat:@"删除（%lu）", (unsigned long)_delectedCollectionDataArray.count] forState:UIControlStateNormal];
                        self.deletedButton.titleLabel.text = [NSString stringWithFormat:@"删除（%lu）", (unsigned long)_delectedCollectionDataArray.count];
                    }
                }
                else {
                    [_delectedCollectionDataArray removeObject:model];
                    [self.deletedButton setTitle:[NSString stringWithFormat:@"删除（%lu）", (unsigned long)_delectedCollectionDataArray.count] forState:UIControlStateNormal];
                }
            }
                break;
            default:
                break;
        }
    } else {
        switch (_collectionType) {
            case 0:
            {
                CollectionMessageModel *model = [_collectionDataArray objectAtIndex:indexPath.section];
                if ([model.status intValue] == 1) { // 1是存在，2是不存在
                    PRJ_VideoDetailViewController *detail = [[PRJ_VideoDetailViewController alloc] initWithNibName:@"PRJ_VideoDetailViewController" bundle:nil];
                    detail.videoID = model.collectionId;
                    [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
                    [self.navigationController pushViewController:detail animated:YES];
                } else [self showStringMsg:@"视频已被删除" andYOffset:kYOffset];
            }
                break;
            case 1:
            {
                CommodityModel *model = [_collectionDataArray objectAtIndex:indexPath.section];
                LSYGoodsInfoViewController * detailViewControl = [[LSYGoodsInfoViewController alloc]initWithNibName:@"LSYGoodsInfoViewController" bundle:nil];
                detailViewControl.isSeckilling = NO;
                detailViewControl.goods_id = model.collectionId;
                [self.navigationController pushViewController:detailViewControl animated:YES];
            }
                break;
            case 2:
            {
                BYC_BusinessModel *model = [_collectionDataArray objectAtIndex:indexPath.section];
                ListTableViewController  *list = [[ListTableViewController alloc]init];
                //商户id到这
                list.ownerId = model.collectionId;
                [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
                [self.navigationController pushViewController:list  animated:YES];
            }
                break;
            default:
                break;
        }
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) { // 删除
        
        switch (_collectionType) {
            case 0:
            {
                CollectionMessageModel *model = [_collectionDataArray objectAtIndex:indexPath.section];
                [self cancelCollectionDataObjectId:model.collectionId cancelType:0];
            }
                break;
            case 1:
            {
                CommodityModel *model = [_collectionDataArray objectAtIndex:indexPath.section];
                [self cancelCollectionDataObjectId:model.collectionId cancelType:1];
            }
                break;
            case 2:
            {
                BYC_BusinessModel *model = [_collectionDataArray objectAtIndex:indexPath.section];
                [self cancelCollectionDataObjectId:model.collectionId cancelType:2];
            }
                break;
                
            default:
                break;
        }
        
        [_collectionDataArray removeObjectAtIndex:indexPath.section];
        // Delete the row from the data source
        [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
        
        if (_collectionDataArray.count <= 0) {
            self.rightButton.hidden = YES;
        }
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

#pragma mark 删除收藏
- (IBAction)deletedBtnAction:(id)sender {
    // 删除收藏
    if (_delectedCollectionDataArray.count > 0) {
        
        NSMutableArray *deleteCollectionMessageModels = [NSMutableArray array];
        
        NSMutableArray *deleteCommodityModel          = [NSMutableArray array];
        
        NSMutableArray *deleteMerchantModel          = [NSMutableArray array];
        
        for (BYC_BaseModel *model in _delectedCollectionDataArray) {
            
            switch (_collectionType) {
                case 0:
                    [deleteCollectionMessageModels addObject:model];
                    break;
                case 1:
                    [deleteCommodityModel addObject:model];
                    break;
                case 2:
                    [deleteMerchantModel addObject:model];
                    break;
                default:
                    break;
            }
        }
        
        if (deleteCollectionMessageModels.count > 0) { // 视频
            NSMutableString *delectedId = [NSMutableString string];
            for (int i = 0; i < deleteCollectionMessageModels.count; i++) {
                CollectionMessageModel *model = [deleteCollectionMessageModels objectAtIndex:i];
                if (i == deleteCollectionMessageModels.count - 1) {
                    [delectedId appendString:[NSString stringWithFormat:@"%@", model.collectionId]];
                }else [delectedId appendString:[NSString stringWithFormat:@"%@,", model.collectionId]];
                [_collectionDataArray removeObject:model];
            }
            
            [self cancelCollectionDataObjectId:delectedId cancelType:0];
        }
        
        if (deleteCommodityModel.count > 0){ // 商品
            NSMutableString *delectedId = [NSMutableString string];
            for (int i = 0; i < deleteCommodityModel.count; i++) {
                CommodityModel *model = [deleteCommodityModel objectAtIndex:i];
                if (i == deleteCommodityModel.count - 1) {
                    [delectedId appendString:[NSString stringWithFormat:@"%@", model.collectionId]];
                }else [delectedId appendString:[NSString stringWithFormat:@"%@,", model.collectionId]];
                [_collectionDataArray removeObject:model];
            }
            
            [self cancelCollectionDataObjectId:delectedId cancelType:1];
        }
        
        if (deleteMerchantModel.count > 0 ) { //商户
            NSMutableString *delectedId = [NSMutableString string];
            for (int i = 0; i < deleteMerchantModel.count; i++) {
                BYC_BusinessModel *model = [deleteMerchantModel objectAtIndex:i];
                if (i == deleteMerchantModel.count - 1) {
                    [delectedId appendString:[NSString stringWithFormat:@"%@", model.collectionId]];
                }else [delectedId appendString:[NSString stringWithFormat:@"%@,", model.collectionId]];
                [_collectionDataArray removeObject:model];
            }
            
            [self cancelCollectionDataObjectId:delectedId cancelType:2];
        }
        
        
        if (_collectionDataArray.count <= 0) {
            self.rightButton.hidden = YES;
        }
        
        self.mainTableView.editing = NO;
        [self.rightButton setTitle:@"编辑" forState:UIControlStateNormal];
        [self.mainTableView reloadData];
        
        //self.tableView.frame = CGRectMake(ORIGIN_X(self.tableView), ORIGIN_Y(self.tableView), SCREENWIDTH, SCREENHEIGHT - 24);
        self.deletedView.hidden = YES;
        [self.deletedButton setTitle:@"删除" forState:UIControlStateNormal];
        [_delectedCollectionDataArray removeAllObjects];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

////  个人收藏
////  CollectionViewController.m
////  ChillingAmend
////
////  Created by 许文波 on 14/12/20.
////  Copyright (c) 2014年 SinoGlobal. All rights reserved.
////
//
//#import "CollectionViewController.h"
//#import "CollectionTableViewCell.h"
//#import "DOPDropDownMenu.h"
//#import "MJRefresh.h"
//#import "CollectionMessageModel.h"
//#import "PRJ_VideoDetailViewController.h"
//#import "CollectionCommodityTableViewCell.h"
//#import "CommodityModel.h"
//#import "LSYGoodsInfoViewController.h"
//#import "CollectionBusinessTableViewCell.h"
//
//#define kYOffset 0 // 提示框偏移量
//
//@interface CollectionViewController ()<DOPDropDownMenuDataSource, DOPDropDownMenuDelegate, UITableViewDelegate, UITableViewDataSource>
//{
//    NSMutableArray *_collectionDataArray; // 收藏数组
//    NSString *currentCollection; // 当前收藏分类
//    NSMutableArray *_delectedCollectionDataArray; // 要删除的collection
//    MJRefreshHeaderView *_header; // 下拉刷新
//    MJRefreshFooterView *_footer; // 上拉刷新
//    NSInteger messagePageSize; // 页码
//    NSMutableArray *mArray;
//    
//    BOOL isRefreshing; //是否是下拉刷新
//    /**
//     *  暂无视频收藏
//     */
//    BOOL isNotVedioNum;
//    /**
//     *  暂无商品收藏
//     */
//    BOOL isNotShopNum;
//    /**
//     *  暂无商户收藏
//     */
//    BOOL isNotMerchantNum;
//
//    
//   }
//
///**
// *  删除Vedio收藏使用的请求
// */
//@property (strong, nonatomic) GCRequest *mainRequestVedio;
//
///**
// *  删除商品使用的请求
// */
//@property (strong, nonatomic) GCRequest *mainRequestShop;
//
///**
// *  删除商户使用的请求
// */
//@property (strong, nonatomic) GCRequest *mainRequestMerchant;
//
//@property (nonatomic, copy) NSArray *collectionClassification; // 收藏分类
//@property (weak, nonatomic) IBOutlet UITableView *tableView; // 列表
//@property (weak, nonatomic) IBOutlet UIButton *deletedButton; // 删除
//@property (weak, nonatomic) IBOutlet UIView *deletedView; // 删除的view
//
//@property (copy, nonatomic) NSString *hostImageurl;//图片头地址
//
//- (IBAction)deletedBtnAction:(id)sender;
//
//@end
//
//@implementation CollectionViewController
//
//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:YES];
//    self.navigationController.navigationBarHidden = YES;
//}
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//
//    // 导航栏
//    [self setNavigationBarWithState:1 andIsHideLeftBtn:NO andTitle:@"收藏"];
//    // 右键
//    [self addRightBarButtonItemWithImageName:@"" andTargate:@selector(setEditing:animated:) andRightItemFrame:CGRectMake(SCREENWIDTH - 50, 20, 60, 44) andButtonTitle:@"编辑" andTitleColor:[UIColor colorWithRed:61/255.0 green:66/255.0 blue:69/255.0 alpha:1.0]];
//    //self.tableView.frame = CGRectMake(ORIGIN_X(self.tableView), ORIGIN_Y(self.tableView), SCREENWIDTH, SCREENHEIGHT - 24);
//    // 收藏分类
//    self.collectionClassification = [NSArray arrayWithObjects:@"视频", @"商品", nil];
//    messagePageSize = 1;
//    // 下拉选项
//    DOPDropDownMenu *menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 65) andHeight:40];
//    menu.dataSource = self;
//    menu.delegate = self;
////    [self.view addSubview:menu];
//    // table相关操作
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
//    self.tableView.backgroundColor = [UIColor clearColor];
//    self.tableView.allowsSelectionDuringEditing = YES;
//    _collectionDataArray = [[NSMutableArray alloc] init];
//    _delectedCollectionDataArray = [[NSMutableArray alloc] init];
//    mArray = [NSMutableArray array];
//    currentCollection = @"1";
//    if (![GCUtil connectedToNetwork]) {
//        [self showStringMsg:@"网络连接失败" andYOffset:kYOffset];
//    } else {
//        [self requestCollectionData:@"1"];
//    }
//    [self addHeader];
//    [self addFooter];
//    
//}
///**
// *  懒加载Vedio、商品和商户的请求
// */
//
//-(GCRequest *)mainRequestVedio{
//
//    if (_mainRequestVedio == nil) {
//        
//        _mainRequestVedio = [[GCRequest alloc] init];
//        _mainRequestVedio.delegate=self;
//        _mainRequestVedio.tag = 1303;
//    }
//    
//    return _mainRequestVedio;
//}
//
//
//-(GCRequest *)mainRequestShop
//{
//
//    if (_mainRequestShop == nil) {
//        _mainRequestShop = [[GCRequest alloc] init];
//        _mainRequestShop.delegate=self;
//        _mainRequestShop.tag = 507;
//    }
//    return _mainRequestShop;
//}
//
//-(GCRequest *)mainRequestMerchant
//{
//    
//    if (_mainRequestMerchant == nil) {
//        _mainRequestMerchant = [[GCRequest alloc] init];
//        _mainRequestMerchant.delegate=self;
//        _mainRequestMerchant.tag = 607;
//    }
//    return _mainRequestMerchant;
//}
//
//
///**
// *  控制器销毁的时候清除网络请求
// */
//- (void)dealloc
//{
//
//    [self deallocRequestVedioAndShop];
//
//}
//
//
///**
// *  返回清除当前控制器的网络请求
// */
//- (void)backButtonClick:(UIButton *)button
//{
//
//    [super backButtonClick:button];
//    
//    [self deallocRequestVedioAndShop];
//}
//
///**
// *  清除网络请求
// */
//- (void)deallocRequestVedioAndShop
//{
//
//    if (_mainRequestVedio) {
//        [_mainRequestVedio cancelRequest];
//        self.mainRequestVedio = nil;
//    }
//    
//    if (_mainRequestShop) {
//        [_mainRequestShop cancelRequest];
//        self.mainRequestShop = nil;
//    }
//    
//    if (_mainRequestMerchant) {
//        [_mainRequestMerchant cancelRequest];
//        self.mainRequestMerchant = nil;
//    }
//}
//
//#pragma mark - 刷新加载
//// 上拉加载更多
//- (void)addFooter
//{
//    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
//    footer.scrollView = _tableView;
//    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
//        //  后台执行：
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            messagePageSize = messagePageSize + 1;
//            [self requestCollectionData:@"1"];
//        });
//    };
//    _footer = footer;
//}
//
//// 下拉刷新
//- (void)addHeader
//{
//    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
//    header.scrollView = _tableView;
//    NSLog(@"%f",header.frame.origin.x);
//    NSLog(@"%f",header.frame.origin.y);
//    NSLog(@"%f",header.frame.size.width);
//    NSLog(@"%f",header.frame.size.height);
//    header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
//        //  后台执行：
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            messagePageSize = 1;
//            [self requestCollectionData:@"1"];
//        });
//    };
//    //    [header beginRefreshing];
//    _header = header;
//}
//
//- (void)doneWithView:(MJRefreshBaseView *)refreshView
//{
//    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
//    [refreshView endRefreshing];
//}
//
//#pragma mark 等待界面消失
//- (void)dismissWaitingView
//{
//    if (self.tableView.editing) {
//        [_delectedCollectionDataArray removeAllObjects];
//        [self.rightButton setTitle:@"编辑" forState:UIControlStateNormal];
//        //self.tableView.frame = CGRectMake(ORIGIN_X(self.tableView), ORIGIN_Y(self.tableView), SCREENWIDTH, SCREENHEIGHT - 24);
//        self.tableView.editing = NO;
//        self.deletedView.hidden = YES;
//    }
//    if (_header.refreshing) {
//        [self doneWithView:_header];
//    }
//    if (_footer.refreshing) {
//        [self doneWithView:_footer];
//    }
//}
//
//
//#pragma mark 获取收藏请求
//- (void) requestCollectionData:(NSString*)type
//{
//    if (![GCUtil connectedToNetwork]) {
//        [self dismissWaitingView];
//        [self showStringMsg:@"网络连接失败" andYOffset:kYOffset];
//    } else {
//        [self showMsg:nil];
//        currentCollection = type;
//        if (type.intValue == 1) { // 视频
//            mainRequest.tag = 1302;
//            [mainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI collectionUserId:kkUserCenterId andType:type andPage:[NSString stringWithFormat:@"%ld", (long)messagePageSize] andSize:@"10"]];
//        } else if ( type.intValue == 2 ){
//            mainRequest.tag = 506;
//            [mainRequest requestHttpWithPost:SHANGCHENG_url withDict:[BXAPI goodsCollectionUserCenterId:kkUserCenterId andPage:[NSString stringWithFormat:@"%ld", (long)messagePageSize] andPageSize:@"10"]];
//        } else {
//            mainRequest.tag = 606;
//            [mainRequest requestHttpWithPost:NiceFood_Url withDict:[BXAPI merchantCollectionUserCenterId:kkUserCenterId andPage:[NSString stringWithFormat:@"%ld", (long)messagePageSize]]];
//            
//        }
//    }
//}
//
////#pragma mark 取消收藏
/////**
//// *  取消收藏
//// *
//// *  @param objId      被操作对象的ID
//// */
////- (void) cancelCollectionDataObjectId:(NSString*)objId isVedio:(BOOL)isVedio
////{
////    if (![GCUtil connectedToNetwork]) {
////        [self showStringMsg:@"网络连接失败" andYOffset:kYOffset];
////    } else {
////        [self showMsg:nil];
////        if (isVedio) { // 视频
////            dispatch_async(dispatch_get_global_queue(0, 0), ^{
////            
////                [self.mainRequestVedio requestHttpWithPost:CHONG_url withDict:[BXAPI ZanOrCollectionCancleWithUserID:kkUserCenterId andObjId:objId andJoinType:@"2" andObjectType:currentCollection]];
////            });
////        } else { // 商品
////            dispatch_async(dispatch_get_global_queue(0, 0), ^{
////            
////                [self.mainRequestShop requestHttpWithPost:SHANGCHENG_url withDict:[BXAPI deleteGoodCollectionUserCenterId:kkUserCenterId andCollectionId:objId]];
////            });
////        }
////    }
////}
//
//#pragma mark 取消收藏
///**
// *  取消收藏
// *
// *  cancelType :  0:视频 1:商品 2:商户
// *
// *
// *  @param objId      被操作对象的ID
// */
//- (void) cancelCollectionDataObjectId:(NSString*)objId cancelType:(NSInteger)cancelType
//{
//    if (![GCUtil connectedToNetwork]) {
//        [self showStringMsg:@"网络连接失败" andYOffset:kYOffset];
//    } else {
//        [self showMsg:nil];
//
//        switch (cancelType) {
//            case 0:
//            {
//                dispatch_async(dispatch_get_global_queue(0, 0), ^{
//                    
//                    [self.mainRequestVedio requestHttpWithPost:CHONG_url withDict:[BXAPI ZanOrCollectionCancleWithUserID:kkUserCenterId andObjId:objId andJoinType:@"2" andObjectType:currentCollection]];
//                                });
//            }
//                break;
//            case 1:
//            {
//                dispatch_async(dispatch_get_global_queue(0, 0), ^{
//                    
//                    [self.mainRequestShop requestHttpWithPost:SHANGCHENG_url withDict:[BXAPI deleteGoodCollectionUserCenterId:kkUserCenterId andCollectionId:objId]];
//                });
//
//            }
//                break;
//            case 2:
//            {
//                dispatch_async(dispatch_get_global_queue(0, 0), ^{
//                    
//                    [self.mainRequestMerchant requestHttpWithPost:NiceFood_Url withDict:[BXAPI deleteMerchantCollectionUserCenterId:kkUserCenterId andCollectionId:objId]];
//                });
//            }
//                break;
//                
//            default:
//                break;
//        }
//    }
//}
//
//#pragma mark GCRequestDelegate
//- (void)GCRequest:(GCRequest *)aRequest Finished:(NSString *)aString
//{
//    NSLog(@"collection = %@", aString);
//    [self hide];
//    [self dismissWaitingView];
//    NSMutableDictionary *dict = [aString JSONValue];
//    if ( !dict ) {
//        [self showStringMsg:@"网络连接失败" andYOffset:0];
//        return;
//    }
//    
//    if ([[dict objectForKey:@"code"] intValue] == 0) { // 有返回
//        
//        
//        switch (aRequest.tag) {
//            case 1302: // 视频收藏
//                {
//                    if (_header.refreshing) {
//                        
//                        isRefreshing = _header.refreshing;
//                    }else{
//                        
//                        isRefreshing = _header.refreshing;
//                    }
//                    if ([[dict objectForKey:@"collect"] count] != 0) { // 有收藏
//                        for (int i = 0 ; i < [[dict objectForKey:@"collect"] count]; i++) {
//                            CollectionMessageModel *collectionModel  = [[CollectionMessageModel alloc] init];
//                            [collectionModel parse:[[dict objectForKey:@"collect"] objectAtIndex:i]];
//                            if (collectionModel.collectionId && ![collectionModel.collectionId isEqual:@""]) {
//                                collectionModel.isChecked = NO;
//                                [mArray addObject:collectionModel];
//                            }
//                        }
////                        if (_collectionDataArray.count <= 0) {
////                            self.rightButton.hidden = YES;
////                        } else self.rightButton.hidden = NO;
//                    }else{
//                    
//                        isNotVedioNum = YES;
//                    }
////                    else {
////                        if (_footer.isRefreshing) {
////                            [self showStringMsg:@"没有更多视频收藏" andYOffset:kYOffset];
////                        } else {
////                            [self showStringMsg:@"没有视频收藏" andYOffset:kYOffset];
////                            if (_collectionDataArray.count <= 0) {
////                                self.rightButton.hidden = YES;
////                            }
////                        }
////                    }
//                    
//                    mainRequest.tag = 506;
//                    [mainRequest requestHttpWithPost:SHANGCHENG_url withDict:[BXAPI goodsCollectionUserCenterId:kkUserCenterId andPage:[NSString stringWithFormat:@"%ld", (long)messagePageSize] andPageSize:@"10"]];
//                }
//                break;
//            case 1303: // 取消视频收藏
//                [self showStringMsg:@"删除成功" andYOffset:kYOffset];
//                if (_mainRequestVedio) {
//                    [_mainRequestVedio cancelRequest];
//                    self.mainRequestVedio = nil;
//                }
//                break;
//            case 506: // 商品收藏
//                {
////                    if (_header.refreshing) {
////                        [_collectionDataArray removeAllObjects];
////                    }
//                    if ( [[dict objectForKey:@"list"] count] != 0) { // 有收藏
//                        self.hostImageurl = dict[@"host"];
//                        for (int i = 0 ; i < [[dict objectForKey:@"list"] count]; i++) {
//                            CommodityModel *commodityModel  = [[CommodityModel alloc] init];
//                            [commodityModel parse:[[dict objectForKey:@"list"] objectAtIndex:i]];
//                            if (commodityModel.collectionId && ![commodityModel.collectionId isEqual:@""]) {
//                                commodityModel.isChecked = NO;
//                                [mArray addObject:commodityModel];
//                            }
//                        }
//                        if (mArray.count <= 0) {
//                            self.rightButton.hidden = YES;
//                        } else self.rightButton.hidden = NO;
//                    }else{
//                    
//                        if (isNotVedioNum ) {
//                            
//                            if ( _footer.refreshing && _collectionDataArray.count > 0) {
//                                
//                                [self showStringMsg:@"亲,已经加载全部收藏啦!" andYOffset:0];
//                            }else {
//                            
//                                [self showStringMsg:@"亲,暂无收藏,去收藏几个吧!" andYOffset:0];
//                            }
//                        }
//                    }
//                    
//                    
//                    if (mArray.count > 0) {
//                        
//                        [self modelOrderByCreateTime:mArray];
//                    }
//                    
////                    else{
////                        if (_footer.isRefreshing) {
////                            [self showStringMsg:@"没有更多商品收藏" andYOffset:kYOffset];
////                        } else {
////                            [self showStringMsg:@"没有商品收藏" andYOffset:kYOffset];
////                            if (_collectionDataArray.count <= 0) {
////                                self.rightButton.hidden = YES;
////                            }
////                        }
////                    }
//                }
//                break;
//            case 507: // 取消商品收藏
//                [self showStringMsg:@"删除成功" andYOffset:kYOffset];
//                if (_mainRequestShop) {
//                    [_mainRequestShop cancelRequest];
//                    self.mainRequestShop = nil;
//                }
//                break;
//            case 606: //收藏的商户 NiceFood_ImageUrl
//                {
//                    
//                }
//                break;
//            case 607: //取消商户收藏
//                [self showStringMsg:@"删除成功" andYOffset:kYOffset];
//                if (_mainRequestMerchant) {
//                    [_mainRequestMerchant cancelRequest];
//                    self.mainRequestMerchant = nil;
//                }
//                break;
//            default:
//                break;
//        }
//    } else {
//        [_collectionDataArray removeAllObjects];
//        self.rightButton.hidden = YES;
//        [self showStringMsg:[dict objectForKey:@"message"] andYOffset:kYOffset];
//    }
//    
//    ////self.tableView.frame = CGRectMake(ORIGIN_X(self.tableView), ORIGIN_Y(self.tableView), SCREENWIDTH, SCREENHEIGHT - 24);
//}
//
//- (void)GCRequest:(GCRequest *)aRequest Error:(NSString *)aError
//{
//    [self hide];
//    [self dismissWaitingView];
//    NSLog(@"%@", aError);
//    [self showStringMsg:@"网络连接失败！" andYOffset:kYOffset];
//    //self.tableView.frame = CGRectMake(ORIGIN_X(self.tableView), ORIGIN_Y(self.tableView), SCREENWIDTH, SCREENHEIGHT - 24);
//}
//
//
////时间戳排序
//- (void)modelOrderByCreateTime:(NSMutableArray *)array{
//
//    NSArray *myary = [array sortedArrayUsingComparator:^(BYC_BaseModel * obj1, BYC_BaseModel * obj2){
//            return (NSComparisonResult)[obj1.create_time compare:obj2.create_time options:NSNumericSearch];
//        }];
//    
//    //防止多次创建
//    if (!_collectionDataArray) {
//        
//        _collectionDataArray = [NSMutableArray array];
//    }
//    
//    //上拉加载更新的时候，移除之前的数据。
//    if (isRefreshing) {
//        [_collectionDataArray removeAllObjects];
//        [self showStringMsg:@"更新成功！" andYOffset:0];
//    }
//
//    //这里把此数组清空重新赋值
//        [mArray removeAllObjects];
//
//    for (BYC_BaseModel *model in [myary reverseObjectEnumerator]) {
//        
//        [mArray addObject:model];
//    }
//    
//    //这里重新copy一份内存。
//    [_collectionDataArray addObjectsFromArray:mArray];
//    [mArray removeAllObjects];
//    [_tableView reloadData];
//}
//
//#pragma mark 编辑收藏
//- (void) setEditing:(BOOL)editting animated:(BOOL)animated
//{
//    [_delectedCollectionDataArray removeAllObjects];
//    if (self.tableView.editing) {
//        for (CollectionMessageModel *model in _collectionDataArray) {
//            model.isChecked = NO;
//        }
//    }
//    
//    [self.deletedButton setTitle:@"删除" forState:UIControlStateNormal];
//    //self.tableView.frame = CGRectMake(ORIGIN_X(self.tableView), ORIGIN_Y(self.tableView), SCREENWIDTH, SCREENHEIGHT - 24 - (self.tableView.editing ? 0 : 60));
//    [self.rightButton setTitle:(self.tableView.editing ? @"编辑":@"取消") forState:UIControlStateNormal];
//    [self.tableView setEditing:!self.tableView.editing animated:YES];
//    self.deletedView.hidden = !self.deletedView.hidden;
//    [self.tableView performSelector:@selector(reloadData) withObject:nil afterDelay:0.3];
//}
//
//#pragma mark - DOPDropDownMenuDelegate
//
//- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column {
//    return self.collectionClassification.count;
//}
//
//- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath {
//    switch (indexPath.column) {
//        case 0:
//            return self.collectionClassification[indexPath.row];
//            break;
//        default:
//            return nil;
//            break;
//    }
//}
//
//- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath {
//    NSLog(@"%@ column:%li row:%li", [menu titleForRowAtIndexPath:indexPath], (long)indexPath.column, (long)indexPath.row);
//    if (indexPath.column == 0) {
//        // 切换之前清除数据
//        [_collectionDataArray removeAllObjects];
//        [_delectedCollectionDataArray removeAllObjects];
//        messagePageSize = 1;
//        switch (indexPath.row) {
//            case 0: // 视频
//                [self requestCollectionData:@"1"];
//                break;
//            case 1: // 商品
//                [self requestCollectionData:@"2"];
//                break;
//            case 2: // 商户
//                [self requestCollectionData:@"3"];
//                break;
//            default:
//                break;
//        }
//        if (self.tableView.editing) {
//            [self.rightButton setTitle:@"编辑" forState:UIControlStateNormal];
//            self.deletedView.hidden = YES;
//            [self.deletedButton setTitle:@"删除" forState:UIControlStateNormal];
//            self.tableView.editing = NO;
//        }
//    }
//}
//
//#pragma mark - Table view data source
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    // Return the number of rows in the section.
//    return 1;
//}
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return _collectionDataArray.count;
//}
//
////- (void)scrollViewDidScroll:(UIScrollView *)scrollView
////
////{
////    if (scrollView == self.tableView) {
////        CGFloat sectionHeaderHeight = - 10;
////        if (scrollView.contentOffset.y <= sectionHeaderHeight&&scrollView.contentOffset.y >= 0) {
////            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
////        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
////            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
////        }
////    }
////}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//
//    NSLog(@"_collectionDataArray = %@",_collectionDataArray);
//    
//    if ([_collectionDataArray[indexPath.section] isKindOfClass:[CollectionMessageModel class]]) { // 视频
//          static  NSString *collectionIndfier = @"collectionVedioIndfier";
//        CollectionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:collectionIndfier];
//        if (cell == nil) {
//            cell = [[[NSBundle mainBundle]loadNibNamed:@"CollectionTableViewCell" owner:self options:nil]lastObject];
//        }
//        CollectionMessageModel *model = [_collectionDataArray objectAtIndex:indexPath.section];
//        [cell parseWithPrizeModel:model];
//        [cell setChecked:model.isChecked];
//        return cell;
//    } else if ([_collectionDataArray[indexPath.section] isKindOfClass:[CommodityModel class]]) { // 商品
//          static  NSString *collectionIndfier = @"collectionShoppingIndfier";
//        CollectionCommodityTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:collectionIndfier];
//        if (cell == nil) {
//            cell = [[[NSBundle mainBundle]loadNibNamed:@"CollectionCommodityTableViewCell" owner:self options:nil]lastObject];
//        }
//        CommodityModel *model = [_collectionDataArray objectAtIndex:indexPath.section];
//        [cell commodityWithCollectionCommodityModel:model andhostImageUrl:self.hostImageurl];
//        [cell setChecked:model.isChecked];
//        return cell;
//    }
//    else {
//        static  NSString *collectionBusinessIndfier = @"collectionBusinessIndfier";
//        CollectionBusinessTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:collectionBusinessIndfier];
//        if (cell == nil) {
//            cell = [[[NSBundle mainBundle]loadNibNamed:@"CollectionBusinessTableViewCell" owner:self options:nil]lastObject];
//        }
////        PRJ_BusinessList *model = [_collectionDataArray objectAtIndex:indexPath.section];
////        [cell businessCollectionWithCollectionBusinessModel:model];
//        return cell;
//    }
//}
//
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (self.tableView.editing) {
//        return UITableViewCellEditingStyleNone;
//    } else return UITableViewCellEditingStyleDelete;
//}
//
////#pragma mark 取消section header 粘滞效果
////- (void)scrollViewDidScroll:(UIScrollView *)scrollView
////{
////    //added 2013.11.28 动态修改headerView的位置
////    if (scrollView.contentOffset.y >= -scrollView.contentInset.top
////        && scrollView.contentOffset.y < 0) {
////        // 注意:修改scrollView.contentInset时，若使当前界面显示位置发生变化，会触发scrollViewDidScroll:，从而导致死循环。
////        // 因此此处scrollView.contentInset.top必须为-scrollView.contentOffset.y
////        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
////    } else if (scrollView.contentOffset.y == 0) { // 到0说明headerView已经在tableView最上方，不需要再修改了
////        scrollView.contentInset = UIEdgeInsetsZero;
////    }
////}
//
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 93;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 10.0;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 0.0;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (self.tableView.editing) {
//        if ([_collectionDataArray[indexPath.section] isKindOfClass:[CollectionMessageModel class]]) { // 视频
//            CollectionMessageModel* model = [_collectionDataArray objectAtIndex:indexPath.section];
//            CollectionTableViewCell *cell = (CollectionTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
//            model.isChecked = !model.isChecked;
//            [cell setChecked:model.isChecked];
//            if (model.isChecked) { // 选中
//                if (_delectedCollectionDataArray.count > 0) {
//                    BOOL isCommon = NO; // 是否有相同
//                    for (CollectionMessageModel *tempModel in _delectedCollectionDataArray) {
//                        if ([model.collectionId isEqual:tempModel.collectionId]) {
//                            isCommon = YES;
//                        }
//                    }
//                    if (!isCommon) {
//                        [_delectedCollectionDataArray addObject:model];
//                        [self.deletedButton setTitle:[NSString stringWithFormat:@"删除（%lu）", (unsigned long)_delectedCollectionDataArray.count] forState:UIControlStateNormal];
//                    }
//                } else {
//                    [_delectedCollectionDataArray addObject:model];
//                    [self.deletedButton setTitle:[NSString stringWithFormat:@"删除（%lu）", (unsigned long)_delectedCollectionDataArray.count] forState:UIControlStateNormal];
//                    self.deletedButton.titleLabel.text = [NSString stringWithFormat:@"删除（%lu）", (unsigned long)_delectedCollectionDataArray.count];
//                }
//            } else {
//                [_delectedCollectionDataArray removeObject:model];
//                [self.deletedButton setTitle:[NSString stringWithFormat:@"删除（%lu）", (unsigned long)_delectedCollectionDataArray.count] forState:UIControlStateNormal];
//            }
//        } else {  // 商品
//            CommodityModel* model = [_collectionDataArray objectAtIndex:indexPath.section];
//            CollectionCommodityTableViewCell *cell = (CollectionCommodityTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
//            model.isChecked = !model.isChecked;
//            [cell setChecked:model.isChecked];
//            if (model.isChecked) { // 选中
//                if (_delectedCollectionDataArray.count > 0) {
//                    BOOL isCommon = NO; // 是否有相同
//                    for (CommodityModel *tempModel in _delectedCollectionDataArray) {
//                        if ([model.collectionId isEqual:tempModel.collectionId]) {
//                            isCommon = YES;
//                        }
//                    }
//                    if (!isCommon) {
//                        [_delectedCollectionDataArray addObject:model];
//                        [self.deletedButton setTitle:[NSString stringWithFormat:@"删除（%lu）", (unsigned long)_delectedCollectionDataArray.count] forState:UIControlStateNormal];
//                    }
//                } else {
//                    [_delectedCollectionDataArray addObject:model];
//                    [self.deletedButton setTitle:[NSString stringWithFormat:@"删除（%lu）", (unsigned long)_delectedCollectionDataArray.count] forState:UIControlStateNormal];
//                    self.deletedButton.titleLabel.text = [NSString stringWithFormat:@"删除（%lu）", (unsigned long)_delectedCollectionDataArray.count];
//                }
//            } else {
//                [_delectedCollectionDataArray removeObject:model];
//                [self.deletedButton setTitle:[NSString stringWithFormat:@"删除（%lu）", (unsigned long)_delectedCollectionDataArray.count] forState:UIControlStateNormal];
//            }
//        }
//    } else {
//        if ([_collectionDataArray[indexPath.section] isKindOfClass:[CollectionMessageModel class]]) { // 视频
//                    CollectionMessageModel *model = [_collectionDataArray objectAtIndex:indexPath.section];
//                    if ([model.status intValue] == 1) { // 1是存在，2是不存在
//                        PRJ_VideoDetailViewController *detail = [[PRJ_VideoDetailViewController alloc] initWithNibName:@"PRJ_VideoDetailViewController" bundle:nil];
//                        detail.videoID = model.collectionId;
//                        [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
//                        [self.navigationController pushViewController:detail animated:YES];
//                    } else [self showStringMsg:@"视频已被删除" andYOffset:kYOffset];
//                }else {// 商品
//                
//                    CommodityModel *model = [_collectionDataArray objectAtIndex:indexPath.section];
//                    LSYGoodsInfoViewController * detailViewControl = [[LSYGoodsInfoViewController alloc]initWithNibName:@"LSYGoodsInfoViewController" bundle:nil];
//                    detailViewControl.isSeckilling = NO;
//                    detailViewControl.goods_id = model.collectionId;
//                    [self.navigationController pushViewController:detailViewControl animated:YES];
//                }
//       
//    }
//}
//
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete) { // 删除
//        if ([_collectionDataArray[indexPath.section] isKindOfClass:[CollectionMessageModel class]]) { // 视频
//            CollectionMessageModel *model = [_collectionDataArray objectAtIndex:indexPath.section];
////            [self cancelCollectionDataObjectId:model.collectionId isVedio:YES];
//            [self cancelCollectionDataObjectId:model.collectionId cancelType:0];
//        } else if ([_collectionDataArray[indexPath.section] isKindOfClass:[CommodityModel class]]) { // 商品
//            CommodityModel *model = [_collectionDataArray objectAtIndex:indexPath.section];
////            [self cancelCollectionDataObjectId:model.collectionId isVedio:NO];
//            [self cancelCollectionDataObjectId:model.collectionId cancelType:1];
//        } else { //商户
//            
////            [self cancelCollectionDataObjectId:model.collectionId cancelType:2];
//        }
//        
//        [_collectionDataArray removeObjectAtIndex:indexPath.section];
//        // Delete the row from the data source
//        [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
//        
//        if (_collectionDataArray.count <= 0) {
//            self.rightButton.hidden = YES;
//        }
//        //        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }
//}
//
//#pragma mark 删除收藏
//- (IBAction)deletedBtnAction:(id)sender {
//    // 删除收藏
//    if (_delectedCollectionDataArray.count > 0) {
//        
//        NSMutableArray *deleteCollectionMessageModels = [NSMutableArray array];
//        
//        NSMutableArray *deleteCommodityModel          = [NSMutableArray array];
//        
//        NSMutableArray *deleteMerchantModel          = [NSMutableArray array];
//        
//        for (BYC_BaseModel *model in _delectedCollectionDataArray) {
//            
//            if ([model isKindOfClass:[CollectionMessageModel class]]) {//视频model
//                
//                [deleteCollectionMessageModels addObject:model];
//                
//            } else if ([model isKindOfClass:[CommodityModel class]]) {//商品model
//                
//                [deleteCommodityModel addObject:model];
//            } else {//商户model
//                [deleteMerchantModel addObject:model];
//            }
//        }
//        
//        if (deleteCollectionMessageModels.count > 0) { // 视频
//            NSMutableString *delectedId = [NSMutableString string];
//            for (int i = 0; i < deleteCollectionMessageModels.count; i++) {
//                CollectionMessageModel *model = [deleteCollectionMessageModels objectAtIndex:i];
//                if (i == deleteCollectionMessageModels.count - 1) {
//                      [delectedId appendString:[NSString stringWithFormat:@"%@", model.collectionId]];
//                }else [delectedId appendString:[NSString stringWithFormat:@"%@,", model.collectionId]];
//                [_collectionDataArray removeObject:model];
//            }
//            
////            [self cancelCollectionDataObjectId:delectedId isVedio:YES];
//            [self cancelCollectionDataObjectId:delectedId cancelType:0];
//        }
//        
//        if (deleteCommodityModel.count > 0){ // 商品
//            NSMutableString *delectedId = [NSMutableString string];
//            for (int i = 0; i < deleteCommodityModel.count; i++) {
//                CommodityModel *model = [deleteCommodityModel objectAtIndex:i];
//                if (i == deleteCommodityModel.count - 1) {
//                    [delectedId appendString:[NSString stringWithFormat:@"%@", model.collectionId]];
//                }else [delectedId appendString:[NSString stringWithFormat:@"%@,", model.collectionId]];
//                [_collectionDataArray removeObject:model];
//            }
//            
////            [self cancelCollectionDataObjectId:delectedId isVedio:NO];
//            [self cancelCollectionDataObjectId:delectedId cancelType:1];
//        }
//        
//        if (deleteMerchantModel.count > 0 ) { //商户
//        
//        }
//        
//        
//        if (_collectionDataArray.count <= 0) {
//            self.rightButton.hidden = YES;
//        }
//        
//        self.tableView.editing = NO;
//        [self.rightButton setTitle:@"编辑" forState:UIControlStateNormal];
//        [self.tableView reloadData];
//        
//        //self.tableView.frame = CGRectMake(ORIGIN_X(self.tableView), ORIGIN_Y(self.tableView), SCREENWIDTH, SCREENHEIGHT - 24);
//        self.deletedView.hidden = YES;
//        [self.deletedButton setTitle:@"删除" forState:UIControlStateNormal];
//        [_delectedCollectionDataArray removeAllObjects];
//    }
//}
//@end
