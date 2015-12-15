//
//  LSYRecommendView.h
//  MarketManage
//
//  Created by liangsiyuan on 15/1/13.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LSYRecommendViewDelegate <NSObject>
@optional
-(void)didTapGoods:(NSString * )goods_id;
@end
@interface LSYRecommendView : UIView<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong)NSArray * recommendGoods;
@property(nonatomic,weak)id <LSYRecommendViewDelegate>delegate;
@property (nonatomic,strong)NSString * host;
@end
