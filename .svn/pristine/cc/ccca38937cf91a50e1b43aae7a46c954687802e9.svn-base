//
//  CutOutViewController.m
//  SINOCutOutPictureDemo
//
//  Created by like on 14-7-5.
//  Copyright (c) 2014年 like. All rights reserved.
//

#import "CutOutViewController.h"
#import "JPCommonMacros.h"

#import "CutOutBoxView.h"
#import "UIImageScale.h"


#define IOS7_Y isIos7 ? 20 : 0

@interface CutOutViewController ()
{
    UIScrollView *_scrollView;
    UIImageView *_imageView;
    
    float _currentScale;
}
@end

@implementation CutOutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    //隐藏状态栏
    [super viewDidLoad];
    [self layoutShowView];
    [self layoutToolView];
    [self layoutCutOutBoxView];
    [self addGesture];
}
#pragma mark - layoutControls
//展示图片
- (void)layoutShowView
{
    int imageView_h = ScreenHeight-70;
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, IOS7_Y, ScreenWidth, imageView_h)];
    _scrollView.backgroundColor = [UIColor lightGrayColor];
    _scrollView.contentSize = CGSizeMake(ScreenWidth+ScreenWidth/2, imageView_h+imageView_h/2);
    _scrollView.contentOffset = CGPointMake(ScreenWidth/4, imageView_h/4);
    [self.view addSubview:_scrollView];
    
    /*
     在这里对获取到的图片 得到width和height 来做适应屏幕的图片，等比例缩小并剧中展示
     */
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/4, imageView_h/4, ScreenWidth, imageView_h)];
//    _imageView.image = [UIImageScale resizeImageToFitSize:[CutOutViewController fixOrientation:self.selectedImage]];
//    float imageView_x = _imageView.image.size.width == ScreenWidth ? ScreenWidth/4 : (ScreenWidth - _imageView.image.size.width)/2+ScreenWidth/4;
//    float imageView_y = _imageView.image.size.height == imageView_h ? imageView_h/4 : (imageView_h - _imageView.image.size.height)/2 + imageView_h/4;
//    float imageView_w = _imageView.image.size.width;
//    imageView_h = _imageView.image.size.height;
//    _imageView.frame = CGRectMake(imageView_x, imageView_y, imageView_w, imageView_h);
    
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView .image = self.selectedImage;
    [_scrollView addSubview:_imageView];
}
//取消确定按钮
- (void)layoutToolView
{
    ToolBarView *toolBarView = [[[UINib nibWithNibName:@"ToolBarView" bundle:nil] instantiateWithOwner:nil options:nil] objectAtIndex:0];
    toolBarView.frame = CGRectMake(0, ScreenHeight-50-(isIos7?0:20), ScreenWidth, 50);
    toolBarView.toolBarViewDelegate = self;
    toolBarView.bottomTollView.frame = CGRectMake(0, 0, ScreenWidth, 50);

    toolBarView.flashView.hidden = YES;
    toolBarView.convertCameraBtn.hidden = YES;
    toolBarView.takePictureBtn.hidden = YES;
    [self.view insertSubview:toolBarView aboveSubview:_scrollView];
}
//裁剪框
- (void)layoutCutOutBoxView
{
    CutOutBoxView *boxView = [[CutOutBoxView alloc]initWithFrame:CGRectMake(0, (ScreenHeight-70-[self.cutHeight intValue])/2+(isIos7?20:0), 320, [self.cutHeight intValue])];
    [self.view insertSubview:boxView aboveSubview:_scrollView];
}
//添加手势
- (void)addGesture
{
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(handlePinches:)];
    [_scrollView addGestureRecognizer:pinchGesture];
}

- (void)handlePinches:(UIPinchGestureRecognizer *)pinchGesture
{
    //UIPinchGestureRecognizer其中有两个比较重要的变量 scale 和 velocity,前者是一个比例范围,后者是一个变化速率的,也就是说每次变化的一个像素点。
    NSLog(@"_current Scale = %lf  .... pinchGesture.scale = %lf",_currentScale,pinchGesture.scale);
    if (pinchGesture.state == UIGestureRecognizerStateEnded){
        _currentScale = pinchGesture.scale;
    } else if (pinchGesture.state == UIGestureRecognizerStateBegan && _currentScale != 0.0f){
        pinchGesture.scale = _currentScale;
    }
    if (pinchGesture.scale != NAN && pinchGesture.scale != 0.0 && pinchGesture.scale >= 1.0 && pinchGesture.scale <= 3.0){
        pinchGesture.view.transform = CGAffineTransformMakeScale(pinchGesture.scale,
                                                                pinchGesture.scale);
        NSLog(@"a = %lf,   b = %lf,   c = %lf,   d = %lf,   x = %lf,   y = %lf",pinchGesture.view.transform.a,pinchGesture.view.transform.b,pinchGesture.view.transform.c,pinchGesture.view.transform.d,pinchGesture.view.transform.tx,pinchGesture.view.transform.ty);
    } else {
        if (pinchGesture.scale < 1.0) {
            pinchGesture.scale = 1.0;
        }else if (pinchGesture.scale > 3.0) {
            pinchGesture.scale = 3.0;
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ToolBarViewDelegate
//取消
- (void)cancelDelegate
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
//完成
- (void)okDelegate
{
    NSLog(@"这里进行裁剪图片");
    UIWindow *screenWindow = [[UIApplication sharedApplication] keyWindow];
//    UIGraphicsBeginImageContext(screenWindow.frame.size);//全屏截图，包括window
    UIGraphicsBeginImageContextWithOptions(screenWindow.frame.size,YES,2.0);//全屏截图，包括window   第三个参数的意义:原点不变，把图像放大二倍，然后截取同样高宽的二倍长度，就可以得到一个原本高宽显示的高清图片
    
    [screenWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    //    UIGraphicsBeginImageContext(_plCameraView.frame.size);     //currentView 当前的view  创建一个基于位图的图形上下文并指定大小为
    //    [_plCameraView.layer renderInContext:UIGraphicsGetCurrentContext()];//renderInContext呈现接受者及其子范围到指定的上下文
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();//返回一个基于当前图形上下文的图片
    UIGraphicsEndImageContext();//移除栈顶的基于当前位图的图形上下文
    
    //从屏幕中截取整个图片，然后再在这张图片上去截取想要的位置的图片
    CGRect rect = CGRectMake(2, ((ScreenHeight-70-[self.cutHeight intValue])/2+2+(isIos7?20:0))*2, (320-4)*2, ([self.cutHeight intValue]-4)*2);
    viewImage = [self imageFromImage:viewImage inRect:rect];
    //    UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);//然后将该图片保存到图片图
    
    //1、把获取到的image 传递出去，写个通知传递参数
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CutOutImage" object:nil userInfo:[NSDictionary dictionaryWithObject:viewImage forKey:@"cutImage"]];

    [self cancelDelegate];
}
//截取图片
- (UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect {
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    return newImage;
}

#pragma mark - 旋转图片为正确方向
+ (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

@end
