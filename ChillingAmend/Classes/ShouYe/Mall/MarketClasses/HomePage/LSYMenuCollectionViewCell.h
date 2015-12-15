//
//  LSYMenuCollectionViewCell.h
//  MarketManage
//
//  Created by liangsiyuan on 15/1/12.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSYMenuCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *menuBtnIMG;
@property (weak, nonatomic) IBOutlet UILabel *menuName;
@property (nonatomic,strong)NSDictionary * dic;
@property (nonatomic,copy)NSString * host;
@end
