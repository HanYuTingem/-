//
//  TextInfoViewController.m
//  Saoyisao
//
//  Created by 宋鑫鑫 on 14-8-28.
//  Copyright (c) 2014年 pipixia. All rights reserved.
//

#import "TextInfoViewController.h"
#import "JPCommonMacros.h"
#import "YXSqliteHeader.h"
@interface TextInfoViewController () < UMSocialUIDelegate >
 

/*
 *titleBgImageView          标题背景
 *titleLabel                标题
 *contentImageView          内容背景
 *contentLabel              内容
 *myCopyTextBtn             复制内容按钮
 *shareBtn                  分享按钮
 */
@property (strong, nonatomic) IBOutlet UIImageView *titleBgImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *contentImageView;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;
@property (strong, nonatomic) IBOutlet UIButton *myCopyTextBtn;
@property (strong, nonatomic) IBOutlet UIButton *shareBtn;

@end

@implementation TextInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)backButtonClick{
    
     [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{

    [self setNavigationBarWithState:1 andIsHideLeftBtn:NO andTitle:@"文本信息"];
//    [backImageView setImage:[UIImage imageNamed:@"videodetails_title_btn_back.png"]];
//    backImageView.frame = CGRectMake(10, 33, 10, 18);
    [self.leftButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [super viewWillAppear:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.titleBgImageView.frame = CGRectMake(5, 66, SCREENWIDTH - 10, 37);
    self.titleLabel.frame = CGRectMake(105, 73, 110, 25);
    self.titleLabel.center = CGPointMake(SCREENWIDTH / 2 , 85.5);

    CGSize size = [self.historyObject.content sizeWithFont:[UIFont systemFontOfSize:15]constrainedToSize:CGSizeMake(SCREENWIDTH - 20, 1000) lineBreakMode:NSLineBreakByWordWrapping];
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.contentLabel.text = self.historyObject.content;
    self.contentLabel.frame = CGRectMake(17, self.titleBgImageView.frame.origin.y + self.titleBgImageView.frame.size.height + 12, SCREENWIDTH - 20, size.height);
    
    self.contentImageView.frame = CGRectMake(5, self.titleBgImageView.frame.origin.y + self.titleBgImageView.frame.size.height, SCREENWIDTH - 10, self.contentLabel.frame.size.height + 24);
    
    UIImageView *lineImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line.png"]];
    lineImageView.frame = CGRectMake(5, self.titleBgImageView.frame.origin.y + self.titleBgImageView.frame.size.height, SCREENWIDTH - 10, 1);
    [self.view addSubview:lineImageView];
    
    self.myCopyTextBtn.frame = CGRectMake(5, self.contentImageView.frame.origin.y + self.contentImageView.frame.size.height + 20, 310, 44);
    //去除多个button同事点击的效果
    [self.myCopyTextBtn setExclusiveTouch:YES];
    [self.shareBtn setExclusiveTouch:YES];
    self.shareBtn.frame = CGRectMake(5, self.myCopyTextBtn.frame.origin.y + self.myCopyTextBtn.frame.size.height + 10, SCREENWIDTH - 10, 44);
}

//复制
- (IBAction)myCopyBtnClick:(UIButton *)sender
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    if (self.historyObject.content) {
        pasteboard.string = self.historyObject.content;
    } else {
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"没有可复制的内容" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [av show];
    }
    UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"文本已经复制到剪切板。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [av show];
}

//分享
- (IBAction)shareBtnClick:(id)sender
{
    self.shareContent = [NSString stringWithFormat:@"%@    (来自《黑土APP》-扫一扫结果) http://ht.sinosns.cn/",self.historyObject.content];
    [self callOutShareViewWithUseController:self andSharedUrl:@"http://ht.sinosns.cn/"];
}

//实现回调方法（可选）：
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
        NSLog(@"-----------fenxiangchenggong");
    }
}

//返回上一页面
- (void)dismissOverlayView:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
