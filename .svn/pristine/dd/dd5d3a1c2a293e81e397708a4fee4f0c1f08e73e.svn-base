//
//  HeaderView.m
//  QQList
//
//  Created by CarolWang on 14/11/22.
//  Copyright (c) 2014年 CarolWang. All rights reserved.
//

#import "HeaderView.h"
#import "JKGroupModel.h"
@implementation HeaderView{
    UIButton *_arrowBtn;
    UIImageView *_imageView;
}

+ (instancetype)headerView:(UITableView *)tableView{
    static NSString *identifier = @"header";
    HeaderView *header = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!header) {
        header = [[HeaderView alloc] initWithReuseIdentifier:identifier];
    }
    return header;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super init]) {
        UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sp_0002_icon_hong.png"]];
        _imageView = imageView;
        [self addSubview:_imageView];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"sp_0000_icon_f.png"] forState:UIControlStateNormal];
        [button setTitleColor:RGBCOLOR(48, 48, 48) forState:UIControlStateNormal];

        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        
        button.imageEdgeInsets = UIEdgeInsetsMake(20, SCREEN_WIDTH-50, 20, RECTFIX_WIDTH(10)*2);
        [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        _arrowBtn = button;
        [self addSubview:_arrowBtn];
    }
    return self;
}
#pragma mark - buttonAction

- (void)buttonAction{
    self.groupModel.isOpen = !self.groupModel.isOpen;
    if ([self.delegate respondsToSelector:@selector(clickView)]) {
        [self.delegate clickView];
    }
}

- (void)didMoveToSuperview{
    _arrowBtn.imageView.transform = self.groupModel.isOpen ? CGAffineTransformMakeRotation(M_PI) :CGAffineTransformMakeRotation(0);
}

//布局
- (void)layoutSubviews{
    [super layoutSubviews];
    _arrowBtn.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _imageView.frame = CGRectMake(20, (self.frame.size.height-12)/2, 2, 12);
}

//赋值
- (void)setGroupModel:(JKGroupModel *)groupModel{
    _groupModel = groupModel;
    [_arrowBtn setTitle:_groupModel.channelName forState:UIControlStateNormal];
}


@end
