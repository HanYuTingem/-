//
//  LSYRealGoodsTableViewCell.m
//  MarketManage
//
//  Created by liangsiyuan on 15/1/19.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "LSYRealGoodsTableViewCell.h"

@interface LSYRealGoodsTableViewCell()

@end
@implementation LSYRealGoodsTableViewCell

- (void)awakeFromNib {
    self.commitModel = [ZXYCommitOrderRequestModel shareInstance];
    self.noteTextView.layer.cornerRadius = 4;
    if ([self.commitModel.note isEqual:@""]) {
        self.noteTextView.text = @"留言:限50字以内";
    }else{
        self.noteTextView.text = self.commitModel.note;
    }
    
    self.noteTextView.textColor = [UIColor lightGrayColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(registerTextField) name:@"resignFirstResponder" object:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

//发票信息
- (IBAction)faPiaoInfo:(id)sender
{
    if (self.delegate&& [self.delegate respondsToSelector:@selector(getFaPiaoInfo)]) {
        [self.delegate getFaPiaoInfo];
    }
}

-(void)registerTextField
{
    [self.noteTextView resignFirstResponder];
}

@end
