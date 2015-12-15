//
//  SaomiaoViewController.m
//  HCheapShang
//
//  Created by hai on 14-10-13.
//  Copyright (c) 2014年 qiaohongchao. All rights reserved.
//

#pragma mark -----------说明及注意事项
/*
 
 说明：
 
 以下在ViewController中  出现对屏幕的判断时  
 遵循的都是以下规则：
 
 if (IPHONE5) {
    IPHONE5        屏幕下的对应设置
 }else if (IPHONE4){
    IPHONE4        屏幕下的对应设置
 }else if (IPHONE6){
    IPHONE6        屏幕下的对应设置
 } else {
    IPHONE6PLUS    屏幕下的对应设置
 }
 
 */

#import "SaomiaoViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ZBarSDK.h"
#import "HistoryObject.h"
#import "WebInfoViewController.h"
#import "WebPreviewViewController.h"
#import "TextInfoViewController.h"
#import "XNHistoryListViewController.h"
#import "YXSqliteHeader.h"
@interface SaomiaoViewController () < ZBarReaderDelegate ,UIImagePickerControllerDelegate ,ZBarReaderViewDelegate >

/*
 *_readerView        扫一扫底层View
 *_scanView          扫描界面的View
 *_timer             刷新扫描线
 *_QrCodeline        扫描线
 *isshanguandeng     是否开启闪关灯   0未开启   1开启
 *naviView           自定义导航栏
 *isBtnClicked       是否点击的是闪关灯按钮 进而判断设备是否存在闪光灯   0是   1不是
 *noticeLabel        木有闪光灯时的提示
 */
{
    ZBarReaderView *_readerView;
    UIView *_scanView;
    NSTimer *_timer;
    UIView *_QrCodeline;
    BOOL isshanguandeng;
    UIView *naviView;
    BOOL isBtnClicked;
    UILabel *noticeLabel;
    BOOL  transiting;
}

/*
 *urlString             扫描到的内容
 *titleString           扫描到内容的标题
 *zoomSlider            放大镜
 *openAlbumState        打开或关闭相册的状态 0为关闭 1为打开
 *shanguangdengButton   闪关灯按钮
 */
@property (nonatomic, strong) NSString *urlString;
@property (nonatomic, strong) NSString *titleString;
@property (nonatomic, strong) UISlider *zoomSlider;
@property (nonatomic, assign) int openAlbumState;
@property (nonatomic, strong) UIButton *shanguangdengButton;

@end

@implementation SaomiaoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

#pragma mark --------------初始化界面
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self setNavigationBarWithState:1 andIsHideLeftBtn:NO andTitle:@"扫一扫"];
//    [backImageView setImage:[UIImage imageNamed:@"videodetails_title_btn_back.png"]];
//    backImageView.frame = CGRectMake(10, 33, 10, 18);
    [self.leftButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //去除多个button同事点击的效果
        [self.shanguangdengButton setExclusiveTouch:YES];
    for (UIView *view in self.readerView.subviews) {
        [view removeFromSuperview];
    }
    
     _readerView.allowsPinchZoom = NO;
    _readerView . torchMode = 0;
     [_readerView setZoom:1.0 animated:NO];
    _readerView . frame = CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64);
    _readerView . tracksSymbols = NO ;
    _readerView . readerDelegate = self;
    //初始化扫描界面
    [self.view addSubview:_readerView];
    [_readerView start];
    [ self setScanView ];
    
    isshanguandeng = YES;
    isBtnClicked = NO;
    
    //一进入就关闭闪光灯
    [self turnOffLed];
  
     _timer=[NSTimer scheduledTimerWithTimeInterval: 0.01 target: self selector: @selector (moveUpAndDownLine) userInfo: nil repeats: YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeLiight) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

-(void)closeLiight
{
    //绿色
    [self.shanguangdengButton setImage:[UIImage imageNamed:@"light_close.png"] forState:UIControlStateNormal];
    if (self.shanguangdengButton.selected) {
         isBtnClicked = NO;
        [self turnOffLed];
    } else {
 
    }
}
-(void)backButtonClick{
   [self StopTimr];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    isshanguandeng = YES;
    self.openAlbumState = 0;

//    [self turnOffLed];
    
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        NSLog(@"相机权限受限");
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请在设备的\"设置-隐私-相机\"中允许访问相机。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
}

//初始化界面
- ( void )setScanView
{
    _scanView = [[ UIView alloc ] initWithFrame : CGRectMake ( 0 , 0 , SCREENWIDTH , SCREENHEIGHT - 64)];
    _scanView . backgroundColor =[ UIColor clearColor ];
    
    //背景图片
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - IOS7_HEGHT)];
    //给放大镜添加操作手势
    UIPinchGestureRecognizer *twoFingerPinch = [[UIPinchGestureRecognizer alloc] initWithTarget: self action: @selector(twoFingerPinch:)];
    [ _scanView addGestureRecognizer: twoFingerPinch ];
    
    if (IPHONE5 || IPHONE6) {
        image.image = [UIImage imageNamed:@"ios扫一扫背景640-1008(3).png"];
    }else if (IPHONE4){
        image.image = [UIImage imageNamed:@"saoyisao- 6.0.png"];
    } else {
        image.image = [UIImage imageNamed:@"ios扫一扫背景640-1008(3).png"];
    }
    [_scanView addSubview:image];
    
    //底部背景图
    UIImageView *bottomImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bottomBgImage.png"]];
    bottomImageView.frame = CGRectMake(0, SCREENHEIGHT - 77  - 64 , SCREENWIDTH, 77);
    [_scanView addSubview:bottomImageView];
    
    
    //画中间的扫描线
    _QrCodeline = [[UIView alloc] init];
    if (IPHONE5) {
        _QrCodeline.frame = CGRectMake(42, 140 - 64, 236, 2);
    }else if (IPHONE4){
        _QrCodeline.frame = CGRectMake(42, 99 - 64, 236, 2);
    }else if (IPHONE6){
        _QrCodeline.frame = CGRectMake(50, 155 - 64, 276, 2);
    } else {
        _QrCodeline.frame = CGRectMake(54, 165 - 64, 306, 2);
    }
    _QrCodeline.backgroundColor = [UIColor greenColor];
    [_scanView addSubview:_QrCodeline];
    [_readerView addSubview:_scanView];
    
    //用于开启相册
    UIButton *xiangceButton = [[UIButton alloc]init];
    //去除多个button同事点击的效果
        [xiangceButton setExclusiveTouch:YES];
    [xiangceButton setImage:[UIImage imageNamed:@"xiangCeImage.png"] forState:UIControlStateNormal];
    if (IPHONE4 || IPHONE5) {
        [xiangceButton setFrame:CGRectMake(16, SCREENHEIGHT - 47 - 20  - 64 , 47, 47)];
    }else if (IPHONE6){
        [xiangceButton setFrame:CGRectMake(26, SCREENHEIGHT - 47 - 20 - 64  , 47, 47)];
    } else {
        [xiangceButton setFrame:CGRectMake(36, SCREENHEIGHT - 47 - 20  - 64 , 47, 47)];
    }
    [xiangceButton addTarget:self action:@selector(turnOffxiangce) forControlEvents:UIControlEventTouchUpInside];
    [_scanView addSubview:xiangceButton];
    
    //用于查看扫一扫历史记录
    UIButton *historyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //去除多个button同事点击的效果
    [historyButton setExclusiveTouch:YES];
    [historyButton setImage:[UIImage imageNamed:@"historyBtnImage.png"] forState:UIControlStateNormal];
    if (IPHONE4 || IPHONE5) {
        [historyButton setFrame:CGRectMake(SCREENWIDTH - 16 - 47, SCREENHEIGHT - 47 - 20 - 64, 47, 47)];
    }else if (IPHONE6){
        [historyButton setFrame:CGRectMake(SCREENWIDTH - 16 - 47 - 10, SCREENHEIGHT - 47 - 20 - 64, 47, 47)];
    } else {
        [historyButton setFrame:CGRectMake(SCREENWIDTH - 16 - 47 - 20, SCREENHEIGHT - 47 - 20 - 64, 47, 47)];
    }
    [historyButton.titleLabel setFont:[UIFont boldSystemFontOfSize: 20.0]];
    [historyButton addTarget:self action:@selector(gotoHistoryList:) forControlEvents:UIControlEventTouchUpInside];
    [_scanView addSubview:historyButton];
    
    //调节镜头远近的UISlider
    self.zoomSlider = [[UISlider alloc]init];
    [_scanView addSubview:self.zoomSlider];
    self.zoomSlider.minimumValue = 1.0;
    self.zoomSlider.maximumValue = 2.0;
    self.zoomSlider.value = 1.0;
    [self.zoomSlider addTarget:self action:@selector(zoomImage:) forControlEvents:UIControlEventValueChanged];
    self.zoomSlider.minimumValueImage = [UIImage imageNamed:@"progressDown.png"];
    self.zoomSlider.maximumValueImage = [UIImage imageNamed:@"progressUp.png"];
    [self.zoomSlider setThumbImage:[UIImage imageNamed:@"progressBtnImage1.png"] forState:UIControlStateNormal];
    [self.zoomSlider setThumbImage:[UIImage imageNamed:@"progressBtnImage1.png"] forState:UIControlStateHighlighted];
    [self.zoomSlider setMinimumTrackImage:[UIImage imageNamed:@"progressBg.png"] forState:UIControlStateNormal];
    [self.zoomSlider setMaximumTrackImage:[UIImage imageNamed:@"progressBg.png"] forState:UIControlStateNormal];
    CGAffineTransform rotation = CGAffineTransformMakeRotation( - 1.57079633 );
    [self.zoomSlider setTransform:rotation];
    if (IPHONE5) {
        [self.zoomSlider setFrame:CGRectMake(SCREENWIDTH - 25, 150 - 64, 10, 220)];
    }else if (IPHONE4){
        [self.zoomSlider setFrame:CGRectMake(SCREENWIDTH - 20, 120 - 64, 10, 220)];
    }else if (IPHONE6){
        [self.zoomSlider setFrame:CGRectMake(SCREENWIDTH - 30, 175 - 64, 10, 250)];
    } else {
        [self.zoomSlider setFrame:CGRectMake(SCREENWIDTH - 35, 185 - 64, 10, 280)];
    }
    
    //用于开启闪关灯
    self.shanguangdengButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.shanguangdengButton setImage:[UIImage imageNamed:@"light_open.png"] forState:UIControlStateSelected];
    [self.shanguangdengButton setImage:[UIImage imageNamed:@"light_close.png"] forState:UIControlStateNormal];
    [self.shanguangdengButton setFrame:CGRectMake(SCREENWIDTH / 2 - 25, SCREENHEIGHT - 50 - 10 - 64 , 50, 50)];
    [self.shanguangdengButton.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [self.shanguangdengButton addTarget:self action:@selector(turnOffLed) forControlEvents:UIControlEventTouchUpInside];
    [_scanView addSubview:self.shanguangdengButton];
    
    // + 号按钮
    UIButton *upButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //去除多个button同事点击的效果
    [upButton setExclusiveTouch:YES];
    if (IPHONE4) {
        upButton.frame = CGRectMake(292, 120 - 64, 25, 25);
    } else {
        upButton.frame = CGRectMake(292, 150 - 64, 25, 25);
    }
    upButton.backgroundColor = [UIColor clearColor];
    [upButton addTarget:self action:@selector(zoomUpImage) forControlEvents:UIControlEventTouchUpInside];
    [_scanView addSubview:upButton];
    
    // - 号按钮
    UIButton *DownButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //去除多个button同事点击的效果
    [DownButton setExclusiveTouch:YES];
    if (IPHONE4) {
        DownButton.frame = CGRectMake(292, 315 - 64, 25, 25);
    } else {
        DownButton.frame = CGRectMake(292, 345 - 64, 25, 25);
    }
    DownButton.backgroundColor = [UIColor clearColor];
    [DownButton addTarget:self action:@selector(zoomDownImage) forControlEvents:UIControlEventTouchUpInside];
    [_scanView addSubview:DownButton];
}

- (void)zoomUpImage
{
    if (self.zoomSlider.value < self.zoomSlider.maximumValue) {
        self.zoomSlider.value = self.zoomSlider.value + 0.1;
        [_readerView setZoom:self.zoomSlider.value animated:NO];
    }
}

- (void)zoomDownImage
{
    if (self.zoomSlider.value > 1.0) {
        self.zoomSlider.value = self.zoomSlider.value - 0.1;
        [_readerView setZoom:self.zoomSlider.value animated:NO];
    }
}

//进入相册
-(void)turnOffxiangce
{
    self.openAlbumState = 1;
    //进入到相册
    ZBarReaderController *xreader = [ZBarReaderController new];
    xreader.showsHelpOnFail = NO;
    xreader.allowsEditing = NO;
    xreader.readerDelegate = self;
    xreader.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:xreader animated:NO completion:^{
        [self StopTimr];
    }];
}

//进入历史记录
- (void)gotoHistoryList:(UIButton *)button
{
    XNHistoryListViewController *historyVC = [[XNHistoryListViewController alloc]initWithNibName:@"XNHistoryListViewController" bundle:nil];
    [_timer invalidate];
    _timer = nil;
    [self StopTimr];

     [self.navigationController pushViewController:historyVC animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self StopTimr];
}


- (void)StopTimr
{
    [_readerView stop];
    if ( _readerView . torchMode == 1 ) {
        _readerView . torchMode = 0 ;
    }
    [ self stopTimer ];
    
}
#pragma mark -------------对放大镜操作的处理
- (void)twoFingerPinch:(UIPinchGestureRecognizer *)recognizer
{
    if (recognizer.scale > 1.0) {
        if (_readerView.zoom < 2.0) {
            _readerView.zoom = _readerView.zoom + (recognizer.scale - 1);
            self.zoomSlider.value = _readerView.zoom + (recognizer.scale - 1);
        }
    } else if (recognizer.scale < 1.0) {
        if (_readerView.zoom > 1.0) {
            _readerView.zoom = _readerView.zoom - (1 - recognizer.scale);
            self.zoomSlider.value = _readerView.zoom - (1 - recognizer.scale);
        }
    }
    recognizer.scale = 1;
}

- (void)zoomImage:(UISlider *)sender
{
    [_readerView setZoom:sender.value animated:NO];
}

#pragma mark ------------开启timer 对扫描线的运动进行设置
//屏幕移动扫描线。
bool first = YES;
//二维码的横线移动
- ( void )moveUpAndDownLine
{
    if (IPHONE5) {
        int y = _QrCodeline.frame.origin.y;
        if (first) {
            y  = y + 1;
            if (y >= 375 - 64) {
                first = NO;
            }
        } else {
            y = y - 1 ;
            if (y <= 140 - 64) {
                first = YES;
            }
        }
        _QrCodeline.frame = CGRectMake(42, y, 236, 2);
    }else if (IPHONE4){
        int y = _QrCodeline.frame.origin.y;
        if (first) {
            y  = y + 1;
            if (y >= 308 - 64) {
                first = NO;
            }
        } else {
            y = y - 1 ;
            if (y <= 102 - 64) {
                first = YES;
            }
        }
        _QrCodeline.frame = CGRectMake(42, y, 236, 2);
    }else if (IPHONE6){
        int y = _QrCodeline.frame.origin.y;
        if (first) {
            y  = y + 1;
            if (y >= 438 - 64) {
                first = NO;
            }
        } else {
            y = y - 1 ;
            if (y <= 155 - 64) {
                first = YES;
            }
        }
        _QrCodeline.frame = CGRectMake(50, y, 276, 2);
    } else {
        //iphone6 plus
        int y = _QrCodeline.frame.origin.y;
        if (first) {
            y  = y + 1;
            if (y >= 480 - 64) {
                first = NO;
            }
        } else {
            y = y - 1 ;
            if (y <= 165 - 64) {
                first = YES;
            }
        }
        _QrCodeline.frame = CGRectMake(54, y, 306, 2);
    }
}

- ( void )stopTimer
{
    if ([_timer isValid] == YES ) {
        [_timer invalidate];
        _timer = nil ;
    }
}

#pragma mark  --------------闪光灯的处理
-(void)turnOffLed
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch]) {
        //有闪光灯
        if (isshanguandeng == NO) {
            self.shanguangdengButton.selected = YES;//
        } else {
            self.shanguangdengButton.selected = NO;
        }
        [device lockForConfiguration:nil];
        if (isshanguandeng == NO) {
            [device setTorchMode: AVCaptureTorchModeOn];//
            self.shanguangdengButton.selected = YES;
            isshanguandeng = YES;
        } else {
            [device setTorchMode: AVCaptureTorchModeOff];
            self.shanguangdengButton.selected = NO;
            isshanguandeng = NO;
        }
//         [self layoutSaoYiSaoNavControl];
        [device unlockForConfiguration];
    } else {
        //无闪光灯
        if (isBtnClicked == YES) {
            isBtnClicked = NO;
            if (noticeLabel) {
                [noticeLabel removeFromSuperview];
            }
            noticeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, _scanView.frame.size.height - 100, 280, 21)];
            
            if (IPHONE5) {
                noticeLabel. frame = CGRectMake ( 0 , SCREENHEIGHT - 180 - 64, SCREENWIDTH , 20 );
            }else if(IPHONE4){
                noticeLabel. frame = CGRectMake ( 0 , SCREENHEIGHT - 165 - 64, SCREENWIDTH , 20 );
            }else if (IPHONE6){
                noticeLabel. frame = CGRectMake ( 0 , SCREENHEIGHT - 220 - 64, SCREENWIDTH , 20 );
            } else {
                noticeLabel. frame = CGRectMake ( 0 , SCREENHEIGHT - 250 - 64, SCREENWIDTH , 20 );
            }
            
            noticeLabel.backgroundColor = [UIColor clearColor];
            noticeLabel.textAlignment = NSTextAlignmentCenter;
            noticeLabel.text = @"无此设备";
            noticeLabel.textColor = [UIColor whiteColor ];
            noticeLabel.font = [UIFont systemFontOfSize: 15.0];
            [_scanView addSubview:noticeLabel];
            
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(disappearTheLabel) object:nil];
            
            [self performSelector:@selector(disappearTheLabel) withObject:nil afterDelay: 2.0];
            
        } else {
            isBtnClicked = YES;
        }
    }
}

-(void)disappearTheLabel
{
    [noticeLabel removeFromSuperview];
    isBtnClicked = YES;
}

#pragma mark ------------处理得到的信息 ---
//处理扫描到的信息
-( void )readerView:( ZBarReaderView *)readerView didReadSymbols:( ZBarSymbolSet *)symbols fromImage:( UIImage *)image
{
    for (ZBarSymbol *sys in symbols) {
//        if (self.openAlbumState == 1) {
//            [picker dismissViewControllerAnimated:YES completion:^{
//                [self performSelector: @selector(presentResult:) withObject: symbol afterDelay: .005];
//            }];
//        } else {
//            [self performSelector: @selector(presentResult:) withObject: symbol afterDelay: .005];
//        }
        [self presentResult:sys];
    }
    
 
}

//处理相册选择到的二维码信息
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    id< NSFastEnumeration > results = [info objectForKey: ZBarReaderControllerResults];
    NSLog(@"self.openAlbumState:%d", self.openAlbumState);
    if ([info count] > 2) {
        int quality = 0;
        ZBarSymbol *bestResult = nil;
        for(ZBarSymbol *sym in results) {
            int q = sym.quality;
            if(quality < q) {
                quality = q;
                bestResult = sym;
            }
        }
        
        //如果点击【相册】打开的选择照片则dismiss  ，否则不做操作
        if (self.openAlbumState == 1) {
            [picker dismissViewControllerAnimated:YES completion:^{
                [self performSelector: @selector(presentResult:) withObject: bestResult afterDelay: 0.001];
            }];
        } else {
            [self performSelector: @selector(presentResult:) withObject: bestResult afterDelay: .001];
        }
    } else {
        ZBarSymbol *symbol = nil;
        for(symbol in results)
            break;
        //如果点击【相册】打开的选择照片则dismiss  ，否则不做操作
        if (self.openAlbumState == 1) {
            [picker dismissViewControllerAnimated:YES completion:^{
                [self performSelector: @selector(presentResult:) withObject: symbol afterDelay: .005];
            }];
        } else {
            [self performSelector: @selector(presentResult:) withObject: symbol afterDelay: .005];
        }
    }
    isBtnClicked = NO;
    isshanguandeng = YES;
    [self turnOffLed];
}

//处理得到的信息
-(void)presentResult:(ZBarSymbol*)sym
{
    if (sym) {
        NSString *tempStr = sym.data;
        /*
        NSASCIIStringEncoding = 1,		 0..127 only
        NSNEXTSTEPStringEncoding = 2,
        NSJapaneseEUCStringEncoding = 3,
        NSUTF8StringEncoding = 4,
        NSISOLatin1StringEncoding = 5,
        NSSymbolStringEncoding = 6,
        NSNonLossyASCIIStringEncoding = 7
        NSShiftJISStringEncoding = 8,         kCFStringEncodingDOSJapanese
        NSISOLatin2StringEncoding = 9,
        NSUnicodeStringEncoding = 10,
        NSWindowsCP1251StringEncoding = 11,    Cyrillic; same as AdobeStandardCyrillic
        NSWindowsCP1252StringEncoding = 12,
        NSWindowsCP1253StringEncoding = 13,
        NSWindowsCP1254StringEncoding = 14,
        NSWindowsCP1250StringEncoding = 15,
        NSISO2022JPStringEncoding = 21,
        NSMacOSRomanStringEncoding = 30,
        */
        if ([sym.data canBeConvertedToEncoding:NSShiftJISStringEncoding]) {
            tempStr = [NSString stringWithCString:[tempStr cStringUsingEncoding:NSShiftJISStringEncoding] encoding:NSUTF8StringEncoding];
            NSLog(@" 1   sym.data:%@", sym.data);
            if (!tempStr) {
                NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(NSASCIIStringEncoding);
                tempStr = [NSString stringWithCString:[sym.data cStringUsingEncoding:NSShiftJISStringEncoding] encoding:enc];
                NSLog(@"1   Unicode tempStr:%@", tempStr);
            }
        } else {
            
            if ([sym.data canBeConvertedToEncoding:NSISOLatin1StringEncoding]) {
                tempStr = [NSString stringWithCString:[tempStr cStringUsingEncoding:NSISOLatin1StringEncoding] encoding:NSUTF8StringEncoding];
                NSLog(@" 2   sym.data:%@", sym.data);
            }
          
            if (!tempStr) {
                NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUnicode);
                tempStr = [NSString stringWithCString:[sym.data cStringUsingEncoding:NSShiftJISStringEncoding] encoding:enc];
                NSLog(@"2   Unicode tempStr:%@", tempStr);
            }
            NSLog(@"tempStr111:%@", tempStr);
        }
        
        self.urlString = tempStr;
        NSLog(@"  3   tempStr111:%@", tempStr);
        //获取系统当前的时间戳
        NSDate* dat = [NSDate dateWithTimeIntervalSinceNow: 0];
        NSTimeInterval a = [dat timeIntervalSince1970] * 1000;
        NSString *timeString = [NSString stringWithFormat:@"%f", a];//转为字符型
        
        if ([tempStr hasPrefix:@"http://"] || [tempStr hasPrefix:@"https://"]) {
            NSURL *url = [NSURL URLWithString:tempStr];
            NSString *urlStr = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
            NSString *firstString;
            NSString *finalStr = nil;
            NSArray *urlArr = [urlStr componentsSeparatedByString:@"<title>"];
            
            if ([urlArr count] >= 2 ) {
                firstString = [urlStr componentsSeparatedByString:@"<title>"][1];
                if (firstString) {
                    finalStr = [firstString componentsSeparatedByString:@"</title>"][0];
                }
                if (finalStr) {
                    self.titleString = finalStr;
                }
            }
            
            FMDatabase* database = [FMDatabase databaseWithPath:[self databasePath]];
            [database open];
            if (![database open]) {
                NSLog(@"Could not open db");
                return;
            }
            FMResultSet *rs = [database executeQuery:[NSString stringWithFormat:@"SELECT COUNT(*) as 'count' FROM %@", TABLE_NAME]];
            while ([rs next]) {
                NSLog(@"数据库中数据的个数:%d",[rs intForColumn:@"count"]);
                if ([rs intForColumn:@"count"] < 50) {
                    NSString *insertSql = [NSString stringWithFormat:
                                           @"INSERT INTO '%@' ('%@', '%@', '%@', '%@') VALUES ('%@', '%@', '%@', '%@')",
                                           TABLE_NAME, TABLE_TITLE, TABLE_CONTENT, TABLE_TYPE, TABLE_DATE, self.titleString, self.urlString, @"1", timeString];
                    BOOL res = [database executeUpdate:insertSql];
                    if (!res) {
                        NSLog(@"web error when insert db table");
                        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"存储记录失败，请重新扫描。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                        [av show];
                    } else {
                        NSLog(@"web success to insert db table");
                        HistoryObject *historyObject = [[HistoryObject alloc]init];
                        if (finalStr) {
                            historyObject.title = finalStr;
                        } else {
                            historyObject.title = @"网址";
                        }
                        historyObject.content = self.urlString;
                        historyObject.type = 1;
                        historyObject.saoDate = timeString;
                        [self performSelector:@selector(WebInfoViewController:) withObject:historyObject afterDelay:1.0];

                    }
                } else {
                    NSString *deleteSql = [NSString stringWithFormat:
                                           @"delete from %@ where %@ in (select %@ from %@ order by %@ desc limit 1)", TABLE_NAME, TABLE_DATE, TABLE_DATE, TABLE_NAME,TABLE_DATE];
                    BOOL res = [database executeUpdate:deleteSql];
                    if (!res) {
                        NSLog(@"web error when delete db table");
                        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"数据已满50条，删除第一条记录失败，请重新扫描。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                        [av show];
                    } else {
                        NSLog(@"web success to delete db table");
                        NSString *insertSql = [NSString stringWithFormat:
                                               @"INSERT INTO '%@' ('%@', '%@', '%@', '%@') VALUES ('%@', '%@', '%@', '%@')",
                                               TABLE_NAME, TABLE_TITLE, TABLE_CONTENT, TABLE_TYPE, TABLE_DATE, self.titleString, self.urlString, @"1", timeString];
                        BOOL res = [database executeUpdate:insertSql];
                        if (!res) {
                            NSLog(@"web error when insert db table");
                            UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"存储记录失败，请重新扫描。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                            [av show];
                        } else {
                            NSLog(@"web success to insert db table");
                            HistoryObject *historyObject = [[HistoryObject alloc]init];
                            if (finalStr) {
                                historyObject.title = finalStr;
                            } else {
                                historyObject.title = @"网址";
                            }
                            historyObject.content = self.urlString;
                            historyObject.type = 1;
                            historyObject.saoDate = timeString;
                            [self performSelector:@selector(WebInfoViewController:) withObject:historyObject afterDelay:1.0];

                        }
                    }
                }
            }
            [database close];
        } else {
            FMDatabase* database = [FMDatabase databaseWithPath:[self databasePath]];
            [database open];
            if (![database open]) {
                 return;
            }
             FMResultSet *rs = [database executeQuery:[NSString stringWithFormat:@"SELECT COUNT(*) as 'count' FROM %@", TABLE_NAME]];
            while ([rs next]) {
                NSLog(@"数据库中数据的个数:%d",[rs intForColumn:@"count"]);
                if ([rs intForColumn:@"count"] < 50) {
                    NSString *insertSql = [NSString stringWithFormat:
                                           @"INSERT INTO '%@' ('%@', '%@', '%@', '%@') VALUES ('%@', '%@', '%@', '%@')",
                                           TABLE_NAME, TABLE_TITLE, TABLE_CONTENT, TABLE_TYPE, TABLE_DATE, @"", self.urlString, @"2", timeString];
                    BOOL res = [database executeUpdate:insertSql];
                    if (!res) {
                        NSLog(@"text error when insert db table");
                        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"存储记录失败，请重新扫描。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                        [av show];
                    } else {
                        NSLog(@"text success to insert db table");
                        HistoryObject *historyObject = [[HistoryObject alloc]init];
                        historyObject.title = @"文本信息";
                        historyObject.content = self.urlString;
                        historyObject.type = 2;
                        historyObject.saoDate = timeString;
                         [self performSelector:@selector(TextInfoViewController:) withObject:historyObject afterDelay:1.0];
 
                    }
                } else {
                    NSString *deleteSql = [NSString stringWithFormat:
                                           @"delete from %@ where %@ in (select %@ from %@ order by %@ desc limit 1)", TABLE_NAME, TABLE_DATE, TABLE_DATE, TABLE_NAME,TABLE_DATE];
                    BOOL res = [database executeUpdate:deleteSql];
                    if (!res) {
                        NSLog(@"web error when delete db table");
                        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"数据已满50条，删除第一条记录失败，请重新扫描。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                        [av show];
                    } else {
                        NSLog(@"web success to delete db table");
                        NSString *insertSql = [NSString stringWithFormat:
                                               @"INSERT INTO '%@' ('%@', '%@', '%@', '%@') VALUES ('%@', '%@', '%@', '%@')",
                                               TABLE_NAME, TABLE_TITLE, TABLE_CONTENT, TABLE_TYPE, TABLE_DATE, @"", self.urlString, @"2", timeString];
                        BOOL res = [database executeUpdate:insertSql];
                        if (!res) {
                            NSLog(@"text error when insert db table");
                            UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"存储记录失败，请重新扫描。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                            [av show];
                        } else {
                            NSLog(@"text success to insert db table");
                            HistoryObject *historyObject = [[HistoryObject alloc]init];
                            historyObject.title = @"文本信息";
                            historyObject.content = self.urlString;
                            historyObject.type = 2;
                            historyObject.saoDate = timeString;
                            [self performSelector:@selector(TextInfoViewController:) withObject:historyObject afterDelay:1.0];
 
                        }
                    }
                }
            }
            [database close];
        }
    }
}

- (void)TextInfoViewController:(HistoryObject *)historyObject{
    TextInfoViewController *textInfoVC = [[TextInfoViewController alloc]initWithNibName:@"TextInfoViewController" bundle:nil];
    textInfoVC.historyObject = historyObject;
    [self.navigationController pushViewController:textInfoVC animated:YES];
    [self StopTimr];

}
- (void)WebInfoViewController:(HistoryObject *)historyObject{
    WebInfoViewController *textInfoVC = [[WebInfoViewController alloc]initWithNibName:@"WebInfoViewController" bundle:nil];
    textInfoVC.historyObject = historyObject;
    [self.navigationController pushViewController:textInfoVC animated:YES];
    [self StopTimr];
}
-(NSString *)databasePath
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex: 0 ];
    NSString *dbPath = [path stringByAppendingPathComponent:DATABASE_NAME];
    return dbPath;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
        isshanguandeng = YES;
        isBtnClicked = NO;
        [self turnOffLed];
    }];
    
}

- (void)readerControllerDidFailToRead:(ZBarReaderController*)reader withRetry:(BOOL)retry
{
    if(retry){
        //retry == 1 选择图片为非二维码。
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"未发现二维码或二维码不正确" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        alert.delegate = self;
        [alert show];
    }
}

-(BOOL)shouldAutorotate
{
    return NO;
}

@end
