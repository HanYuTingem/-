//
//  OverlayView.h
//  SINOCutOutPictureDemo
//
//  Created by xn on 14-6-26.
//  Copyright (c) 2014年 like. All rights reserved.
//
#import <UIKit/UIKit.h>

#import "ToolBarView.h"


#import "CutOutViewController.h"

enum dd{
    ddd = 1,
    ddds
}lll;

@interface OverlayView : UIView<UINavigationControllerDelegate,UIImagePickerControllerDelegate,ToolBarViewDelegate,UIActionSheetDelegate>
{
    UIActionSheet *_actionSheet;
    UIView *_plCameraView;
    ToolBarView *_toolBarView;
    BOOL _cameraOrAlbum;//yes camera  ；no album
}
+(OverlayView*)shaninstance;

@property (strong, nonatomic) id<UIActionSheetDelegate> actionSheetDelegate;
//用于推进UIImagePickerController
@property (strong, nonatomic) UIViewController *viewController;
@property (strong, nonatomic) UIImagePickerController *imagePickerController;
//截取框的高度
@property (strong, nonatomic) NSString *cutHeight;

- (void)layoutSheetActionView;
@end