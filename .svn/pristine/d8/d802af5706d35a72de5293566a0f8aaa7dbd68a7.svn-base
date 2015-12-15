//
//  shopManView.h
//  MarketManage
//
//  Created by 许文波 on 15/7/28.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface shopManView : UIView


-(instancetype)initWithFrame:(CGRect)frame arrowImageView:(NSString *)Address userName:(NSString *)name userTel:(NSString *)tel userAdress:(NSString *)adress arrow:(NSString *)arrow;
//无地址时显示
@property (strong, nonatomic)  UIView *noAdress;
/** 图片 */
@property(nonatomic,strong) UIImageView *leftImageView;
/** 联系人 */
@property (strong, nonatomic)  UILabel *userName;
/** 联系地址 */
@property (strong, nonatomic)  UILabel *userAdress;
/** 联系电话 */
@property (strong, nonatomic)  UILabel *userTel;
/** 箭头 */
@property(nonatomic,strong) UIImageView *arrowImageView;

@property (nonatomic,strong) ZXYCommitOrderRequestModel  * oderModel;

/** 设置用户地址*/
- (void)setUserAddress;

@end
