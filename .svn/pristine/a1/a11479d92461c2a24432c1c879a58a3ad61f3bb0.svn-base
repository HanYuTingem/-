//
//  ScreenListView.m
//  PRJ_NiceFoodModule
//
//  Created by 刘雅楠 on 15/6/23.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "ScreenListView.h"
#import "ScreenButtonView.h"





@interface ScreenListView() <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) myblock returnBlock;


@end


@implementation ScreenListView

- (instancetype)initWithFirstDatas:(NSArray *)firstArray secondDatas:(NSArray *)secondArray firstIndex:(NSInteger)firstIndex andBlock:(myblock)returnBlock{

    if ([super init]) {
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
        
        _firstIndex = firstIndex;
        
        _returnBlock = returnBlock; //回调函数
        _firstDatas  = firstArray;  //一级目录数据
        _secondDatas = secondArray; //二级目录数据
        
        
//          创建一级目录
        _firstTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0-(self.frame.size.height - TopMenuH) * TableHightScale, SCREEN_WIDTH, (self.frame.size.height - TopMenuH) * TableHightScale) style:UITableViewStylePlain];
        _firstTableView.tag = 10001;
        _firstTableView.backgroundColor = [UIColor whiteColor];

        
//            设置代理
        _firstTableView.dataSource = self;
        _firstTableView.delegate = self;
        

        [self addSubview:_firstTableView];
        [self sendSubviewToBack:_firstTableView];

        //设置选中行
        [_firstTableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:_firstIndex inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
//
        //实现点击行所调用的方法
//        [self tableView:_firstTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForItem:_firstIndex inSection:0]];
        
        
        if (_secondDatas != nil) {//如果存在二级目录
            
//              先修改一级目录的范围
            _firstTableView.frame = CGRectMake(0, 0-(self.frame.size.height-TopMenuH)* TableHightScale, SCREEN_WIDTH * TableScale, (self.frame.size.height-TopMenuH)* TableHightScale);
            
//            创建二级目录
            _secondTableView =[[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * TableScale, 0 -(self.frame.size.height-TopMenuH)* TableHightScale, SCREEN_WIDTH * (1 - TableScale), (self.frame.size.height-TopMenuH)* TableHightScale) style:UITableViewStylePlain];
            _secondTableView.tag = 10002;
            _secondTableView.backgroundColor = RGBColor(217, 217, 217);
            
            [self addSubview:_secondTableView];
            [self sendSubviewToBack:_secondTableView];

//            隐藏空白的cell
            _secondTableView.tableFooterView = [[UIView alloc] init];
            

//            设置代理
            _secondTableView.dataSource = self;
            _secondTableView.delegate = self;
            
            [UIView animateWithDuration:0.3 animations:^{
                _firstTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH * TableScale, (self.frame.size.height-TopMenuH)* TableHightScale);
            }];
            [UIView animateWithDuration:0.3 animations:^{
                _secondTableView.frame = CGRectMake(SCREEN_WIDTH * TableScale, 0, SCREEN_WIDTH * (1 - TableScale), (self.frame.size.height-TopMenuH)* TableHightScale);
            }];
        } else {
        
            [UIView animateWithDuration:0.3 animations:^{
                _firstTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, (self.frame.size.height - TopMenuH)* TableHightScale);
            }];
        }
    }
    
//    cell间分隔线对齐到顶端
    if ([_firstTableView respondsToSelector:@selector(setSeparatorInset:)]){
        [_firstTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([_firstTableView respondsToSelector:@selector(setLayoutMargins:)]){
        [_firstTableView setLayoutMargins:UIEdgeInsetsZero];
    }

    if ([_secondTableView respondsToSelector:@selector(setSeparatorInset:)]){
        [_secondTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([_secondTableView respondsToSelector:@selector(setLayoutMargins:)]){
        [_secondTableView setLayoutMargins:UIEdgeInsetsZero];
    }
    

    
    return self;
}


//- (void)clickScreenListView{
//
//    [self removeFromSuperview];
//    
//}


#pragma mark -- delegate实现
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    


    static NSString *ident = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
        
    }
    
    if (tableView.tag == 10001) {
        
        cell.textLabel.text = _firstDatas[indexPath.row];
        
    } else if (tableView.tag == 10002) {
        
        cell.backgroundColor = RGBColor(217, 217, 217);
        cell.textLabel.text = _tempArray[indexPath.row];
        
    }
    
    
    return cell;

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (tableView.tag == 10001 && _secondDatas == nil){//没有二级目录时的触发事件
        _firstIndex = indexPath.row;
//        _secondString = _firstDatas[indexPath.row];
        _returnBlock(_firstIndex, 0);
    } else if (tableView.tag == 10001) {           //一级目录的触发事件

        _firstIndex = indexPath.row;
        _tempArray = _secondDatas[indexPath.row];
        
        if (_tempArray.count == 0) {
            _returnBlock(_firstIndex, 0);
        } else {
            [_secondTableView reloadData];
        }
        
    } else if (tableView.tag == 10002) {    //二级目录的触发事件
//        _secondString = _secondDatas[_firstIndex][indexPath.row];
        _returnBlock(_firstIndex, indexPath.row);

    }
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 10001) {
        return _firstDatas.count;
    } else if (tableView.tag == 10002 && _secondDatas.count > 0) {
        _tempArray = [NSArray arrayWithArray:_secondDatas[_firstIndex]];
        return _tempArray.count;
    }
    return 0;
}

- (void)setFrame:(CGRect)frame{

    frame = CGRectMake(0, TopMenuH , SCREEN_WIDTH, SCREEN_HEIGHT - NavigationH - TopMenuH);
    [super setFrame:frame];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]){
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

@end
