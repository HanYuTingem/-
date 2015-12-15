//
//  WriteReviewsViewController.h
//  QQList
//
//  Created by sunsu on 15/6/29.
//  Copyright (c) 2015年 CarolWang. All rights reserved.
//

#import "BaseViewController.h"
#import "CTAssetsPickerController.h"

@interface WriteReviewsViewController : BaseViewController<UITextViewDelegate,CTAssetsPickerControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIGestureRecognizerDelegate,UIActionSheetDelegate>{
    NSMutableArray * _photoArray;
}

@property(nonatomic,strong)UITextView           * writeTextView;
@property(nonatomic,strong)UIView               * photoView;
@property(nonatomic,strong)NSString             * ownerCommentId;
@property(nonatomic,strong)NSString             * ownerId;
@property(nonatomic,strong)UILabel              * surplusWordsLabel;
@property(nonatomic,strong)UIButton             * addPhotoButton;//添加按钮
@end
