//
//  CJCategoriesAllTableViewCell.m
//  MarketManage
//
//  Created by  on 15-7-20.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "CJCategoriesAllTableViewCell.h"


#define TableTextColor [UIColor colorWithRed:81/255.0 green:81/255.0 blue:81/255.0 alpha:1]
#define TableTextColorH [UIColor colorWithRed:165/255.0 green:0/255.0 blue:0/255.0 alpha:1]
#define TableTextColorS [UIColor colorWithRed:167/255.0 green:0/255.0 blue:9/255.0 alpha:1]
#define CellBackgroundColor [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1]
#define CellBackgroundColorS [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1]
//边线的颜色
#define CellBorderColor [UIColor colorWithRed:226 / 255.0 green:226 / 255.0 blue:226 / 255.0 alpha:1]
#define CellHeight (49 * SP_HEIGHT)
#define TableViewWidth (80 * SP_WIDTH)

@implementation CJCategoriesAllTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
    
//    self.titleLable.textColor = TableTextColorS;
    
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLable2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, TableViewWidth, CellHeight)];
        self.titleLable2.backgroundColor = [UIColor clearColor];
        self.titleLable2.highlightedTextColor = TableTextColorH;
        self.titleLable2.textAlignment = NSTextAlignmentCenter;
        self.titleLable2.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.titleLable2];

        //添加边线
       
        self.iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, CellHeight - 0.4  , TableViewWidth, 0.5)];
//        self.iv.image = [UIImage imageNamed:@"home_list_line"];
        self.iv.backgroundColor = CellBorderColor;
        [self addSubview:self.iv];

        UIView *view = [[UIView alloc] initWithFrame: CGRectMake(TableViewWidth - 0.5, 0, 0.5, CellHeight)];
        view.backgroundColor = CellBorderColor;
        [self.contentView addSubview:view];
        
        self.selectedBackgroundView = [[UIView alloc] init];
        self.selectedBackgroundView.backgroundColor = CellBackgroundColorS;
        UIView *viewUp = [[UIView alloc] initWithFrame:CGRectMake(0, 0, TableViewWidth, 0.5)];
        viewUp.backgroundColor = CellBorderColor;
        [self.selectedBackgroundView addSubview:viewUp];
        UIView *viewDown = [[UIView alloc] initWithFrame:CGRectMake(0, CellHeight  , TableViewWidth, 0.5)];
        viewDown.backgroundColor = CellBorderColor;
        [self.selectedBackgroundView addSubview:viewDown];
        self.backgroundColor = CellBackgroundColor;
       
        
    }return self;
}
-(void)refreshUI:(CJAllCategoriesModel *)model{
    
    //判断文字 最多显示四个汉字 8个字母 数字
    NSMutableString *strName = [NSMutableString stringWithFormat:@"%@",model.name];
    if (model.name.length > 4) {
        strName.string = @"";
        int num = 0;
        for (int i = 0; i < model.name.length; i++) {
            NSRange range = {i,1};
            NSString *strSub = [model.name substringWithRange:range];
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
    self.titleLable2.text = strName;

}

@end
