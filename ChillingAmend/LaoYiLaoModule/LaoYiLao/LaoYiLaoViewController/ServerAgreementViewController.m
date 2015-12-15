//
//  ServerAgreementViewController.m
//  LaoYiLao
//
//  Created by sunsu on 15/11/10.
//  Copyright © 2015年 sunsu. All rights reserved.
//

#import "ServerAgreementViewController.h"

@interface ServerAgreementViewController ()
{
    UITextView * _serverAgreeTextView;
    UILabel * _label;
}
@end

@implementation ServerAgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self changeBarTitleWithString:@"服务协议"];
    self.customNavigation.shareButton.hidden = YES;
    self.customNavigation.rightButton.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createServerAgreementTextView];
    [self requestData];
}

- (void)createServerAgreementTextView{

    
//    CGFloat text_Y = CGRectGetMaxY(label.frame);
    CGFloat text_Y = NavgationBarHeight;
    CGRect textViewFrame = CGRectMake(0, text_Y, kkViewWidth, kkViewHeight-text_Y);
    
    _serverAgreeTextView = [[UITextView alloc]initWithFrame:textViewFrame];
    _serverAgreeTextView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_serverAgreeTextView];
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, kkViewWidth, 20)];
    _label.text = [NSString stringWithFormat:@"《信诺通行证》"];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font = UIFont40;
    _label.textColor = [UIColor blackColor];
    _label.hidden = YES;
    [_serverAgreeTextView addSubview:_label];
    
}


//用户协议格式
-(void)lineSpacingTextView:(UITextView *)textView fontInt:(int )fontInt{
    //    textview 改变字体的行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = fontInt;// 字体的行间距
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:16],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    textView.attributedText = [[NSAttributedString alloc] initWithString:textView.text attributes:attributes];
}

- (void) requestData{
    NSString * url = [LYLHttpTool getUserAndCountAgreementWithType:@"2"];
    [self showHudInView:self.view hint:@"正在加载"];
    [LYLAFNetWorking postWithBaseURL:url success:^(id json) {
        ZHLog(@"用户协议json =%@",json);
        [self hideHud];
        if ([[json objectForKey:@"code"] intValue] == 1) {
            _serverAgreeTextView.text = [NSString stringWithFormat:@"  \n\n%@",[json objectForKey:@"content"]];
            [self lineSpacingTextView:_serverAgreeTextView fontInt:12];
            _label.hidden = NO;
            _serverAgreeTextView.textColor = RGBACOLOR(104, 104, 104, 1);
        }else{
            switch ([[json objectForKey:@"code"] intValue]) {
                case 0:{
                    [LYLTools showInfoAlert:@"获取失败!"];
                    break;
                }
                case 203:{
                    [LYLTools showInfoAlert:@"系统异常!"];
                    break;
                }
                default:{
                    [LYLTools showInfoAlert:[json objectForKey:@"message"]];
                    break;
                }
            }
        }
        
    } failure:^(NSError *error) {
        [self hideHud];
        [LYLTools showInfoAlert:@"服务器去月球了!"];
    }];
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
