//
//  AnimationView.m
//  animationView
//
//  Created by Rice on 14/12/3.
//  Copyright (c) 2014年 Rice. All rights reserved.
//

#import "AnimationView.h"

@implementation AnimationView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.listTableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        self.listTableView.delegate = self;
        self.listTableView.dataSource = self;
        self.listTableView.backgroundColor = [UIColor clearColor];
        self.listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:self.listTableView];
        listModel = [ZXYClassfierListModel shareInstance];
        
    }
    return self;
}

#pragma mark - UITableviewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return listModel.leftDataAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *identifer = @"listCell";
    ListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ListCell" owner:self options:nil][0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (listModel.leftDataAry.count > listModel.rightDataAry.count) {
        if (indexPath.row == listModel.leftDataAry.count - 1) {
            cell.rightView.hidden = YES;
        }else{
            cell.rightView.hidden = NO;
        }
    }else{
        cell.rightView.hidden = NO;
    }
    
    if (indexPath.row < listModel.leftDataAry.count) {
        NSMutableDictionary *dict = listModel.leftDataAry[indexPath.row];
        cell.imageHostUrl = self.imageHostUrl;
        [cell setCellLeftValue:dict];
        
        cell.leftSelectBtn.tag = indexPath.row + 1000;
        [cell.leftSelectBtn setExclusiveTouch:YES];
        [cell.leftSelectBtn addTarget:self action:@selector(cellBtnSlected:) forControlEvents:UIControlEventTouchUpInside];
    }
    if (indexPath.row < listModel.rightDataAry.count) {
        NSMutableDictionary *dict = listModel.rightDataAry[indexPath.row];
        cell.imageHostUrl = self.imageHostUrl;
        [cell setCellRightValue:dict];
        
        cell.rightSelectBtn.tag = indexPath.row + 2000;
        [cell.rightSelectBtn setExclusiveTouch:YES];
        [cell.rightSelectBtn addTarget:self action:@selector(cellBtnSlected:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 230 * SP_WIDTH;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
{
    ListCell *listCell = (ListCell *)cell;
    // 左侧进入
    if (listCell.leftView) {
        // 定义旋转角度
        CGFloat rotationAngleDegrees = 0;
        // 旋转的弧度
        CGFloat rotationAngleRadians = rotationAngleDegrees * (M_PI/180);
        // 偏移位置
        CGPoint offsetPositioning = CGPointMake(-150, -20);
        
        // 设置动画
        CATransform3D transform = CATransform3DIdentity;
        transform = CATransform3DRotate(transform, rotationAngleRadians, 0.0, 0.0, 1.0);
        transform = CATransform3DTranslate(transform, offsetPositioning.x, offsetPositioning.y, 0.0);
        
        listCell.leftView.layer.transform = transform;
        listCell.leftView.layer.opacity = 0.8;
        
        [UIView animateWithDuration:.4 animations:^{
            listCell.leftView.layer.transform = CATransform3DIdentity;
            listCell.leftView.layer.opacity = 1;
            
        } completion:^(BOOL finished) {
            // 定义旋转角度
            CGFloat rotationAngleDegrees = 0;
            // 旋转的弧度
            CGFloat rotationAngleRadians = rotationAngleDegrees * (M_PI/180);
            // 偏移位置
            CGPoint offsetPositioning = CGPointMake(10, 0);
            
            // 设置动画
            CATransform3D transform = CATransform3DIdentity;
            transform = CATransform3DRotate(transform, rotationAngleRadians, 0.0, 0.0, 1.0);
            transform = CATransform3DTranslate(transform, offsetPositioning.x, offsetPositioning.y, 0.0);
            
            listCell.leftView.layer.transform = transform;
            listCell.leftView.layer.opacity = 0.8;
            
            [UIView animateWithDuration:0.2 animations:^{
                listCell.leftView.layer.transform = CATransform3DIdentity;
                listCell.leftView.layer.opacity = 1;
                
            } completion:^(BOOL finished) {
                
            }];
            
        }];
    }
    if (listCell.rightView){
        // 定义旋转角度
        CGFloat rotationAngleDegrees = 0;
        // 旋转的弧度
        CGFloat rotationAngleRadians = rotationAngleDegrees * (M_PI/180);
        // 偏移位置
        CGPoint offsetPositioning = CGPointMake(200, 20);
        
        // 设置动画
        CATransform3D transform = CATransform3DIdentity;
        // 绕z轴旋转角度
        transform = CATransform3DRotate(transform, rotationAngleRadians, 0.0, 0.0, 1.0);
        // 相对于x,y偏移位置
        transform = CATransform3DTranslate(transform, offsetPositioning.x, offsetPositioning.y, 0.0);
        
        listCell.rightView.layer.transform = transform;
        listCell.rightView.layer.opacity = 0.8;
        
        [UIView animateWithDuration:.4 animations:^{
            listCell.rightView.layer.transform = CATransform3DIdentity;
            listCell.rightView.layer.opacity = 1;
            
        } completion:^(BOOL finished) {
            // 定义旋转角度
            CGFloat rotationAngleDegrees = 0;
            // 旋转的弧度
            CGFloat rotationAngleRadians = rotationAngleDegrees * (M_PI/180);
            // 偏移位置
            CGPoint offsetPositioning = CGPointMake(-10, 0);
            
            // 设置动画
            CATransform3D transform = CATransform3DIdentity;
            // 绕z轴旋转角度
            transform = CATransform3DRotate(transform, rotationAngleRadians, 0.0, 0.0, 1.0);
            // 相对于x,y偏移位置
            transform = CATransform3DTranslate(transform, offsetPositioning.x, offsetPositioning.y, 0.0);
            
            listCell.rightView.layer.transform = transform;
            listCell.rightView.layer.opacity = 0.8;
            
            [UIView animateWithDuration:0.2 animations:^{
                listCell.rightView.layer.transform = CATransform3DIdentity;
                listCell.rightView.layer.opacity = 1;
                
            } completion:^(BOOL finished) {
                
            }];
            
        }];
        
    }
    
}

-(void)cellBtnSlected:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if (btn.tag - 1000 < 1000) {//左侧btn
        [self.animationDelegate animationSelectedBtnWithLeft:YES WithIndexRow:btn.tag-1000];
    }else{//右侧
        [self.animationDelegate animationSelectedBtnWithLeft:NO WithIndexRow:btn.tag-2000];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"scrollHideCatagoryView" object:self];
}

// xuwenbo add
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    [self.animationDelegate scrollViewEndScroll:NO];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self.animationDelegate scrollViewEndScroll:YES];
}

@end
