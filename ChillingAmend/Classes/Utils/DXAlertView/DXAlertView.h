//
//  ILSMLAlertView.h
//  MoreLikers
//
//  Created by xiekw on 13-9-9.
//  Copyright (c) 2013年 谢凯伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DXAlertView : UIView

- (id)initWithnoTitle:(NSString *)title
          contentText:(NSString *)content
      leftButtonTitle:(NSString *)leftTitle
     rightButtonTitle:(NSString *)rigthTitle;

- (id)initWithTitle:(NSString *)title
        contentText:(NSString *)content
    leftButtonTitle:(NSString *)leftTitle
   rightButtonTitle:(NSString *)rigthTitle;

- (id)initWithTitle:(NSString *)title
        contentText:(NSString *)content
    leftButtonTitle:(NSString *)leftTitle
   rightButtonTitle:(NSString *)rigthTitle
          giftImage:(UIImage *)giftImage
         orImageUrl:(NSString *)imageUrl;

- (id)initShangChengAlertWithTitle:(NSString *)title
                       contentText:(NSString *)content
                   leftButtonTitle:(NSString *)leftTitle
                  rightButtonTitle:(NSString *)rigthTitle;

- (void)show;
- (void)closeBtn;

@property (nonatomic, copy) dispatch_block_t leftBlock;
@property (nonatomic, copy) dispatch_block_t rightBlock;
@property (nonatomic, copy) dispatch_block_t dismissBlock;

@end

@interface UIImage (colorful)

+ (UIImage *)imageWithColor:(UIColor *)color;



@end