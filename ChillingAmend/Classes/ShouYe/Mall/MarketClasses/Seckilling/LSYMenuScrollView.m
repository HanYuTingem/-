//
//  LSYMenuScrollView.m
//  MarketManage
//
//  Created by liangsiyuan on 15/1/15.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "LSYMenuScrollView.h"
#import "NSDate+LSY.h"
@implementation LSYMenuScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setFrame:frame];
        self.showsHorizontalScrollIndicator=NO;
        self.itemsArray=[NSMutableArray array];
    }
    return self;
}

//初始化Menu
-(void)setArray:(NSArray *)array
{
    _array=array;
    int i=0;
//    NSLog(@"%@",self.serverTime);
    for (NSDictionary * dic in array) {
        NSString * titleStr = [dic objectForKey:@"name"];
        NSString * timeStr =[self getTimeFormate:[self.serverTime intValue]-[[dic objectForKey:@"start_time"]intValue] andStartTime:[dic objectForKey:@"start_time"]];
        //创建Menu内容
        UIView * view=[[UIView alloc]initWithFrame:CGRectMake(i*BUTTONITEMWIDTH*SP_WIDTH,0, BUTTONITEMWIDTH, self.frame.size.height)];
        UILabel * labelTitle=[[UILabel alloc]initWithFrame:CGRectMake(0, 5, BUTTONITEMWIDTH*SP_WIDTH, self.frame.size.height/2)];
        labelTitle.textAlignment=NSTextAlignmentCenter;
        labelTitle.font=[UIFont systemFontOfSize:14];
        labelTitle.text=titleStr;

        UILabel * labelTime=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, BUTTONITEMWIDTH*SP_WIDTH, 20)];
        labelTime.text=timeStr;
        labelTime.font=[UIFont systemFontOfSize:11];
        labelTime.textAlignment=NSTextAlignmentCenter;
        
        //UI
        UIImageView * ivTop=[[UIImageView alloc]initWithFrame:CGRectMake(BUTTONITEMWIDTH*SP_WIDTH, 0, 0.5, self.bounds.size.height)];
//        ivTop.image=[UIImage imageNamed:@"zxy_line2.png"];
        ivTop.backgroundColor  = [UIColor colorWithRed:0.89f green:0.89f blue:0.89f alpha:1.00f];
        [view addSubview:ivTop];
    
        
        [view addSubview:labelTime];
        [view addSubview:labelTitle];
        view.userInteractionEnabled=YES;
        self.userInteractionEnabled=YES;
        
        //添加手势事件
        UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnTap:)];
        [view addGestureRecognizer:tap];
        [view setTag:i];
        [self addSubview:view];
        [self.itemsArray addObject:view];
        i++;
        
    }
    
//    UIImageView * ivTop=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, i*BUTTONITEMWIDTH, 1)];
//    ivTop.image=[UIImage imageNamed:@"zxy_line.png"];
//    [self addSubview:ivTop];

    
   
    
    [self changeColorsByTag:0];
    self.contentSize=CGSizeMake(BUTTONITEMWIDTH*i,40);

}
//根据Tag修改颜色并滚动
-(void)changeColorsByTag:(int)tag
{
    if (self.currentView) {
        for (UILabel * subView in self.currentView.subviews) {
            if ([subView isKindOfClass:[UILabel class]]) {
                 subView.textColor=[UIColor colorWithRed:61.0/255 green:66.0/255 blue:69.0/255 alpha:1];
            }
        }
    }
    
    for (UIView * view  in self.itemsArray) {
        if (view.tag==tag) {
            
            for (UILabel * subView in view.subviews) {
                if ([subView isKindOfClass:[UILabel class]]) {
                subView.textColor=[UIColor colorWithRed:184.0/255 green:6.0/255 blue:6.0/255 alpha:1];
                }
            }
            self.currentView=view;
            [self scrollRectToVisible:CGRectMake(tag*BUTTONITEMWIDTH, 0, self.frame.size.width, self.frame.size.height) animated:YES];
        }
    }
}
//按钮被点击
-(void)btnTap:(UITapGestureRecognizer*)tap{
    if (self.delegate&& [self.delegate respondsToSelector:@selector(didSelectAtIndex:)]) {
        [self.delegate didSelectAtIndex:tap.view.tag];
    }
    [self changeColorsByTag:tap.view.tag];
}

//判断时间格式
-(NSString*)getTimeFormate:(int)time andStartTime:(NSString*)startTime
{

    double myvar = fabs(time);
    NSString * ret;
    if (myvar<86400) {
        ret=[NSDate dateWithStringHMS1000:[NSString stringWithFormat:@"%@",startTime] andFormat:@"HH:mm"];
    }else{
        ret=[NSDate dateWithStringHMS1000:[NSString stringWithFormat:@"%@",startTime] andFormat:@"YYYY-MM-dd"];
    }
    return ret;
}

@end
