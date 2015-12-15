//
//  DHWondefulTJCell.m
//  MarketManage
//
//  Created by 许文波 on 15/7/16.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "DHWondefulTJCell.h"

@implementation DHWondefulTJCell





-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titleName = [[UILabel alloc] initWithFrame:CGRectMake(8, 10, 80, 18)];
        self.titleName.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.titleName];
        
     
        self.submitLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.titleName.frame.origin.x, CGRectGetMaxY(self.titleName.frame), 80, 18)];
        self.submitLabel.textColor =[UIColor colorWithRed:0.69f green:0.69f blue:0.69f alpha:1.00f];
        self.submitLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.submitLabel];
        
        
        self.shopImagView = [[UIImageView alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(self.submitLabel.frame)+2, 96, 74)];
        [self.contentView addSubview:self.shopImagView];
        
        UIView *rightLine = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width-0.5, 0, 0.5, self.frame.size.height)];
        rightLine.backgroundColor = [UIColor colorWithRed:0.89f green:0.89f blue:0.89f alpha:1.00f];
        [self.contentView addSubview:rightLine];
        
        UIView *underLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.contentView.frame.size.height - 0.5, self.frame.size.width, 0.5)];
        underLine.backgroundColor = [UIColor colorWithRed:0.89f green:0.89f blue:0.89f alpha:1.00f];
        [self.contentView addSubview:underLine];
        
        
        
        
    }
    return self;
    
}

-(void)refreshSixOneUI:(ModularListModel *)modualListModel withUrl:(NSString *)url{
    
//    NSUserDefaults *host = [NSUserDefaults standardUserDefaults];
//    NSString *str = [host objectForKey:@"host"];
    NSString *str = url;
//
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString *url = [user objectForKey:@"host"];
    
    NSLog(@"%@",modualListModel.img);
    NSString *url2 = [NSString stringWithFormat:@"%@%@",str,modualListModel.img];
    
    self.titleName.text = modualListModel.title;
    self.submitLabel.text = modualListModel.sub_title;
    [self.shopImagView setImageWithURL:[NSURL URLWithString:url2] placeholderImage:[UIImage imageNamed:@"list_placeholder"]];
    

}
@end
