//
//  OtherShopListViewController.m
//  HCheap
//


#import "OtherShopListViewController.h"
#import "ListTableViewController.h"
#import "MerchantsListModel.h"
@interface OtherShopListViewController ()
@property (nonatomic,strong)UITableView *maimTableview;
@end

@implementation OtherShopListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    titleButton.hidden = NO;
    [titleButton setTitle:@"商户列表" forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
 //   [self addReturnBtn];
    [self createmainTableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.name = @"22";
    
    
}



-(void)createmainTableView{
    self.maimTableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 64,SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    self.maimTableview.tag=100;
    self.maimTableview.dataSource=self;
    self.maimTableview.delegate=self;
    [self.maimTableview setBackgroundColor:[UIColor clearColor]];
    self.maimTableview.showsVerticalScrollIndicator=NO;
    [self setExtraCellLineHidden:self.maimTableview];
    [self.view addSubview:self.maimTableview];
    
}
//多余分割线不显示
- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}
#pragma mark -OtherShopListTableViewCellDelegate-
-(void)clickPhone:(UIButton*)sender cell:(OtherShopListTableViewCell*)cell{
    //打电话
   
        self.name=@"33";
        
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",cell.phone];
        NSLog(@"str======%@",str);
        BOOL b = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:str]];
        if (b) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }else{
            [self showMsg:@"该设备无法拨打电话"];
        }
        
        
    
}
#pragma mark-ios8分割线从边框顶端开始-
-(void)viewDidLayoutSubviews
{
    if ([self.maimTableview respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.maimTableview setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    
    if ([self.maimTableview respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.maimTableview setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
#pragma mark- UITableViewDataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.shopListMutableArray.count;
}
#pragma mark- UITableViewDelegate -
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *sectionView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    label.backgroundColor=[UIColor colorWithRed:235.0f/255 green:235.0f/255 blue:235.0f/255 alpha:1];
    label.font = [UIFont systemFontOfSize:14];
    label.text=[NSString stringWithFormat:@"   %ld店通用",(unsigned long)self.shopListMutableArray.count];
    [sectionView addSubview:label];
    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier1 = @"rightCell";
    OtherShopListTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    if (cell1 == nil) {
        cell1 =(OtherShopListTableViewCell *)[[[NSBundle mainBundle]loadNibNamed:@"OtherShopListTableViewCell" owner:self options:NULL]lastObject];
        
        cell1.selectionStyle=UITableViewCellSelectionStyleNone;
        
    }
    cell1.delegate=self;
    MerchantsListModel *model=[self.shopListMutableArray objectAtIndex:indexPath.row];
    cell1.shopNameLabel.text=model.merchantName;
    cell1.shopAddressLabel.text=model.address;
    cell1.phone = model.phone;
    
    return cell1;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ListTableViewController *merVC=[[ListTableViewController alloc] init];
    merVC.ownerId=[(MerchantsListModel*)[self.shopListMutableArray objectAtIndex:indexPath.row] ownerId];
    merVC.oId = UserId;
    [self.navigationController pushViewController:merVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
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
