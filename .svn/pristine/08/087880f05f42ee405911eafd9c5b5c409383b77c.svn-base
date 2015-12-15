//
//  SINOMyActionViewController.m
//  LANSING
//
//  Created by yll on 15/7/20.
//  Copyright (c) 2015年 DengLu. All rights reserved.
//

#import "SINOMyActionViewController.h"
#import "SINOMyApplyViewController.h"
#import "SINOMyCollectViewController.h"
#import "MyActionInfor.h"
#import "HTTPClientAPI.h"

@interface SINOMyActionViewController ()
{
    __weak IBOutlet UIView *collectView;
    __weak IBOutlet UIView *applyView;
    int   _appyNum;
    int   _collectNum;
    __weak IBOutlet UILabel *navLineLable;
}
@property (weak, nonatomic) IBOutlet UILabel *myApplyLable;
@property (weak, nonatomic) IBOutlet UILabel *myCllectLable;




@end

@implementation SINOMyActionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    collectView.layer.borderColor = [UIColor colorWithRed:234/255.0f green:234/255.0f blue:234/255.0f alpha:1].CGColor;
    collectView.layer.borderWidth = 1;
    applyView.layer.borderColor = [UIColor colorWithRed:234/255.0f green:234/255.0f blue:234/255.0f alpha:1].CGColor;
    applyView.layer.borderWidth = 1;
//    [self.bar addSubview:navLineLable];
    //适配时需要设置，后期可以在根试图中适配
//    titleButton.frame = CGRectMake((KProjectScreenWidth - titleButton.width)/2, titleButton.top, titleButton.width, titleButton.height);
//    [titleButton setTitle:@"我的活动" forState:UIControlStateNormal];
    [self setNavigationBarWithState:1 andIsHideLeftBtn:NO andTitle:@"我的活动"];

}

-(void)viewWillAppear:(BOOL)animated{
#pragma mark==============********//userId: 用户id，对应各自项目中存的,自行替换
    NSString *userId;
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults]objectForKey:usernameMessagePHP];
    userId = [dic objectForKey:@"id"];
    
    mainRequest.tag = 100;
    [mainRequest requestHttpWithPost:[NSString stringWithFormat:@"%@%@",Http,SINOApplyCount] withDict:[HTTPClientAPI applyCountFormUserId:userId]];
}

//刷新UI
- (void) theRefreshDataFormApply_count:(NSString *)apply_count collect_count:(NSString *)collect_count
{
    self.myApplyLable.text = [NSString stringWithFormat:@"我的报名（%@）",apply_count];
    self.myCllectLable.text = [NSString stringWithFormat:@"我的收藏（%@）",collect_count];
}



-(void)GCRequest:(GCRequest *)aRequest Finished:(NSString *)aString
{
    aString = [aString stringByReplacingOccurrencesOfString:@"null"withString:@"\"\""];
    NSMutableDictionary *dict=[aString JSONValue];
    
    if (dict) {
        if ([[dict objectForKey:@"code"] intValue] == 0) {
            if (aRequest.tag == 100) {
//                [self theRefreshDataFormApply_count:[dict objectForKey:@"apply_count"] collect_count:[dict objectForKey:@"collect_count"]];
                MyActionInfor *actionModel = [MyActionInfor initWithActionModelInforActionCountWithJSONDic:dict];
                [self theRefreshDataFormApply_count:actionModel.apply_count collect_count:actionModel.collect_count];
                _appyNum = [actionModel.apply_count intValue];
                _collectNum = [actionModel.collect_count intValue];
            }else{
                
            }
        }else{
            switch ([[dict objectForKey:@"code"] intValue]) {
                case 100:{
                    [self showMsg:@"用户名不存在!"];
                    break;
                }
                case 102:{
                    [self showMsg:@"密码错误!"];
                    break;
                }
                case 103:{
                    [self showMsg:@"没有登录平台权限!"];
                    break;
                }
                case 203:{
                    [self showMsg:@"系统异常!"];
                    break;
                }
                case 2:{
                    [self showMsg:@"用户锁定!"];
                    break;
                }
                    
                default:{
                    [self showMsg:[dict objectForKey:@"message"]];
                    break;
                }
            }
        }
    }else{
        [self showMsg:@"服务器去月球了!"];
    }
    
}

-(void)GCRequest:(GCRequest *)aRequest Error:(NSString *)aError
{
//    [self showMsg:@"亲，网络不顺畅!"];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)MyApplicationButtonClickAction:(id)sender {
    SINOMyApplyViewController *applyVC = [[SINOMyApplyViewController alloc]init];
    applyVC.whetherHaveData = _appyNum;
    [self.navigationController pushViewController:applyVC animated:YES];
}

- (IBAction)MyCollectButtonClickAction:(id)sender {
    SINOMyCollectViewController *collectVC = [[SINOMyCollectViewController alloc]init];
    collectVC.whetherHaveData = _collectNum;
    [self.navigationController pushViewController:collectVC animated:YES];
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
