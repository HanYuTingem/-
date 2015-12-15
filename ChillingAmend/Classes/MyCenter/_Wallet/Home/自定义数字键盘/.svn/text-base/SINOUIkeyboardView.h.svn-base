//
//  SINOUIkeyboardView.h
//  SINOUIKeyboard
//
//  Created by yll on 15/10/28.
//  Copyright © 2015年 yll. All rights reserved.
//

#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width

#define KPercenX    kScreenWidth / 320.0
#define KPercenY    kScreenHeight / 568.0

/** 键盘宽 */
#define kKeyBoardWidth   kScreenWidth
/** 键盘高 */
#define kKeyBoardHeight  220

/** 按钮竖排间隔 */
#define kButtonLeft    0.5
/** 按钮横排间隔 */
#define kButtonTop   0.5
/** 键盘左右两边距 */
#define kKeyBoardLeft 0
/** 键盘上下两边距 */
#define kKeyBoardTop  0

/** 按钮的宽 */
#define kButtonWidth    ((kKeyBoardWidth-kKeyBoardLeft*2-kButtonLeft*2)/3.0)
/** 按钮高 */
#define kButtonHeight   ((kKeyBoardHeight-kKeyBoardTop*2-kButtonTop*3)/4.0)

/** 默认键盘背景颜色 */
#define kKeyboardbackgroundColor   [UIColor blackColor]

/** 默认键盘背景颜色 */
#define kButtonNormalColor    [UIColor whiteColor]

/** 默认按钮的字体文本颜色 */
#define kButtonTextTitleColor   [UIColor blackColor]
/** 默认按钮字体大小 */
#define kButtonTextTitleFont   [UIFont systemFontOfSize:25]
/** 默认按钮边框宽 */
#define kButtonBorderWidth    0
/** 默认按钮边框颜色 */
#define kButtonBorderColor    [UIColor whiteColor].CGColor


#import <UIKit/UIKit.h>


typedef NS_ENUM(int,KeyboardLowerLeftButtonType){
    /** 当按钮默认不显示时 */
    KeyboardLowerLeftButtonHidden,
    /** 当按钮作为完成用时 */
    KeyboardLowerLeftButtonComplete,
    /** 当按钮作为小数点用时 */
    KeyboardLowerLeftButtonDecimalPoint
};

@protocol SINOUIkeyboardViewDelegate <NSObject>
@optional

//是否能给输入 yes：可以输入 no：不能输入
- (BOOL)keyboardClickNumbertext:(UITextField *)textField textStr:(NSString *)textStr;

//是否能删除 yes：可以 no：不能
- (BOOL)keyboardDeleteNumbertext:(UITextField *)textField;

//隐藏键盘
- (void)keyboardHidden;

@end

@interface SINOUIkeyboardView : UIView
//添加键盘，添加在window上，单例形式
+(UIView *)keyboardViewDelegate:(id<SINOUIkeyboardViewDelegate>)delegate text:(UITextField *)textField;
//添加键盘，添加在window上，创建多个
- (UIView *)keyboardViewDelegate:(id<SINOUIkeyboardViewDelegate>)delegate text:(UITextField *)textField;
////键盘弹出
//+ (void)show;
//键盘隐藏
+ (void)hidden;
+ (SINOUIkeyboardView *)sharedView;

/** 清除所有赋值数据，恢复默认格式 */
+ (void)clearAllData;

@property (nonatomic, assign) id<SINOUIkeyboardViewDelegate> delegate;
/** 键盘背景颜色 */
@property (nonatomic, weak) UIColor *keyboardbackgroundColor;
/** 每个按钮背景颜色 */
@property (nonatomic, weak) UIColor *buttonNormalColor;
/** 每个按钮点击时的背景图片 */
@property (nonatomic, weak) UIImage *buttonHighlightedImage;
/** 每个按钮正常时的背景图片 */
@property (nonatomic, weak) UIImage *buttonNormalImage;
/** 每个按钮字体颜色 */
@property (nonatomic, weak) UIColor *buttonTextTitleColor;
/** 每个按钮字体大小 */
@property (nonatomic, weak) UIFont *buttonTextTitleFont;


/** 左下按钮设置 如果此按钮需要单独设置样式时用*/
/** 左下按钮背景颜色*/
@property (nonatomic, weak) UIColor *lowerLeftButtonNormalColor;
/** 左下按钮点击时的背景图片 */
@property (nonatomic, weak) UIImage *lowerLeftButtonHighlightedImage;
/** 左下按钮正常时的背景图片 */
@property (nonatomic, weak) UIImage *lowerLeftButtonNormalImage;
/** 左下按钮字体颜色 */
@property (nonatomic, weak) UIColor *lowerLeftButtonTextTitleColor;
/** 左下按钮字体大小 */
@property (nonatomic, weak) UIFont *lowerLeftButtonTextTitleFont;
/** 左下按钮文字 默认是完成，（如果作为完成用时，可以给此参数赋值进行改变）） */
@property (nonatomic, strong) NSString *lowerLeftButtonTextTitle;


/** 右下按钮设置 如果此按钮需要单独设置样式时用*/
/** 右下按钮背景颜色*/
@property (nonatomic, weak) UIColor *lowerRightButtonNormalColor;
/** 右下按钮图片 image*/
@property (nonatomic, strong) NSString *lowerRightButtonNormalSetImageStr;
/** 右下按钮点击时的背景图片 */
@property (nonatomic, weak) UIImage *lowerRightButtonHighlightedImage;
/** 右下按钮正常时的背景图片 */
@property (nonatomic, weak) UIImage *lowerRightButtonNormalImage;
/** 右下按钮字体颜色 */
@property (nonatomic, weak) UIColor *lowerRightButtonTextTitleColor;
/** 右下按钮字体大小 */
@property (nonatomic, weak) UIFont *lowerRightButtonTextTitleFont;
/** 右下按钮文字 默认是删除，（可以给此参数赋值进行改变，如果要用图片，需要给此参数置空） */
@property (nonatomic, strong) NSString *lowerRightButtonTextTitle;


/** 判断左下按钮的状态 */
@property (nonatomic, assign) KeyboardLowerLeftButtonType keyboardLowerLeftButtonType;
/** 是否需要随机键盘 默认是no：不随机 yes：要随机 */
@property (nonatomic, assign) BOOL keyboardRandom;
/** 如果按钮全用图片  yes:用图片  no:不用*/
@property (nonatomic, assign) BOOL keyboardbackgroundIsImage;
/** 如果按钮全用图片  图片名的前缀,10是完成 11是删除图片 图片从0开始命名*/
@property (nonatomic, copy) NSString *imageName;//
@end
