//
//  LYQCommodityListViewController.m
//  MarketManage
//
//  Created by 劳大大 on 15/4/20.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "LYQCommodityListViewController.h"
#import "CrazyShoppingCartShopModel.h"
#import "CrazyShoppingCartShopCommodityModel.h"
#import "LYQCommodityTableViewCell.h"

#import "jsonMyModel.h"
@interface LYQCommodityListViewController ()
<UITableViewDataSource,UITableViewDelegate>
//商品清单
@property (weak, nonatomic) IBOutlet UITableView *commoddityListTableView;


@end

@implementation LYQCommodityListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mallTitleLabel.text = @"商品清单";
    self.commoddityListTableView.delegate = self;
    self.commoddityListTableView.dataSource = self;
    NSLog(@"%@",_goodsPayDataArray);
    // Do any additional setup after loading the view from its nib.
}


#pragma mark - UItableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return _goodsPayDataArray.count;
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 34.f;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 34)];
    view.backgroundColor = [UIColor whiteColor];
    

//    UIView *upLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(view.frame)+0.5, SCREENWIDTH, 0.5)];
////    upLine.backgroundColor = [UIColor colorWithRed:0.89f green:0.89f blue:0.89f alpha:1.00f];
//    upLine.backgroundColor = [UIColor redColor];
//    [view addSubview:upLine];
    
    
    UIView *underLine = [[UIView alloc] initWithFrame:CGRectMake(0, view.frame.size.height - 0.5, SCREENWIDTH, 0.5)];
    underLine.backgroundColor = [UIColor colorWithRed:0.89f green:0.89f blue:0.89f alpha:1.00f];
//    underLine.backgroundColor = [UIColor redColor];
    [view addSubview:underLine];
    
    NSString *str = [[_goodsPayDataArray objectAtIndex:section]objectForKey:@"shop_name"];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0.5, SCREENWIDTH-10, 34 - 0.5)];
    label.font = [UIFont systemFontOfSize:13];
    label.text = str;
    
    [view addSubview:label];

    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.000001f;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return  [[[_goodsPayDataArray objectAtIndex:section]objectForKey:@"goods"]count];
 
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        NSMutableArray * data = [[self.goodsPayDataArray objectAtIndex:indexPath.section]objectForKey:@"goods"];
        if(data.count - 1 == indexPath.row){
            
            return  150;
        }else{
            return 100;
        }
 
    
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * commdetiyCell = @"commdetiyCell";
    LYQCommodityTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:commdetiyCell];
    if(cell == nil){
        
        cell = [[[NSBundle mainBundle]loadNibNamed:@"LYQCommodityTableViewCell" owner:self options:nil]lastObject];
    }
    
    NSDictionary * dict = [[[_goodsPayDataArray objectAtIndex:indexPath.section]objectForKey:@"goods"]objectAtIndex:indexPath.row];
    NSMutableArray * data = [[self.goodsPayDataArray objectAtIndex:indexPath.section]objectForKey:@"goods"];

    if(data.count -1 == indexPath.row){
        [cell getDictData:dict freightPrice:[[_goodsPayDataArray objectAtIndex:indexPath.section]objectForKey:@"freight"] cellStatu:YES andGoods:data];

    }else{
        [cell getDictData:dict freightPrice:[[_goodsPayDataArray objectAtIndex:indexPath.section]objectForKey:@"freight"] cellStatu:NO andGoods:data];
    }
    
       return cell;
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
