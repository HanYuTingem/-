//
//  OverlayView.m
//  SINOCutOutPictureDemo
//
//  Created by xn on 14-6-26.
//  Copyright (c) 2014年 like. All rights reserved.
//

#import "OverlayView.h"
#import "JPCommonMacros.h"

//#import "LYQAppDelegate.h"

#import <CoreText/CoreText.h>

static UIImagePickerController *imagePickerCon = nil;

static OverlayView * overView;
@implementation OverlayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
+(OverlayView*)shaninstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        overView = [[self alloc]init];
    });
    return overView;
}

#pragma mark - layoutSheetView
- (void)layoutSheetActionView
{
    _actionSheet = [[UIActionSheet alloc]initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    [_actionSheet addButtonWithTitle:NSLocalizedString(@"拍照", @"Destrutive Button Text")];
    [_actionSheet addButtonWithTitle:NSLocalizedString(@"从相册选择", @"Destrutive Button Text")];
    [_actionSheet addButtonWithTitle:NSLocalizedString(@"取消", @"Cancel Button Text")];
//    _actionSheet.destructiveButtonIndex = 2;//设置销毁按钮，会有红色效果
//    _actionSheet.cancelButtonIndex = 2;//设置取消按钮，如果是最后一个就会被隔开
    [_actionSheet showInView:self.viewController.view];
}

#pragma mark - actionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"button index = %ld",(long)buttonIndex);
    if (buttonIndex == 0) {
        //相机
        [self getStartedImagePicker:UIImagePickerControllerSourceTypeCamera];
    }else if (buttonIndex == 1) {
        //相册
        [self getStartedImagePicker:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    _actionSheet = nil;
    [_actionSheet removeFromSuperview];
}

- (UIImagePickerController *)shareImagePickerController
{
    if (!imagePickerCon) {
        imagePickerCon = [[UIImagePickerController alloc] init];
        imagePickerCon.delegate = self;
        imagePickerCon.allowsEditing = NO;
    }
    return imagePickerCon;
}
#pragma mark - layoutImagePickerController
- (void)getStartedImagePicker:(UIImagePickerControllerSourceType)sourceType
{
    _imagePickerController = [self shareImagePickerController];
    _imagePickerController.sourceType = sourceType;
    if (sourceType == UIImagePickerControllerSourceTypeCamera) {
        //是否显示照相机标准的控件库,默认为YES.//是否设定相框
        _imagePickerController.showsCameraControls = NO;
        _toolBarView = [[[UINib nibWithNibName:@"ToolBarView" bundle:nil] instantiateWithOwner:nil options:nil] objectAtIndex:0];
        _toolBarView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        _toolBarView.toolBarViewDelegate = self;
        _toolBarView.bottomTollView.frame = CGRectMake(0, ScreenHeight-50, ScreenWidth, 50);
        _toolBarView.okBtn.hidden = YES;
        _imagePickerController.cameraOverlayView = _toolBarView;
    }
    [self.viewController presentViewController:_imagePickerController animated:YES completion:^{
    }];
}

#pragma mark - imagePickerControllerDelegate-finish
//完成
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"bababababbababbababababa");
    [picker dismissViewControllerAnimated:NO completion:^{
        UIImage *selectedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        CutOutViewController *cutController = [[CutOutViewController alloc]init];
        cutController.selectedImage = selectedImage;
        cutController.cutHeight = self.cutHeight;
        [self.viewController presentViewController:cutController animated:NO completion:^{
            if (_imagePickerController.sourceType == UIImagePickerControllerSourceTypeCamera) {
                //                UIImageWriteToSavedPhotosAlbum(selectedImage, nil, nil, nil);
            }
        }];
    }];
}
//返回
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - OverlayViewDelegate
//拍照
- (void)takePictureDelegate
{
    NSLog(@"拍照");
    [_imagePickerController takePicture];
    _toolBarView.takePictureBtn.hidden = YES;
    _toolBarView.okBtn.hidden = NO;
}
//返回
- (void)cancelDelegate
{
    NSLog(@"返回");
    [self imagePickerControllerDidCancel:_imagePickerController];
}
//闪光灯
- (void)settingFlashStateDelegate:(int)state
{
    switch (state) {
        case 10://auto
        {
            _imagePickerController.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
            break;
        }
        case 11://open
        {
            _imagePickerController.cameraFlashMode = UIImagePickerControllerCameraFlashModeOn;
            break;
        }
        default://close
        {
            _imagePickerController.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
            break;
        }
    }
}
//转换摄像头
- (void)convertCameraDelegate:(BOOL)witch
{
    if (_imagePickerController.cameraDevice == UIImagePickerControllerCameraDeviceFront) {
    //后置
        _imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    } else {
        _imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    }
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
 */


@end
