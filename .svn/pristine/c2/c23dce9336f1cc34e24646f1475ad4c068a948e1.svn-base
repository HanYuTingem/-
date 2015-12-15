//
//  LSYRecommendView.m
//  MarketManage
//
//  Created by liangsiyuan on 15/1/13.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "LSYRecommendView.h"
#import "LSYRecommendCollectionViewCell.h"
#import "LSYGoodsInfo.h"

@implementation LSYRecommendView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"LSYRecommendView" owner:self options:nil][0];
        [self setFrame:frame];

        [self.collectionView registerNib:[UINib nibWithNibName:@"LSYRecommendCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
        self.collectionView.delegate=self;
        self.collectionView.dataSource=self;
    }
    return self;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return self.recommendGoods.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    LSYRecommendCollectionViewCell * cell = [collectionView  dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[LSYRecommendCollectionViewCell alloc] init];
    }
    cell.host=self.host;

    cell.dic=[self.recommendGoods objectAtIndex:indexPath.row];
    return cell;
}

-(void)setRecommendGoods:(NSArray *)recommendGoods
{
    _recommendGoods=recommendGoods;
    [self.collectionView reloadData];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic=[self.recommendGoods objectAtIndex:indexPath.row];
    if (self.delegate&&[self.delegate respondsToSelector:@selector(didTapGoods:)]) {
        [self.delegate didTapGoods:[dic objectForKey:@"id"]];
    }
}

@end
