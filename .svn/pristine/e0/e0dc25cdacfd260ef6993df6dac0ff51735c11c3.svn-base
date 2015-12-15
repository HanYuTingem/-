//
//  MessageSecondCell.m
//  QQList
//
//  Created by sunsu on 15/7/3.
//  Copyright (c) 2015年 CarolWang. All rights reserved.
//

#import "MessageSecondCell.h"
@interface MessageSecondCell()
@property (nonatomic,strong) UIButton               *editPhoneBtn;
@property (nonatomic,strong) UILabel                *phoneLabel;
@end
@implementation MessageSecondCell

static NSString *identifier = @"MESSAGESECONDCELL";
+(instancetype)cellWithTableView:(UITableView *)tableView{
    MessageSecondCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MessageSecondCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    CGFloat y = 20;
    CGRect aLabelFrame = CGRectMake(PADDING, y, 100, 20);
    UILabel * aLabel = [[UILabel alloc]initWithFrame:aLabelFrame];
    aLabel.text = @"订座手机号";
    aLabel.font = [UIFont systemFontOfSize:15.0f];
    [self.contentView addSubview:aLabel];
    
    CGFloat phoneW = 150;
    CGRect editPhoneBtnFrame = CGRectMake(SCREEN_WIDTH-2*PADDING-phoneW, y, phoneW, 20);
    self.editPhoneBtn = [[UIButton alloc]initWithFrame:editPhoneBtnFrame];
    self.editPhoneBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    self.editPhoneBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.editPhoneBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.editPhoneBtn addTarget:self action:@selector(clickPhoneButton) forControlEvents:UIControlEventTouchUpInside];
    self.editPhoneBtn.userInteractionEnabled = YES;
    [self.contentView addSubview:self.editPhoneBtn];
    
    CGRect imgViewFrame = CGRectMake(self.editPhoneBtn.frame.origin.x, y-(30-y)/2, 30, 30);
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:imgViewFrame];
    imgView.image = [UIImage imageNamed:@"myorder_function_btn_changephonenumber_selected.png"];
    [self.contentView addSubview:imgView];
    
    UILabel * fLabel = [[UILabel alloc]initWithFrame:CGRectMake(PADDING, CGRectGetMaxY(aLabelFrame)+5, SCREEN_WIDTH-2*PADDING, 20)];
    fLabel.text = @"* 信誉指数及订单与订座手机号关联";
    fLabel.font = [UIFont systemFontOfSize:12.0f];
    [self.contentView addSubview:fLabel];
    
    UILabel * sLabel = [[UILabel alloc]initWithFrame:CGRectMake(PADDING, CGRectGetMaxY(fLabel.frame), SCREEN_WIDTH-2*PADDING, 20)];
    sLabel.text = @"* 若手机号显示有误，请点击修改订座手机号";
    sLabel.font = [UIFont systemFontOfSize:12.0f];
    [self.contentView addSubview:sLabel];

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(sLabel.frame)+PADDING, SCREEN_WIDTH, 1)];
    imageView.backgroundColor = RGBACOLOR(237, 237, 237, 1);
    [self.contentView  addSubview:imageView];
    
}
-(void)clickPhoneButton{
    if ([self.delegate respondsToSelector:@selector(editPhoneNumClick)]) {
        [self.delegate editPhoneNumClick];
    }else {
        ZNLog(@"CustomActionSheet的代理没有实现代理方法");
    }
}


-(void)reshCellWithPhone:(NSString*)phoneNumber{
    [self.editPhoneBtn setTitle:phoneNumber forState:UIControlStateNormal];
}



@end
