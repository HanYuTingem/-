
//
//  LYQGoodsEvalutionViewController.m
//  MarketManage
//
//  Created by 劳大大 on 15/4/21.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "LYQGoodsEvalutionViewController.h"
#import "LYQGoodsEvalutionViewCell.h"
#import "JSON.h"

#define MaxNumberOfDescriptionChars 100 // 最大输入字数

@interface LYQGoodsEvalutionViewController ()
<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UIGestureRecognizerDelegate>
{
    ASIFormDataRequest * mRequest;
    NSMutableArray * noEvalutionArray;
    

}

//商品评价的页面
@property (weak, nonatomic) IBOutlet UITableView *goodsEvalutionTableView;

//当前选中的textView
@property (nonatomic,retain) UITextView *currentTextView;

//输入内容的字典
@property (nonatomic,retain) NSMutableArray  * contentArray;

@end

@implementation LYQGoodsEvalutionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.goodsEvalutionTableView.delegate = self;
    self.goodsEvalutionTableView.dataSource = self;
//    self.goodsEvalutionTableView.frame = CGRectMake(0, 44, SCREENWIDTH, SCREENHEIGHT - 44);
    NSLog(@"%@",NSStringFromCGSize(self.goodsEvalutionTableView.frame.size));
//    self.goodsEvalutionTableView.backgroundColor = [UIColor redColor];
    //点击点击事件
    [self addAGesutreRecognizerForYourView];

    //初始化数据
    [self iniData];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    // Do any additional setup after loading the view from its nib.
}
//初始化数据

- (void)iniData
{
    self.mallTitleLabel.text = @"评价";
    self.contentArray = [[NSMutableArray alloc]init];
    [self.rightButton setTitle:@"发布" forState:UIControlStateNormal];
    [self.rightButton setTitleColor:[UIColor colorWithRed:37/255.0 green:37/255.0 blue:37/255.0 alpha:1] forState:UIControlStateNormal];
    self.rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
    
    noEvalutionArray = [[NSMutableArray alloc]init];
    
    //获取是否已经没有评价的
    for (ZXYOrderDetailModel  * model in self.orderGoodsArray){
        if([model.status integerValue]==1){
            [noEvalutionArray addObject:model];
        }
    }
    
    for (int i = 0 ;i < noEvalutionArray.count;i++){
        
        NSMutableDictionary  * dict = [[NSMutableDictionary alloc]init];
        [dict setObject:@"" forKey:[NSString stringWithFormat:@"%dcontent",i ]];
        [dict setObject:@"100" forKey:[NSString stringWithFormat:@"%dnum",i ]];
        [dict setObject:[[noEvalutionArray objectAtIndex:i]goods_id ] forKey:[NSString stringWithFormat:@"%did",i]];
        [self.contentArray addObject:dict];

    }
}


//判断是否填写的内容有误，当填写的内容中文字长度超过一百的时候返回 1 当全是空的时候返回 2；
- (NSInteger)isSubmitEvalution
{
    int k = 0;
    for (int i = 0; i<self.contentArray.count;i++)
    {
        NSMutableDictionary  * dict = [self.contentArray objectAtIndex:i];
        NSString  *  str = dict[[NSString stringWithFormat:@"%dcontent",i]];
        if(str.length > 100){
            return 1;
            
        }else if([str  isEqualToString:@""]){
            k = k + 1;
            if(k == self.contentArray.count){
                return 2;
            }
        }else{
            
        }
    }
    return 0;
    
}

//点击发布的按钮的方法
-(void)rightBackCliked:(UIButton *)sender
{
 
    switch ([self isSubmitEvalution]) {
        case 0:
        {
            [self submitEvalutionContent];
        }
            break;
        case 1:
        {
            [self showMsg:@"请填写评论内容文字100以下"];
        }
            break;
        case 2:
        {
            [self showMsg:@"请填写评论内容"];

        }
            break;
        default:
            break;
    }
}

//提交商品评价
-(void)submitEvalutionContent;
{
    mRequest = [MarketAPI requestSendComment105WithController:self oderNum:_submitOderNum contentArray:self.contentArray type:@"1"];
}

- (void)requestFinished:(ASIHTTPRequest *)request;
{
    [self stopActivity];
    NSString *tEndString=[[NSString alloc] initWithData:request.responseData encoding:NSUTF8StringEncoding];
    tEndString = [tEndString stringByReplacingOccurrencesOfString:@"\n" withString:@"\n"];
    NSDictionary * dict = [tEndString JSONValue];
    NSLog(@"%@",dict);
    if (!dict){
        NSLog(@"接口错误");
        return;
    }
    if ([dict[@"code"]integerValue] == 0 && dict[@"code"] != nil){
        [self showMsg:@"评价已发送，感谢您的参与~"];
        
        [self.navigationController popViewControllerAnimated:YES];
    }else if ([[dict objectForKey:@"code"]integerValue] == 18 ){
        [self showMsg:@"亲!您已经评价过了!"];
    }else{
        [self showMsg:dict[@"message"]];
    }
}
- (void)requestFailed:(ASIHTTPRequest *)request;
{
    [self stopActivity];
    [self showMsg:@"请求失败，请检查网路设置"];
}

-(void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *kbInfo=[notification userInfo];
    CGSize kbSize=[[kbInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    if (self.currentTextView)
    {
        //设置表视图frame
        [_goodsEvalutionTableView setFrame:CGRectMake(0, 0, SCREENWIDTH, self.view.frame.size.height-kbSize.height-10)];
        //设置表视图可见cell
        NSInteger intCount = self.currentTextView.tag;
        [_goodsEvalutionTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:intCount inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:YES];
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return noEvalutionArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 160;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * goodsCellIndfier = @"goodsCellIndfier";
    LYQGoodsEvalutionViewCell * cell = [tableView dequeueReusableCellWithIdentifier:goodsCellIndfier];
    if(cell == nil){
        
        cell = [[[NSBundle mainBundle]loadNibNamed:@"LYQGoodsEvalutionViewCell" owner:self options:nil]lastObject];
        cell.evalutionTextView.delegate = self;
    }
    cell.Index = indexPath.row;
    [cell getOrderModel:[noEvalutionArray objectAtIndex:indexPath.row] content:[self.contentArray[indexPath.row] objectForKey:[NSString stringWithFormat:@"%ldcontent",(long)indexPath.row]] num:[self.contentArray[indexPath.row] objectForKey:[NSString stringWithFormat:@"%ldnum",(long)indexPath.row]]];
    return cell;
}

//添加点击事件
- (void)addAGesutreRecognizerForYourView
{
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesturedDetected:)]; // 手势类型随你喜欢。
    tapGesture.delegate = self;
    [self.view addGestureRecognizer:tapGesture];
}
//方法
- (void) tapGesturedDetected:(UITapGestureRecognizer *)recognizer
{
    if (self.currentTextView)
    {
        [[[[UIApplication sharedApplication]delegate]window] endEditing:YES];

        //设置表视图frame
        [_goodsEvalutionTableView setFrame:CGRectMake(0, 64, SCREENWIDTH, self.view.frame.size.height-64)];
    }
    [[[[UIApplication sharedApplication]delegate]window] endEditing:YES];
    
    // do something
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - textViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    //获取当前输入框
    self.currentTextView = textView;
    // 监听textView
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewEditChanged:) name:UITextViewTextDidChangeNotification object:_currentTextView];
    return YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}

#pragma mark 监听文本改变

- (void)textViewEditChanged:(NSNotification *)obj
{
    UITextView *textView = (UITextView *)obj.object;
    NSString *toBeString = textView.text;
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqual:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textView markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > MaxNumberOfDescriptionChars) {
                textView.text = [toBeString substringToIndex:MaxNumberOfDescriptionChars];
                self.currentTextView.text = textView.text;
                [self.contentArray[textView.tag ] setObject:textView.text forKey:[NSString stringWithFormat:@"%dcontent",textView.tag ]];
                [self.contentArray[textView.tag ] setObject:@"0" forKey:[NSString stringWithFormat:@"%dnum",textView.tag ]];

            }
        } else {
            // 有高亮选择的字符串，则暂不对文字进行统计和限制
        }
    } else {
        // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (toBeString.length > MaxNumberOfDescriptionChars) {
            textView.text = [toBeString substringToIndex:MaxNumberOfDescriptionChars];
            self.currentTextView.text = textView.text;
            [self.contentArray[textView.tag ] setObject:textView.text forKey:[NSString stringWithFormat:@"%dcontent",textView.tag ]];
            [self.contentArray[textView.tag ] setObject:@"0" forKey:[NSString stringWithFormat:@"%dnum",textView.tag ]];
        }
    }
}

-(void)textViewDidChange:(UITextView *)textView
{
   
    LYQGoodsEvalutionViewCell * cell = (LYQGoodsEvalutionViewCell*)[self.goodsEvalutionTableView  cellForRowAtIndexPath:[NSIndexPath indexPathForRow:textView.tag inSection:0]];
    if (textView.text.length == 0) {
        cell.placeHoderLabel.text = @"写些评价吧亲~";
    }else{
        cell.placeHoderLabel.text = @"";
    }
    
    [self.contentArray[textView.tag ] setObject:textView.text forKey:[NSString stringWithFormat:@"%dcontent",textView.tag ]];

    NSUInteger length = self.currentTextView.text.length;
    if (length >= 100) {
        [self.contentArray[textView.tag ] setObject:@"0" forKey:[NSString stringWithFormat:@"%dnum",textView.tag ]];
        cell.maxNumberLabel.text = @"0";

    } else {
        [self.contentArray[textView.tag ] setObject:[NSString stringWithFormat:@"%d",100 - textView.text.length] forKey:[NSString stringWithFormat:@"%dnum",textView.tag ]];
        cell.maxNumberLabel.text = [NSString stringWithFormat:@"%d",100 - textView.text.length];

    }


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
