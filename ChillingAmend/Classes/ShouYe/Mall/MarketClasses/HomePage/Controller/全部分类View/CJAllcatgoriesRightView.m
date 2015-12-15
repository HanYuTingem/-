//
//  CJAllcatgoriesRightView.m
//  MarketManage
//
//  Created by  on 15-7-21.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "CJAllcatgoriesRightView.h"

#import "CJAllCatgoriesReusableView.h" //自定义头标题
#import "CJAllCatgoriesCollectionViewCell.h" //自定义cell
#import "CJAllCategoriesModel.h"
#import "CJAllCategoriesThreeModel.h"
#import "UIImageView+WebCache.h"
#import "ZXYClassifierListViewController.h"



#define CELL @"collectionCell"
#define ReusableView @"ReusableView"

@interface CJAllcatgoriesRightView () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

{
    
    /** 接收外部传来的数组 */
    NSMutableArray *_arrayM;
    /** 全局的frame 外界出过来的数据 */
    CGRect _frame;
}
/** 外界传入的UIViewController */
@property (nonatomic, strong) UIViewController *controller;

@end

@implementation CJAllcatgoriesRightView



- (instancetype)initWithFrame:(CGRect)frame controller:(UIViewController *)controller
{
    if (self = [super initWithFrame:frame]) {
        _frame = frame;
        self.controller = controller;
        self.backgroundColor = [UIColor whiteColor];

        _arrayM = [NSMutableArray array];
        
        /**
         * 添加CollectionView
         */
        [self makeCollectionViewWithFrame:frame];
    }
    return self;
}

#pragma  mark 设置UICollectionView
/**
 * 添加CollectionView
 */
-(void)makeCollectionViewWithFrame:(CGRect)frame{
    
    //1、设置collectionView的UICollectionViewFlowLayout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 0;//设置一行cell间的距离
    layout.minimumLineSpacing = 13;//设置不同行之间的距离
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];//设置滚动为竖着滚
    
    //2、实例化collectionView，初始化的时候用布局来初始化他
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:layout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.showsVerticalScrollIndicator = NO;
    [self addSubview:collectionView];
    
    _collectionView = collectionView;
    
    [collectionView registerClass:[CJAllCatgoriesReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ReusableView];
    [collectionView registerNib:[UINib nibWithNibName:@"CJAllCatgoriesCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:CELL];
    
    [self upWithData];
}


/**
 * 刷新CollectionView的数据
 */
- (void)upWithData
{
    [_collectionView reloadData];
}

#pragma collectionView 的代理方法

//组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataArray.count;
    //    return _arrayM.count;
}
//行
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    CJAllCategoriesModel *model = self.dataArray[section];
    return model.json.count;
    //    return [_arrayM[section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CJAllCatgoriesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL forIndexPath:indexPath];
    //二级分类的模型
    CJAllCategoriesModel *towModel = self.dataArray[indexPath.section];
    //三级分类的模型
    CJAllCategoriesThreeModel *thModel = towModel.json[indexPath.row];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",self.hostUrl,thModel.url];
    //[cell.iconImage setImageURLStr:urlStr placeholder:[UIImage imageNamed:@"list_placeholder"]];
    [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"list_placeholder"]];
    
    //判断文字 最多显示四个汉字 8个字母 数字
    NSMutableString *strName = [NSMutableString stringWithFormat:@"%@",thModel.name];
    if (thModel.name.length > 4) {
        strName.string = @"";
        int num = 0;
        for (int i = 0; i < thModel.name.length; i++) {
            NSRange range = {i,1};
            NSString *strSub = [thModel.name substringWithRange:range];
            const char *cString = [strSub UTF8String];
            if (strlen(cString) == 1) {
                num++;
                if (num <= 8) {
                    [strName appendString:strSub];
                } else break;
            } else if(strlen(cString) == 3){
                num += 2;
                if (num <= 8) {
                    [strName appendString:strSub];
                } else break;
            }
        }
    }
    
    cell.titleLable.text = strName;
    
    return cell;
}
#pragma  mark 设置每个段头的内容
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *_headView = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        CJAllCatgoriesReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:ReusableView forIndexPath:indexPath];
        CJAllCategoriesModel *towModel = self.dataArray[indexPath.section];
        
        [headView ReusableViewLableName:towModel.name];
        _headView = headView;
    }
    return _headView;
    
}

#pragma 设置cell的高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(70, 70);
}
/** 设置段头的高度 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(_frame.size.width, 42);
}
#pragma cell的点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //二级分类的模型
    CJAllCategoriesModel *towModel = self.dataArray[indexPath.section];
    //三级分类的模型
    CJAllCategoriesThreeModel *thModel = towModel.json[indexPath.row];
    
    
    
    ZXYClassifierListViewController *classifierVC = [[ZXYClassifierListViewController alloc] initWithNibName:@"ZXYClassifierListViewController" bundle:nil];
    classifierVC.leftRow = indexPath.row;
    classifierVC.cat_id = thModel.ID;
    classifierVC.cat_name = thModel.name;
    [self.controller.navigationController pushViewController:classifierVC animated:YES];
}

@end



