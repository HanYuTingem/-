//
//  ToolBarView.h
//  SINOCutOutPictureDemo
//
//  Created by xn on 14-6-26.
//  Copyright (c) 2014年 like. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ToolBarViewDelegate;

@interface ToolBarView : UIView
@property (strong, nonatomic) id<ToolBarViewDelegate> toolBarViewDelegate;

//闪光灯
@property (weak, nonatomic) IBOutlet UIView *flashView;
@property (weak, nonatomic) IBOutlet UIButton *autoFlashBtn;
@property (weak, nonatomic) IBOutlet UIButton *openFlashBtn;
@property (weak, nonatomic) IBOutlet UIButton *closeFlashBtn;

//转换摄像头
@property (weak, nonatomic) IBOutlet UIButton *convertCameraBtn;

//底部工具栏
@property (weak, nonatomic) IBOutlet UIView *bottomTollView;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *takePictureBtn;
@property (weak, nonatomic) IBOutlet UIButton *okBtn;

- (IBAction)settingFlashStateAction:(id)sender;

- (IBAction)convertCameraBtnAction:(id)sender;

- (IBAction)cancelAction:(id)sender;
- (IBAction)okAction:(id)sender;
- (IBAction)takePickerAction:(id)sender;
@end

@protocol ToolBarViewDelegate <NSObject>
- (void)takePictureDelegate;
- (void)cancelDelegate;
- (void)okDelegate;
- (void)settingFlashStateDelegate:(int)state;
- (void)convertCameraDelegate:(BOOL)witch;
@end
