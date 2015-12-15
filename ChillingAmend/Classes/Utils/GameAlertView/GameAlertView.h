//  游戏提示框
//  GameAlertView.h
//  ChillingAmend
//
//  Created by 许文波 on 15/1/6.
//  Copyright (c) 2015年 SinoGlobal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameAlertView : UIView

- (id)initWithTitle:(NSString *)title
        contentText:(NSString *)content
    leftButtonTitle:(NSString *)leftTitle
   rightButtonTitle:(NSString *)rigthTitle;

- ( id )initGameErrorMessageWithContent:(NSString *)content;

- (void)show;

@property (nonatomic, copy) dispatch_block_t leftBlock;
@property (nonatomic, copy) dispatch_block_t rightBlock;
@property (nonatomic, copy) dispatch_block_t dismissBlock;

@property (nonatomic, copy) dispatch_block_t gameErrorDismissBlock;
@end


@interface UIImage (ccolorful)

+ (UIImage *)imageWithColor:(UIColor *)color;


@end