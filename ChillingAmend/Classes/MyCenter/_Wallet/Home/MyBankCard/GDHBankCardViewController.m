//
//  GDHBankCardViewController.m
//  Wallet
//
//  Created by GDH on 15/10/22.
//  Copyright (c) 2015年 Sinoglobal. All rights reserved.
//

#import "GDHBankCardViewController.h"
#import "GDHADDBlankViewController.h"
#import "GDHBankModel.h"
#import "GDHAddBlankTableViewCell.h"
@interface GDHBankCardViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
}
@property(nonatomic,strong)NSMutableArray *bankArray;

@end

@implementation GDHBankCardViewController

/** 懒加载 数据源的存储 */
-(NSMutableArray *)bankArray{
    if (!_bankArray) {
        
        _bankArray = [NSMutableArray array];
    }
    return _bankArray;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestWalletPersonUserBankCardList1112];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeNav];
    mainView.backgroundColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1.00f];
    [self makeTableView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(theblankAddSuccess) name:@"theBlankAddSuccess" object:nil];
    // Do any additional setup after loading the view from its nib.
}

/** 银行卡添加成功 */
-(void)theblankAddSuccess{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showMsg:@"添加成功！"];
    });
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [SINOAFNetWorking cancelAllRequest];
}

-(void)makeNav{
    self.backView.backgroundColor = WalletHomeNAVGRD
    self.mallTitleLabel.text  = @"我的银行卡";
    self.mallTitleLabel.textColor = [UIColor whiteColor];

    
    self.mallTitleLabel.font = WalletHomeNAVTitleFont
    [self.leftBackButton setImage:[UIImage imageNamed:@"title_btn_back02"] forState:UIControlStateNormal];
    mainView.backgroundColor = [UIColor whiteColor];
}
/** 1112. 获取用户银行卡列表 */
-(void)requestWalletPersonUserBankCardList1112{
    [self chrysanthemumOpen];
    NSDictionary *dict = [WalletRequsetHttp WalletPersonUserBankCardList1112];
    NSString *url = [NSString stringWithFormat:@"%@%@", WalletHttp_BankCardList1112,[dict JSONFragment]];
    [SINOAFNetWorking postWithBaseURL:url controller:self success:^(id json) {
        NSLog(@"%@",json);
        [self.bankArray removeAllObjects];

        NSDictionary *dict  = json;
        if ([dict[@"code"] isEqualToString:@"100"]) {
            NSArray *myBankArray = dict[@"rs"];
            
            if (myBankArray.count) {
                for (NSDictionary *dic in myBankArray) {
                    GDHBankModel *model = [[GDHBankModel alloc] initWithDic:dic];
                    [self.bankArray addObject:model];
                }
            }else{
                [self showMsg:ShowNoMessage];
            }
        }
        [self chrysanthemumClosed];
        [_tableView reloadData];
    } failure:^(NSError *error) {
        [self showMsg:ShowMessage];
        [self chrysanthemumClosed];
        
    } noNet:^{
        [self chrysanthemumClosed];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)makeTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+15, ScreenWidth, ScreenHeight- 64-15) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    //    _tableView.scrollEnabled = NO;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.backgroundColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1.00f];
    [self.view addSubview:_tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.bankArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *iden = @"iden";
    GDHAddBlankTableViewCell *accountCell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (!accountCell) {
        accountCell = [[[NSBundle mainBundle] loadNibNamed:@"GDHAddBlankTableViewCell" owner:self options:nil] lastObject];
    }
    if (indexPath.row == 0) {
//        accountCell.upline.hidden = NO;
    }
    GDHBankModel *model = self.bankArray[indexPath.row];
    [accountCell refresh:model];
    accountCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return accountCell;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    footView.backgroundColor = [UIColor whiteColor];
    
//    UIView *lineUp  =[[UIView a                                                                                     blloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
//    lineUp.backgroundColor = [UIColor lightGrayColor];
//    [footView addSubview:lineUp];
    UIButton *footButton = [UIButton buttonWithType:UIButtonTypeCustom];
    footButton.frame = CGRectMake(0, 0, ScreenWidth, 44);
//    [footButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [footButton setTitle:@"添加银行卡" forState:UIControlStateNormal];
    [footButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    footButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [footButton setImage:[UIImage imageNamed:@"content_ico01"] forState:UIControlStateNormal];
    footButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 200);
    footButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 210*WalletSP_Width);
    [footButton  addTarget:self action:@selector(addBlank:) forControlEvents:UIControlEventTouchUpInside];
    UIView *line  =[[UIView alloc] initWithFrame:CGRectMake(0, 43.5, ScreenWidth, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    [footView addSubview:footButton];
    [footView addSubview:line];
    
    return footView;
}
-(void)addBlank:(UIButton *)button{
    

    GDHADDBlankViewController *addBlank = [[GDHADDBlankViewController alloc] init];
    [self.navigationController pushViewController:addBlank animated:YES];
    NSLog(@"dsadasdas");
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GDHADDBlankViewController *addBlank = [[GDHADDBlankViewController alloc] init];
    GDHBankModel *model = self.bankArray[indexPath.row];
    addBlank.theRightIden = @"显示";
    addBlank.theBank = model.bankName;
    addBlank.bankNum = model.cardSn;
    addBlank.bankName = model.cardName;
    addBlank.bankID = model.userbcid;
    addBlank.bankImg = model.bankIcon;
    [self.navigationController pushViewController:addBlank animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 44;
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
