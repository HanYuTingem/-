//
//  CommentView.h
//  QQList
//
//  Created by sunsu on 15/6/30.
//  Copyright (c) 2015年 CarolWang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MerchantModel.h"

@protocol HeadImgViewClickedDelegate <NSObject>
-(void)clickPerson;
@end

@interface CommentView : UIView

@property(nonatomic,strong)UIImageView      * headImgView;
@property(nonatomic,strong)UILabel          * phoneLabel;
@property(nonatomic,strong)UILabel          * timeLabel;
@property(nonatomic,strong)UILabel          * commentLabel;
@property(nonatomic,strong)MerchantModel    * merchantComModel;

@property(nonatomic,assign)id<HeadImgViewClickedDelegate>delegate;

+(instancetype)commentViewWithFrame:(CGRect)frame;
-(instancetype)initWithCommentViewWithFrame:(CGRect)frame;

@end
