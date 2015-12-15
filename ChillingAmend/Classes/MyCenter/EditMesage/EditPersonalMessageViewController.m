//  编辑资料
//  EditPersonalMessageViewController.m
//  ChillingAmend
//
//  Created by 许文波 on 14/12/19.
//  Copyright (c) 2014年 SinoGlobal. All rights reserved.
//

#import "EditPersonalMessageViewController.h"
#import "EditDetailMessageViewController.h"
#import "LYQSelectPickerView.h"
#import "BSaveMessage.h"
#import "UIImageView+WebCache.h"
#import "GTMBase64.h"
#import "ITTPictureDealWithObject.h"
#import <MobileCoreServices/MobileCoreServices.h>

// 提示框偏移量
#define kYOffset 0

@interface EditPersonalMessageViewController ()
<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, LYQSelectPickerViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate, EditDelegate>
{
    NSString *hostTitleString; // 热词
    NSInteger addButtonTag; // 判断是否是添加热词的按钮
    UIView *maskview; // 弹窗遮罩层
    NSArray *cityAry; // 地区数据
    NSString *areaStr; // 保存选中地区信息 防止pickerview打开不滑动时无数据bug
    LYQSelectPickerView *selectViewPicker ; // 生日选择pickerview
    NSMutableArray *hostWordsDataArray; // 存放添加热词成功后返回的热词数据
    UIView *lastView; // 加标签页面
    UIView *sendbackView; // 加标签背景(半透明)
    NSMutableArray *hotButtonArray; // 标签buttons
    UIImage *headImage; // 头像
}

@property (weak, nonatomic) IBOutlet UIScrollView *editPersonMessageScrollView; // 整个界面的scrollview
@property (weak, nonatomic) IBOutlet UIImageView *personHeadImageView; // 头像
@property (strong, nonatomic) IBOutlet UIView *promptView;//提示框
@property (weak, nonatomic) IBOutlet UITextField *addHostWordsTextFiled;//添加热词的textfiled
@property (weak, nonatomic) IBOutlet UIButton *compileButton;//确定按钮
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;//取消按钮
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;//关闭按钮
@property (weak, nonatomic) IBOutlet UIView *addHotwordsView;; // 添加热词的view
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *hotWordsButtonArray; // 添加热词的数组
@property (weak, nonatomic) IBOutlet UIView *signatureView; // 个性签名的view
@property (weak, nonatomic) IBOutlet UILabel *signatureLabel; // 个性签名
@property (weak, nonatomic) IBOutlet UIView *messageView; // 所有相关信息
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel; // 昵称
@property (weak, nonatomic) IBOutlet UILabel *sexLabel; // 性别
@property (weak, nonatomic) IBOutlet UILabel *emailLabel; // 邮箱
@property (weak, nonatomic) IBOutlet UILabel *birthdayLabel; // 生日
@property (strong, nonatomic) IBOutlet UIView *birthBg; // 生日背景
@property (strong, nonatomic) IBOutlet UIView *areaBg; // 地区背景
@property (strong, nonatomic) IBOutlet UIPickerView *areaPickerview; // 地区pickerview
@property (weak, nonatomic) IBOutlet UILabel *areaLabel; // 显示地区
@property (weak, nonatomic) IBOutlet UIView *changePasswordView; // 修改密码
@property (weak, nonatomic) IBOutlet UIButton *signatureBtn; // 个性签名
@property (weak, nonatomic) IBOutlet UIButton *nicknameBtn; // 昵称
@property (weak, nonatomic) IBOutlet UIButton *sexBtn; // 性别
@property (weak, nonatomic) IBOutlet UIButton *emailBtn; // 邮箱
@property (weak, nonatomic) IBOutlet UIButton *birthBtn; // 生日
@property (weak, nonatomic) IBOutlet UIButton *areaBtn; // 区域
@property (weak, nonatomic) IBOutlet UIButton *changePwdBtn; // 修改密码

- (IBAction)addHostWordsActionCliked:(id)sender; // 加热词
- (IBAction)complieButtonActionCliked:(id)sender; // 个性标签的确定
- (IBAction)cancelButtonActionCliked:(id)sender; // 个性标签的取消
- (IBAction)closeButtonActionCliked:(id)sender; // 个性标签的关闭
- (IBAction)cancelSlect:(id)sender; // 取消选择点击事件
- (IBAction)saveArea:(id)sender; // 保存地区点击事件
- (IBAction)editDetailMessageAction:(id)sender; // 编辑资料
@end

@implementation EditPersonalMessageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // scrollview contentsize
    [_editPersonMessageScrollView setContentSize:CGSizeMake(self.view.frame.size.width, 528)];
    hotButtonArray = [[NSMutableArray alloc] init];
    // 导航栏
    [self setNavigationBarWithState:1 andIsHideLeftBtn:NO andTitle:@"编辑资料"];
    // 设置圆角 头像
    [_personHeadImageView.layer setCornerRadius:_personHeadImageView.frame.size.width/2];
    [_personHeadImageView.layer setMasksToBounds:YES];
    // 头像添加手势
    [self personalHeadImageViewAddTapGesture];
    //初始化辽宁地区
    cityAry = [[NSArray alloc] initWithObjects:@"沈阳", @"大连",@"鞍山", @"抚顺", @"本溪", @"丹东", @"锦州", @"营口", @"阜新", @"辽阳", @"盘锦",@"铁岭",@"朝阳", @"葫芦岛", nil];
    //初始化选择生日pickerview
    selectViewPicker = [[LYQSelectPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 256)];
    selectViewPicker.delegate = self;
    [self.birthBg addSubview:selectViewPicker];
    // 多个button同时点击
    _signatureBtn.exclusiveTouch = YES;
    _nicknameBtn.exclusiveTouch = YES;
    _sexBtn.exclusiveTouch = YES;
    _emailBtn.exclusiveTouch = YES;
    _birthBg.exclusiveTouch = YES;
    _areaBg.exclusiveTouch = YES;
    _compileButton.exclusiveTouch = YES;
    _cancelButton.exclusiveTouch = YES;
    _deleteButton.exclusiveTouch = YES;
    // 地区代理
    _areaPickerview.delegate = self;
    _areaPickerview.dataSource = self;
    
    [self changedSignatureViewAndmessageRewardView];
    
    [self setPopHostView];
    
    [self hiddenHostBtn];
    
    // 请求数据
//    [self sendRequest];
    NSMutableDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"usernameMessage"];
    [self setUserMessage:dic];
}

#pragma mark 设置弹出框得背景及frame
- (void)setPopHostView
{
    _promptView.frame = iPhone5 ? CGRectMake((FRAMNE_W(self.view) - 225)/2, FRAMNE_H(self.view)/2 - 200, 225, 153):CGRectMake((FRAMNE_W(self.view) - 225)/2, FRAMNE_H(self.view)/2 - 240, 225, 153);
    [[[[UIApplication sharedApplication]delegate]window ] addSubview:_promptView];
    lastView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    lastView.backgroundColor = [UIColor clearColor];
    [[[UIApplication sharedApplication] keyWindow] addSubview:lastView];
    lastView.hidden = YES;
    sendbackView = [[UIView alloc] initWithFrame:lastView.bounds];
    sendbackView.backgroundColor = [UIColor blackColor];
    sendbackView.alpha  = 0.6;
    [lastView addSubview:sendbackView];
    [lastView addSubview:_promptView];
}

#pragma mark 点击半透明的senbanckview UITapGestureRecognizer 方法
- (void)sendbackViewGesture:(UIGestureRecognizer*)tap
{
    lastView.hidden = YES;
    [_addHostWordsTextFiled resignFirstResponder];
}

#pragma mark 头像添加手势
- (void)personalHeadImageViewAddTapGesture
{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(personalHeadGesture:)];
    tap.numberOfTouchesRequired = 1;
    tap.numberOfTapsRequired = 1;
    [_personHeadImageView setUserInteractionEnabled:YES];
    [_personHeadImageView addGestureRecognizer:tap];
}

#pragma mark 点击头像调用的方法
- (void)personalHeadGesture:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"上传图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从手机相册选择" ,nil];
    actionSheet.tag = 100;
    [actionSheet showInView:self.view];
}

#pragma mark actionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        // for iphone
        [self snapImage];
    } else if (buttonIndex ==1) {
        [self pickImage];
    }
}

#pragma mark 拍照
- (void) snapImage
{
    UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        pickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
        pickerImage.mediaTypes = [NSArray arrayWithObjects:(NSString *)kUTTypeImage,nil];
        
    }
    pickerImage.delegate = self;
    pickerImage.allowsEditing = YES; // 自定义照片样式
    [self presentViewController:pickerImage animated:YES completion:nil];
}

#pragma mark 相册选取
- (void) pickImage
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        ipc.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:ipc.sourceType];
    }
    ipc.delegate = self;
    ipc.allowsEditing = YES;
    [self presentViewController:ipc animated:YES completion:nil];
}

#pragma mark Delegate method UIImagePickerControllerDelegate
// 图像选取器的委托方法，选完图片后回调该方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    // 当图片不为空时显示图片并保存图片
    if (image != nil) {
        // 压缩图片
        CGSize imagesize = image.size;
        imagesize.height = 313;
        imagesize.width = 313;
        //对图片大小进行压缩--
        image = [ITTPictureDealWithObject scaleToSize:image size:imagesize];
        headImage = image;
        NSData *imageData = UIImageJPEGRepresentation(image, 0.00001);
        if (image == nil) {
            image = [UIImage imageWithData:imageData];
            return ;
        }
        // 转化为data
        NSData *data;
        // 判断图片是不是png格式的文件
        if (UIImagePNGRepresentation(image)) {
            //返回为png图像。
            data = UIImagePNGRepresentation(image);
        } else {
            //返回为JPEG图像。
            data = UIImageJPEGRepresentation(image, 1.0);
        }
        // 上传头像
        [self requestChangeHeadImage:data];
    }
    //关闭相册界面
    [picker dismissModalViewControllerAnimated:YES];
}

#pragma mark - 点击空白处键盘消失
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

#pragma mark - 显示半透明背景
- (void)showMaskView
{
    if (!maskview) {
        maskview = [[UIView alloc] initWithFrame:self.view.frame];
        maskview.backgroundColor = [UIColor colorWithWhite:.2 alpha:.5];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMaskView)];
        [maskview addGestureRecognizer:tap];
        [self.view addSubview:maskview];
    }
    maskview.alpha = 1;
}

#pragma mark - 隐藏半透明背景
- (void)hideMaskView
{
    for (UIView *view in maskview.subviews) {
        if ([[view class] isSubclassOfClass:[UIView class]]) {
            [view removeFromSuperview];
        }
    }
    [UIView animateWithDuration:0.3 animations:^{
        [self.birthBg setFrame:CGRectMake(0, ScreenHeight, 320, 216)];
    }];
    [UIView animateWithDuration:0.3 animations:^{
        [self.areaBg setFrame:CGRectMake(0, ScreenHeight, 320, 216)];
    }];
    maskview.alpha = 0;
}

#pragma mark - UIPickerviewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return cityAry.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    return cityAry[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
{
    areaStr = cityAry[row];
}

#pragma mark - 取消选择
- (IBAction)cancelSlect:(id)sender
{
    [self hideMaskView];
}

#pragma mark - 保存居住地区
- (IBAction)saveArea:(id)sender
{
    [self hideMaskView];
    self.areaLabel.text = areaStr;
    if ([kkUserquyu isEqual:areaStr]) {
        [self showStringMsg:@"修改成功" andYOffset:kYOffset];
    } else {
        mainRequest.tag = 113;
        [mainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI changeAreaUserId:kkUserId andAddress:areaStr]];
    }
}

#pragma mark - LYQSelectPickerViewDeelagte 保存生日
- (void)selectPickerViewWithDateStr:(NSString *)dateStr
{
    [self hideMaskView];
    self.birthdayLabel.text = dateStr;
    if ([kkUsershengri isEqual:dateStr]) {
        [self showStringMsg:@"修改成功" andYOffset:kYOffset];
    } else {
        mainRequest.tag = 112;
        [mainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI changeBirthUserId:kkUserId andBirthday:dateStr]];
    }
}

#pragma mark - 隐藏生日pickerview
- (void)cancelPickerView
{
    [self hideMaskView];
}

#pragma mark 隐藏全部的标签
- (void)hiddenHostBtn
{
    int i = 0;
    for (UIButton * button in _hotWordsButtonArray) {
        button.tag =i;
        button.hidden = YES;
        [button setTitle:@"" forState:UIControlStateNormal];
        [button setExclusiveTouch:YES];
        i = i + 1;
    }
    if (hostWordsDataArray.count <= 0) {
        UIButton * hostButton = [_hotWordsButtonArray objectAtIndex:0];
        hostButton.tag = 0;
        hostButton.hidden = NO;
        [hostButton setBackgroundImage: [UIImage imageNamed:@"mydata_content_bg_label_add.png"] forState:UIControlStateNormal];
    } else {
        for ( int i = 0; i < hostWordsDataArray.count; i++) {
            UIButton * hostButton = [_hotWordsButtonArray objectAtIndex:i];
            hostButton.hidden = NO;
            [hostButton setTitle:[hostWordsDataArray objectAtIndex:i] forState:UIControlStateNormal];
            hostButton.titleLabel.font = [UIFont boldSystemFontOfSize:11.0];
            hostButton.titleLabel.textColor = kkBColor;
            [hostButton setBackgroundImage:[UIImage imageNamed:@"mydata_content_bg_label.png"] forState:UIControlStateNormal];
        }
        if (hostWordsDataArray.count < 8) {
            UIButton * beginButton = [_hotWordsButtonArray objectAtIndex:0];
            UIButton * lastButton = [_hotWordsButtonArray objectAtIndex:hostWordsDataArray.count];
            beginButton.tag = lastButton.tag;
            lastButton.tag = 0;
            lastButton.hidden = NO;
            [lastButton setBackgroundImage: [UIImage imageNamed:@"mydata_content_bg_label_add.png"] forState:UIControlStateNormal];
        } else {
            UIButton * beginButton = [_hotWordsButtonArray objectAtIndex:0];
            beginButton.tag = 8;
        }
        [self changedSignatureViewAndmessageRewardView];
    }
}

#pragma mark 根据添加的标签改变其他view的frame
- (void)changedSignatureViewAndmessageRewardView
{
    if (hostWordsDataArray.count > 3) {
        _signatureView.frame = CGRectMake( _signatureView.frame.origin.x, CGRectGetMaxY(_addHotwordsView.frame), _signatureView.frame.size.width, _signatureView.frame.size.height);
        _messageView.frame = CGRectMake(_messageView.frame.origin.x, CGRectGetMaxY(_signatureView.frame) + 10, _messageView.frame.size.width, _messageView.frame.size.height);
        _changePasswordView.frame = CGRectMake(_changePasswordView.frame.origin.x,CGRectGetMaxY(_messageView.frame) + 10, _changePasswordView.frame.size.width, _changePasswordView.frame.size.height);
    } else  {
        _signatureView.frame = CGRectMake( _signatureView.frame.origin.x, CGRectGetMaxY(_addHotwordsView.frame) - CGRectGetHeight(_addHotwordsView.frame)/2 + 3, _signatureView.frame.size.width, _signatureView.frame.size.height);
        _messageView.frame = CGRectMake(_messageView.frame.origin.x, CGRectGetMaxY(_signatureView.frame) + 10, _messageView.frame.size.width, _messageView.frame.size.height);
        _changePasswordView.frame = CGRectMake(_changePasswordView.frame.origin.x,CGRectGetMaxY(_messageView.frame) + 10, _changePasswordView.frame.size.width, _changePasswordView.frame.size.height);
    }
    [_editPersonMessageScrollView setContentSize:CGSizeMake(self.view.frame.size.width, CGRectGetMaxY(_changePasswordView.frame) + 10)];
}

#pragma mark 请求用户数据
- (void)sendRequest
{
    if (![GCUtil connectedToNetwork]) {
        [self showStringMsg:@"网络连接失败" andYOffset:0];
    } else {
        [mainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI personMessageUserId:kkUserId]];
        [self showMsg:nil];
        mainRequest.tag = 99;
    }
}

#pragma mark 修改头像
- (void) requestChangeHeadImage:(NSData*)data
{
    if (![GCUtil connectedToNetwork]) {
        [self showStringMsg:@"网络连接失败" andYOffset:0];
    } else {
        [self showMsg:@"上传中"];
        mainRequest.tag = 111;
        [mainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI changeHeadImageUserId:kkUserId andPic:[GTMBase64 stringByEncodingData:data]]];
    }
}

#pragma mark 添加个性标签
- (void)requestAddHostData
{
    if (![GCUtil connectedToNetwork]) {
        [self showStringMsg:@"网络连接失败" andYOffset:0];
    } else {
        [self showMsg:nil];
        mainRequest.tag = 110;
        [mainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI addHotwordUserId:kkUserId andTag:_addHostWordsTextFiled.text]];
        
    }
}

#pragma mark 修改个性标签
- (void)requestChangedHostData
{
    if (![GCUtil connectedToNetwork]) {
        [self showStringMsg:@"网络连接失败" andYOffset:0];
    } else {
        [self showMsg:nil];
        mainRequest.tag = 120;
        [mainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI changeHotwordUserId:kkUserId andOld_tag:hostTitleString andNew_tag:_addHostWordsTextFiled.text]];
    }
}

#pragma mark 删除个性标签方法
- (void)deleteHostData
{
    if (![GCUtil connectedToNetwork]) {
        [self showStringMsg:@"网络连接失败" andYOffset:0];
    } else {
        [self showMsg:nil];
        mainRequest.tag = 130;
        [mainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI deleteHotwordUserId:kkUserId andTag:hostTitleString]];
    }
}

#pragma mark GCRequestDelegate
- (void)GCRequest:(GCRequest *)aRequest Finished:(NSString *)aString
{
    NSLog(@"personcenter = %@", aString);
    [self hide];
    NSMutableDictionary *dict = [aString JSONValue];
    if ( !dict ) {
        [self showStringMsg:@"网络连接失败" andYOffset:0];
        return;
    }
    
    if ([[dict objectForKey:@"code"] isEqual:@"0"]) {
        if (mainRequest.tag == 111) { // 头像
            _personHeadImageView.image = headImage;
        } else {
            // 设置单利 保存数据 模型 NSUserDefaults
            [kkUserInfo resetInfo:dict];
            [BSaveMessage saveUserMessage:dict];
            [GCUtil saveLajiaobijifenWithJifen:[dict objectForKey:@"jifen"]];
            [self setUserMessage:dict];
        }
        
    }
    if (mainRequest.tag != 99) {
        [self showStringMsg:[dict valueForKey:@"message"] andYOffset:kYOffset];
    }
    
}

- (void)GCRequest:(GCRequest *)aRequest Error:(NSString *)aError
{
    [self hide];
    NSLog(@"%@", aError);
    [self showStringMsg:@"网络连接失败！" andYOffset:kYOffset];
}

#pragma mark 设置用户信息
- (void)setUserMessage:(NSMutableDictionary*)dic
{
    // 头像
    [_personHeadImageView setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"img"]] placeholderImage:[UIImage imageNamed:@"defaultimgmy_img.png"]];
    // 标签
    if (hostWordsDataArray) {
        [hostWordsDataArray removeAllObjects];
        hostWordsDataArray = nil;
    }
    if (![[dic objectForKey:@"tag"] isEqual:@""]) {
        hostWordsDataArray = [[NSMutableArray alloc] initWithArray:[[dic objectForKey:@"tag"] componentsSeparatedByString:@","]];
    } else hostWordsDataArray = [[NSMutableArray alloc] init];
    [self hiddenHostBtn];
    // 签名
    NSString *tempStr = [dic objectForKey:@"remark"];
    if ([tempStr isEqual:@""]) {
        tempStr = @"唔...什么都没写...";
    } else {
        _signatureLabel.text = tempStr;
        _signatureLabel.frame = [GCUtil changeLabelFrame:_signatureLabel andSize:CGSizeMake(226, 65) andFontSize:[UIFont systemFontOfSize:14.0f]];
    }
    // 昵称
    _nickNameLabel.text = [dic objectForKey:@"nike_name"];
    // 性别
    NSString *sex = [dic objectForKey:@"sex"];
    if (sex.intValue == 1) {
        _sexLabel.text = @"男";
    } else if (sex.intValue == 2) {
        _sexLabel.text = @"女";
    } else _sexLabel.text = @"";
    // 邮箱
    _emailLabel.text = [dic objectForKey:@"email"];
    // 生日
    _birthdayLabel.text = [dic objectForKey:@"shengri"];
    // 居住地
    _areaLabel.text = [dic objectForKey:@"quyu"];
}

- (void)didReceiveMemoryWarning
{
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

#pragma mark 资料修改事件
- (IBAction)editDetailMessageAction:(id)sender
{
    EditDetailMessageViewController *editDetailMessage = [[EditDetailMessageViewController alloc] init];
    UIButton *btn = (UIButton*)sender;
    switch (btn.tag) {
        case 100: // 修改签名
            editDetailMessage.btnTag = 100;
            break;
        case 101: // 修改昵称
            editDetailMessage.btnTag = 101;
            break;
        case 102: // 修改邮箱
            editDetailMessage.btnTag = 102;
            break;
        case 103: // 修改性别
            editDetailMessage.btnTag = 103;
            break;
        case 104: // 修改生日
            {
                [self showMaskView];
                // 给日期选择赋值
                if (self.birthdayLabel.text && ![self.birthdayLabel.text isEqual:@""]) {
                    // string转成date
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                    NSDate *date = [dateFormatter dateFromString:self.birthdayLabel.text];
                    // 选择器显示
                    selectViewPicker.datePicker.date = date;
                }
                [UIView animateWithDuration:0.3 animations:^{
                    [self.birthBg setFrame:CGRectMake(0, ScreenHeight - 216, 320, 216)];
                }];
                [self.view bringSubviewToFront:self.birthBg];
            }
            break;
        case 105: // 修改居住地
            {
                [self showMaskView];
                // 给居住地选择赋值
                int row = 0;
                if (self.areaLabel.text && ![self.areaLabel.text isEqual:@""]) {
                    for (int i = 0; i < cityAry.count; i++) {
                        if ([self.areaLabel.text isEqual:cityAry[i]]) {
                            row = i;
                        }
                    }
                }
                [UIView animateWithDuration:0.3 animations:^{
                    [self.areaBg setFrame:CGRectMake(0, ScreenHeight - 216, 320, 216)];
                }];
                areaStr = cityAry[row];
                [self.areaPickerview selectRow:row inComponent:0 animated:YES];
                [self.view bringSubviewToFront:self.areaBg];
            }
            break;
        case 106: // 修改密码
            editDetailMessage.btnTag = 106;
            break;
        default:
            break;
    }
    if (btn.tag == 104 || btn.tag == 105) {
        
    } else {
        editDetailMessage.editDelegate = self;
        [self.navigationController pushViewController:editDetailMessage animated:YES];
    }
}

#pragma mark editMessageDelegate
- (void)messageChanged:(NSInteger)tag
{
    switch (tag) {
        case 100: // 修改签名
            _signatureLabel.text = kkUserRemark;
            _signatureLabel.frame = [GCUtil changeLabelFrame:_signatureLabel andSize:CGSizeMake(226, 65) andFontSize:[UIFont systemFontOfSize:14.0f]];
            break;
        case 101: // 修改昵称
            _nickNameLabel.text = kkUserNickName;
            break;
        case 102: // 修改邮箱
            _emailLabel.text = kkUseremial;
            break;
        case 103: // 修改性别
            if (kkUserSex.intValue == 1) {
                _sexLabel.text = @"男";
            } else if (kkUserSex.intValue == 2) {
                _sexLabel.text = @"女";
            } else _sexLabel.text = @"";
            break;
        default:
            break;
    }
}

- (void)messageChangedContent:(NSString*)content andTag:(NSInteger)tag
{
    switch (tag) {
        case 100: // 修改签名
            _signatureLabel.text = content;
            _signatureLabel.frame = [GCUtil changeLabelFrame:_signatureLabel andSize:CGSizeMake(226, 65) andFontSize:[UIFont systemFontOfSize:14.0f]];
            break;
        case 101: // 修改昵称
            _nickNameLabel.text = content;
            break;
        case 102: // 修改邮箱
            _emailLabel.text = content;
            break;
        case 103: // 修改性别
            if (content.intValue == 1) {
                _sexLabel.text = @"男";
            } else if (content.intValue == 2) {
                _sexLabel.text = @"女";
            } else _sexLabel.text = @"";
            break;
        default:
            break;
    }
}

#pragma mark 点击热词的button
- (IBAction)addHostWordsActionCliked:(id)sender
{
    
    UIButton * button = (UIButton*)sender;
    lastView.hidden = NO;
    if (button.tag > 0) {
        [_compileButton setTitle:@"保存" forState:UIControlStateNormal];
        [_cancelButton setTitle:@"删除" forState:UIControlStateNormal];
        addButtonTag = 101;
        hostTitleString = button.titleLabel.text;
        _addHostWordsTextFiled.text = hostTitleString;
    } else {
        _addHostWordsTextFiled.text = @"";
        addButtonTag = 100;
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_compileButton setTitle:@"确定" forState:UIControlStateNormal];
        
    }
    
}

#pragma mark 显示标签修改提示
- (void)showChangeHostWordsMBProgressHUD:(NSString*)string
{
    MBProgressHUD *hostWordsHUD = [[MBProgressHUD alloc] initWithView:_promptView];
    // 外边框
    hostWordsHUD.margin = 10;
    // 大小
    hostWordsHUD.minSize = CGSizeMake(150, 40);
    // 样式
    hostWordsHUD.mode = MBProgressHUDModeText;
    // 文字
    hostWordsHUD.labelText = string;
    [_promptView addSubview:hostWordsHUD];
    [hostWordsHUD show:YES];
    [hostWordsHUD hide:YES afterDelay:1.5];
}

#pragma mark 个性标签提示框的确定
- (IBAction)complieButtonActionCliked:(id)sender
{
    [_addHostWordsTextFiled resignFirstResponder];
    if (_addHostWordsTextFiled.text.length <= 0) {
        [self showChangeHostWordsMBProgressHUD:@"输入内容不能为空"];
    } else if (_addHostWordsTextFiled.text.length > 6) {
        [self showChangeHostWordsMBProgressHUD:@"输入内容不能大于6位"];
    } else {
        if (addButtonTag == 100) {//判断是否是添加热词的 按钮 如果是
            //判断中文英文，及数字
            if ([GCUtil isTextFiledNumber:_addHostWordsTextFiled.text andCount:6]) {
                //*添加个性标签
                [self requestAddHostData];
                lastView.hidden = YES;
            } else {
                _addHostWordsTextFiled.text = @"";
                [self showChangeHostWordsMBProgressHUD:@"输入内容有非法字符"];
            }
        } else {  // 判断是否是添加热词的 按钮 如果不是
            if ([GCUtil isTextFiledNumber:_addHostWordsTextFiled.text andCount:6]) {////修改个性标签
                if (![hostTitleString isEqual:_addHostWordsTextFiled.text]) {
                    //修改个性标签
                    [self requestChangedHostData];
                }
                lastView.hidden = YES;
            } else {
                [self showChangeHostWordsMBProgressHUD:@"输入内容有非法字符"];
            }
        }
    }
}

#pragma mark 个性标签提示框的取消
- (IBAction)cancelButtonActionCliked:(id)sender
{
    [_addHostWordsTextFiled resignFirstResponder];
    lastView.hidden = YES;
    UIButton * button = (UIButton*)sender;
    if (![button.titleLabel.text isEqual:@"取消"]) {
        if ([hostTitleString isEqual:_addHostWordsTextFiled.text]) {
            //删除个性标签
            [self deleteHostData];
            [self hiddenHostBtn];
        } else {
            [self showStringMsg:@"您要删除的标签名不是本标签!" andYOffset:kYOffset];
        }
    }
}


#pragma mark 个性标签的关闭按钮
- (IBAction)closeButtonActionCliked:(id)sender
{
    lastView.hidden = YES;
    [_addHostWordsTextFiled resignFirstResponder];
    
}

@end
