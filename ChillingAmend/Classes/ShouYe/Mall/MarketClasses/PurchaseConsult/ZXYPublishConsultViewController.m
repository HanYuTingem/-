//
//  ZXYPublishConsultViewController.m
//  LiaoNing
//
//  Created by Rice on 14/11/27.
//  Copyright (c) 2014年 Sinoglobal. All rights reserved.
//

#import "ZXYPublishConsultViewController.h"
#import "BSaveMessage.h"
#import "JSON.h"

@interface ZXYPublishConsultViewController ()
{
    ASIFormDataRequest * mRequest;
   
}

@property (weak, nonatomic) IBOutlet UIView *textViewBgView;

@property (weak, nonatomic) IBOutlet UITextView *consultTextView;

@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@property (weak, nonatomic) IBOutlet UILabel *placeholdLabel;

@end

@implementation ZXYPublishConsultViewController

#pragma mark - lifyCycle
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavStyle];
    [self initData];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [mRequest cancel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Init
-(void)setNavStyle
{
    
    
    [self.rightButton setTitle:@"提交" forState:UIControlStateNormal];
    [self.rightButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    self.rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.mallTitleLabel.text = @"发表咨询";

}



-(void)initData
{
  
    self.consultTextView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.consultTextView.text= @"";
}

/*导航右按钮
 */
-(void)rightBackCliked:(UIButton *)sender {
    if (self.consultTextView.text.length == 0 ) {
        [self showMsg:@"请输入内容"];
    }else if (self.consultTextView.text.length > 50 ) {
        [self showMsg:@"咨询内容限50字以内"];
    }else{
        [self commentRequest];
    }
}

#pragma mark - UITextViewDelegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{

    if (self.consultTextView.text.length == 0 && [text isEqual:@""]) {
        self.placeholdLabel.hidden = NO;
    }else{
        self.placeholdLabel.hidden = YES;
    }
    if ([text isEqual:@"\n"]) {
        [self.consultTextView resignFirstResponder];
    }
    return YES;
}

-(void)textViewDidChange:(UITextView *)textView
{
    if (self.consultTextView.text.length == 0) {
        self.placeholdLabel.hidden = NO;
    }
    [self limitLengh:self.consultTextView];
    
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    self.placeholdLabel.hidden = YES;
}


#pragma mark - 监听键盘
-(void)limitLengh:(UITextView *)sender
{
    BOOL isChinese;
    if ([[[UITextInputMode currentInputMode] primaryLanguage] isEqual:@"en-US"]) {
        isChinese = false;
    }else{
        isChinese = true;
    }
    if (sender == self.consultTextView) {
        NSString *str = [[self.consultTextView text] stringByReplacingOccurrencesOfString:@"?" withString:@""];
        if (isChinese) {
            UITextRange *selectedRange = [self.consultTextView markedTextRange];
            UITextPosition *position = [self.consultTextView positionFromPosition:selectedRange.start offset:0];
            if (!position) {
                [self judgeSendBtnStatuWithStr:[NSString stringWithString:str]];
                
            }else{
                NSLog(@"输入的英文还没有转化为汉字的状态");
            }
        }else{
            [self judgeSendBtnStatuWithStr:[NSString stringWithString:str]];
        }
    }
}

-(void)judgeSendBtnStatuWithStr:(NSString *)str
{
    if ([str length] > 0) {
        int length = 50 - str.length;
        self.countLabel.text = [NSString stringWithFormat:@"%d",length];
        if (length >= 0) {
            self.rightButton.enabled = YES;
        }
        else {
            self.rightButton.enabled = NO;
        }
    }else{
        self.countLabel.text = @"50";
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.consultTextView resignFirstResponder];
}

#pragma mark - Request

/*"por" : "105",     //请求接口
  “proIden”:“”，  //产品标识
  id:***;  //商品id
  "user_name" : "13838389438",     //用户名
  "nike_name": "枫叶",  //昵称
  “type”：1   //评论类型，1=售后评论，2=售前咨询
  "message": "as大地飞歌",  //评论内容
  "user_id": "1"  //用户id
  “order_num”:12313     //订单号
 */
-(void)commentRequest
{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSMutableDictionary *dictJson = [@{@"id":IfNullToString(self.productId) ,@"message":self.consultTextView.text} mutableCopy];
    [arr addObject:dictJson];
    mRequest = [MarketAPI requestSendComment105WithController:self oderNum:@"" contentArray:arr type:@"2"];
}

- (void)requestFinished:(ASIHTTPRequest *)request;
{
    [self stopActivity];
    NSString *tEndString=[[NSString alloc] initWithData:request.responseData encoding:NSUTF8StringEncoding];
    tEndString = [tEndString stringByReplacingOccurrencesOfString:@"\n" withString:@"\n"];
    NSMutableDictionary *dict = [tEndString JSONValue];
    if (dict == nil) {
        NSLog(@"json错误");
    }else{
        if (dict[@"code"] != nil && [dict[@"code"] integerValue] == 0) {
            [self showMsg:@"咨询成功，请耐心等待客服回复~"];
            [self performSelector:@selector(backEvent) withObject:self afterDelay:2.f];
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

-(void)backEvent
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
