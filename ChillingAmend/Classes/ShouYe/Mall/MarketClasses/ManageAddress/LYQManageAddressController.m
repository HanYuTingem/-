//
//  LYQManageAddressController.m
//  Chiliring
//
//  Created by nsstring on 14-9-9.
//  Copyright (c) 2014年 Sinoglobal. All rights reserved.
//

#import "LYQManageAddressController.h"
#import "LYQManageAddressCell.h"
#import "LYQHarvestAddressViewController.h"
#import "LYQCompileAddressViewController.h"
#import "BSaveMessage.h"

@interface LYQManageAddressController ()
<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
{
    NSIndexPath        * selectedIndexpath; //点击对应的tableview的index
    UIView             * noAddPopView;      //收货地址已到达上线提示
    ASIFormDataRequest * mRequest;
    
}
@property (weak, nonatomic) IBOutlet UIView        *maskview;
@property (strong, nonatomic) UIBarButtonItem      *rightItem;
//删除和设置默认地址
@property (weak , nonatomic) IBOutlet UIView       *moreRenView;
//无地址请添加地址
@property (weak , nonatomic) IBOutlet UIView       *NoaddressView;
//地址列表
@property (weak , nonatomic) IBOutlet UITableView  *addressTableView;
//地址列表数据源
@property (strong, nonatomic) NSMutableArray       *addressDataArray;

- (IBAction)deleteButtonCliked:(id)sender;//删除地址
- (IBAction)moreRenButtonCliked:(id)sender;//设置默认地址
- (IBAction)addressButtonCliked:(id)sender;//增加地址


@end

@implementation LYQManageAddressController

#pragma mark - LifeCycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNavigationBarStyle];
    [self requestAddressList];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setLayout];
    
    self.maskview.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    
    if(!_status){
        //添加长按的手势
        [self addLongPressGestureRecognizer];
    }
  
}
//uitableviewcell添加长按手势
- (void)addLongPressGestureRecognizer
{
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 2.0; //seconds  设置响应时间
    lpgr.delegate = self;
    [self.addressTableView addGestureRecognizer:lpgr]; //启用长按事件
    
}
//长按响应函数  取响应的长按的indexpath

-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    CGPoint point = [gestureRecognizer locationInView:self.addressTableView ];
    if(gestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        NSIndexPath *indexPath = [self.addressTableView indexPathForRowAtPoint:point];
        if (indexPath != nil){
            selectedIndexpath = indexPath;
            [self showMorenView];
            [self.addressTableView  deselectRowAtIndexPath:indexPath animated:YES];
        }
    }
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [mRequest cancel];
//    [_moreRenView removeFromSuperview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Init

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _addressDataArray = [[NSMutableArray alloc]init];
    }
    return self;
}
-(void)setLayout
{
  
    UITapGestureRecognizer *tapHideMaskView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMorenView)];
    [self.maskview addGestureRecognizer:tapHideMaskView];
    [[[UIApplication sharedApplication] keyWindow] addSubview:self.maskview];
    
    noAddPopView = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-70, self.view.frame.size.height-200, 140,40)];
    noAddPopView.backgroundColor=[UIColor blackColor];
    noAddPopView.alpha = 0.7;
    [noAddPopView.layer setCornerRadius:6];
    [noAddPopView.layer setMasksToBounds:YES];
    [noAddPopView.layer setBorderWidth:0];
    UILabel * mesLabel = [[UILabel alloc]initWithFrame:noAddPopView.bounds];
    mesLabel.text = @"收货地址已到达上线";
    mesLabel.textAlignment = NSTextAlignmentCenter;
    mesLabel.font = [UIFont boldSystemFontOfSize:14];
    mesLabel.backgroundColor = [UIColor clearColor];
    mesLabel.textColor = [UIColor whiteColor];
    [noAddPopView addSubview:mesLabel];
    [[[UIApplication sharedApplication] keyWindow] addSubview:noAddPopView];
    
    
    _moreRenView.frame = CGRectMake(SCREENWIDTH/2-_moreRenView.frame.size.width/2, self.view.frame.size.height/2-80, _moreRenView.frame.size.width, _moreRenView.frame.size.height);
    _moreRenView.layer.cornerRadius = 8;
    _moreRenView.layer.masksToBounds = YES;
    [[[UIApplication sharedApplication].delegate window] addSubview:_moreRenView];
    
    _addressTableView.frame = CGRectMake(0,64 , SCREENWIDTH,SCREENHEIGHT - 64);
    _addressTableView.delegate = self;
    _addressTableView.dataSource = self;
    _addressTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    noAddPopView.hidden      = YES;
    _NoaddressView.hidden    =YES;
    _addressTableView.hidden = YES;
    [self hideMorenView];
    
}

-(void)setNavigationBarStyle
{
    self.mallTitleLabel.text = @"管理收货地址";
    UIImageView * rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 35, 32, 20, 20)];
    rightImageView.image = [UIImage imageNamed:@"zxy_address_add"];
    [self.barCenterView addSubview:rightImageView];
    [rightImageView sendSubviewToBack:self.rightButton];
}

/*
 导航条返回方法
 */
- (void)rightBackCliked:(UIButton *)sender
{
    if(_addressDataArray&& _addressDataArray.count >=10 ){
        noAddPopView.hidden = NO;
        [self performSelector:@selector(hidebackGroudView) withObject:self afterDelay:2];
        
    }else{
        LYQHarvestAddressViewController * harvestControl  = [[LYQHarvestAddressViewController alloc]initWithNibName:@"LYQHarvestAddressViewController" bundle:nil];
        [self.navigationController pushViewController:harvestControl animated:YES];
    }
}

- (void)hidebackGroudView
{
    noAddPopView.hidden = YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self hideMorenView];
}

#pragma mark - TableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _addressDataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85.0f;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * addressInfier = @"addressInfier";
    LYQManageAddressCell * cell = [tableView dequeueReusableCellWithIdentifier:addressInfier];
    if(cell == nil){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"LYQManageAddressCell" owner:self options:nil]lastObject];
    }
    NSMutableDictionary *dict = _addressDataArray[indexPath.row];
    cell.phoneLabel.text =dict[@"connect_tel"];
    cell.nameLabel.text = IfNullToString(dict[@"connect_name"]);
    cell.addressLabel.verticalAlignment = VerticalAlignmentTop;
    cell.addressLabel.text =[NSString stringWithFormat:@"收货地址: %@%@",dict[@"area"],dict[@"address"]];
    if ([IfNullToString(dict[@"is_default"])isEqualToString:@"1"]) {
        cell.contentView.backgroundColor = [UIColor colorWithWhite:.9 alpha:1];
        cell.morenLabel.hidden = NO;
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_status){
        [self.delegate selectAddDic:_addressDataArray[indexPath.row]];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        
        LYQCompileAddressViewController  * complieAddressControl = [[LYQCompileAddressViewController alloc]initWithNibName:@"LYQCompileAddressViewController" bundle:nil];
        complieAddressControl.indexPatchDict = _addressDataArray[indexPath.row];
        [self.navigationController pushViewController:complieAddressControl animated:YES];
    }
}
#pragma mark - Button Action
- (IBAction)addressButtonCliked:(id)sender {
    
    LYQHarvestAddressViewController * harvestControl  = [[LYQHarvestAddressViewController alloc]initWithNibName:@"LYQHarvestAddressViewController" bundle:nil];
    [self.navigationController pushViewController:harvestControl animated:YES];
}

- (IBAction)deleteButtonCliked:(id)sender {
    if (_addressID ){
        [self showMsg:@"当前使用地址不可删除"];
    }else
    {
        [self requetDelAddress];
    }
}

- (IBAction)moreRenButtonCliked:(id)sender {
    [self requestSetDefaultAddress];
}

-(void)showMorenView
{
    self.maskview.alpha = .7;
    _moreRenView.hidden = NO;
}

-(void)hideMorenView
{
    self.maskview.alpha = 0;
    _moreRenView.hidden = YES;
}

#pragma mark - Request
/*请求地址列表
 */
-(void)requestAddressList
{
    [self startActivity];
    mRequest = [MarketAPI requestAddressList5001WithController:self];
}
/*请求删除单条地址
 */
-(void)requetDelAddress
{
    [self startActivity];
    mRequest = [MarketAPI requestAddressDelete5003WithController:self oderNum:_addressDataArray[selectedIndexpath.row][@"id"] action:@"1" tag:50031];
   
}
/*请求设置默认地址
  */
-(void)requestSetDefaultAddress
{
    [self startActivity];
    mRequest = [MarketAPI requestAddressDelete5003WithController:self oderNum:_addressDataArray[selectedIndexpath.row][@"id"] action:@"2" tag:50032];
}
- (void)requestFinished:(ASIHTTPRequest *)request;
{
    [self stopActivity];
    NSString *tEndString=[[NSString alloc] initWithData:request.responseData encoding:NSUTF8StringEncoding];
    tEndString = [tEndString stringByReplacingOccurrencesOfString:@"\n" withString:@"\n"];
    NSDictionary * dict  = [tEndString JSONValue];
    NSLog(@"%@",dict);
    if (!dict ){
        NSLog(@"接口错误");
        return;
    }
    if(request.tag == 5001 ){
        
        if ([dict[@"code"]integerValue]==0 && dict[@"code"] != nil){
            [_addressDataArray removeAllObjects];
            [_addressDataArray addObjectsFromArray:[dict objectForKey:@"list"]];
            
            if (_addressDataArray&& _addressDataArray.count==0){
                _addressTableView.hidden = YES;
                _NoaddressView.hidden =NO;
                self.navigationItem.rightBarButtonItem = nil;
            }else{
                _addressTableView.hidden = NO;
                _NoaddressView.hidden =YES;
                self.navigationItem.rightBarButtonItem = self.rightItem;
            }
            [_addressTableView reloadData];
        }else{
            [self showMsg:dict[@"message"]];
        }
    }else if (request.tag ==50031){
        if ([[dict objectForKey:@"code"]integerValue]==0){
            [_addressDataArray removeObjectAtIndex:selectedIndexpath.row];
            [_addressTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:selectedIndexpath] withRowAnimation:UITableViewRowAnimationFade];
            [_addressTableView reloadData];
            [self showMsg:@"删除成功"];
            if (_addressDataArray&& _addressDataArray.count==0){
                _addressTableView.hidden = YES;
                _NoaddressView.hidden =NO;
                self.navigationItem.rightBarButtonItem = nil;
            }
            [self hideMorenView];
        }else{
            [self showMsg:dict[@"message"]];
        }
    }else if(request.tag == 50032){
        if ([[dict objectForKey:@"code"]integerValue]==0){
            NSLog(@"----默认成功------");
            [self requestAddressList];
            [self hideMorenView];
            [self showMsg:@"修改成功"];
            
        }else{
            [self showMsg:dict[@"message"]];
        }
    }

}
- (void)requestFailed:(ASIHTTPRequest *)request;
{
    [self stopActivity];
    [self showMsg:@"请求失败，请检查网路设置"];
}
@end
