//
//  TakeOutClassCell.m
//  PRJ_NiceFoodModule
//
//  Created by 刘雅楠 on 15/7/20.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "TakeOutClassCell.h"

@implementation TakeOutClassCell

- (TakeOutClassCell *)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = RGBACOLOR(235, 235, 235, 1);
        
        _lable = [[UILabel alloc] initWithFrame:CGRectMake(12, 15, SCREEN_WIDTH*ListScale - 24, 15)];
        [self.contentView addSubview:_lable];
        
        _number = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * ListScale - 30, 5, 15, 15)];

        [_number setBackgroundImage:[UIImage imageNamed:@"wm_icon_bg"] forState:UIControlStateNormal];
        [self.contentView addSubview:_number];
        
    }
    return self;
}

+ (TakeOutClassCell *)cellWithTableView:(UITableView *)tabelView{
    
    static NSString * ident = @"takeOutClassCell";
    
    TakeOutClassCell *cell = [tabelView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        
        cell = [[TakeOutClassCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
        
    }
    return cell;
}

- (void)setModel:(takeOutList *)model{
    _model = model;
    
    _lable.text = model.industryClassifyName;
    

    
}

- (void)setIndex:(NSString *)index{
    _index = index;
    
    if ([_index intValue] > 99) {
        [_number setTitle:@"n+" forState:UIControlStateNormal];
    } else {
        [_number setTitle:_index forState:UIControlStateNormal];
    }
    
    [_number setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_number.titleLabel setFont:[UIFont systemFontOfSize:12]];
    
    if ([_index intValue] > 0) {
        _number.hidden = NO;
    } else {
        _number.hidden = YES;
    }
}



- (void)dealloc{
    [self removeObserver:self forKeyPath:@"index"];
}

@end
