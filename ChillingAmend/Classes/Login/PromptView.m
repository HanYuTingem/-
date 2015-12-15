//
//  PromptView.m
//  LANSING
//
//  Created by nsstring on 15/5/29.
//  Copyright (c) 2015年 DengLu. All rights reserved.
//

#import "PromptView.h"
static PromptView *instance;

@implementation PromptView
@synthesize backgroundView;
@synthesize skipView;
@synthesize toUnderstandView;

@synthesize background1View;
@synthesize skip1View;
@synthesize toUnderstand1View;

@synthesize titleLabel;
@synthesize skip1Label;
@synthesize toUnderstand1Label;

@synthesize registeredView;
@synthesize registeredLabel;
@synthesize skip2View;
@synthesize toUnderstand2View;

+ (id) Instance  //第二步：实例构造检查静态实例是否为nil
{
    @synchronized (self)
    {
        if (instance == nil)
        {
            //获得nib视图数组
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"PromptView" owner:self options:nil];
            //得到第一个UIView
            instance = [nib objectAtIndex:0];
        }
    }
    return instance;
}

+(id) allocWithZone:(NSZone *)zone{//重写allocWithZone用于确定：不能使用其他方法创建类的实例<br>
    @synchronized(self){
        if (instance == nil) {
            instance = [super allocWithZone:zone];
            return instance;
        }
    }
    return nil;//如果写成这样 return [self getInstance] 当试图创建新的实例时候，会调用到单例的方法，达到共享类的实例
}

-(void)draw{
    /*阴影和倒角*/
    skipView.layer.shadowRadius = 1;
    skipView.layer.shadowOpacity = 0.4f;
    skipView.layer.shadowOffset = CGSizeMake(0, 0);
    skipView.tag = 1;
    skipView.userInteractionEnabled = YES;
    [skipView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choose:)]];
    
    toUnderstandView.layer.shadowRadius = 1;
    toUnderstandView.layer.shadowOpacity = 0.4f;
    toUnderstandView.layer.shadowOffset = CGSizeMake(0, 0);
    toUnderstandView.tag = 2;
    toUnderstandView.userInteractionEnabled = YES;
    [toUnderstandView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choose:)]];
    
    backgroundView.userInteractionEnabled = YES;
    backgroundView.tag = 3;
    [backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choose:)]];
    backgroundView.clipsToBounds = YES;
    backgroundView.layer.cornerRadius = 5;
    backgroundView.hidden = _InTheFormOfInt == 1?NO:YES;
    
    
    /*阴影和倒角*/
    skip1View.layer.shadowRadius = 1;
    skip1View.layer.shadowOpacity = 0.4f;
    skip1View.layer.shadowOffset = CGSizeMake(0, 0);
    skip1View.tag = 11;
    skip1View.userInteractionEnabled = YES;
    [skip1View addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choose:)]];
    
    toUnderstand1View.layer.shadowRadius = 1;
    toUnderstand1View.layer.shadowOpacity = 0.4f;
    toUnderstand1View.layer.shadowOffset = CGSizeMake(0, 0);
    toUnderstand1View.tag = 12;
    toUnderstand1View.userInteractionEnabled = YES;
    [toUnderstand1View addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choose:)]];
    
    background1View.userInteractionEnabled = YES;
    background1View.tag = 13;
    [background1View addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choose:)]];
    background1View.clipsToBounds = YES;
    background1View.layer.cornerRadius = 5;
    background1View.hidden = _InTheFormOfInt == 1?YES:NO;
    
    /*阴影和倒角*/
    skip2View.layer.shadowRadius = 1;
    skip2View.layer.shadowOpacity = 0.4f;
    skip2View.layer.shadowOffset = CGSizeMake(0, 0);
    skip2View.tag = 21;
    skip2View.userInteractionEnabled = YES;
    [skip2View addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choose:)]];
    
    toUnderstand2View.layer.shadowRadius = 1;
    toUnderstand2View.layer.shadowOpacity = 0.4f;
    toUnderstand2View.layer.shadowOffset = CGSizeMake(0, 0);
    toUnderstand2View.tag = 22;
    toUnderstand2View.userInteractionEnabled = YES;
    [toUnderstand2View addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choose:)]];
    
    registeredView.userInteractionEnabled = YES;
    registeredView.tag = 23;
    [registeredView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choose:)]];
    registeredView.clipsToBounds = YES;
    registeredView.layer.cornerRadius = 5;
    registeredView.hidden = _InTheFormOfInt == 1?YES:NO;
    
    /*关闭*/
//    self.userInteractionEnabled = YES;
//    static UITapGestureRecognizer* tap1;
//    if (!tap1) {
//        tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shutDown)];
//    }
//    [self addGestureRecognizer:tap1];
}

-(void)shutDown{
    self.hidden = YES;
//    [self.delegate shutDown];
}

-(void)choose:(id)sender{
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender;
    
    if (tap.view.tag == 1||tap.view.tag == 11||tap.view.tag == 21) {
        skipView.backgroundColor = RGBACOLOR(241, 241, 241, 1);
        toUnderstandView.backgroundColor = RGBACOLOR(249, 249, 249, 1);
        
        skip1View.backgroundColor = RGBACOLOR(241, 241, 241, 1);
        toUnderstand1View.backgroundColor = RGBACOLOR(249, 249, 249, 1);
        
        [self.delegate chooseSkip:_InTheFormOfInt];
        self.hidden = YES;
    }else if (tap.view.tag == 2||tap.view.tag == 12||tap.view.tag == 22){
        toUnderstandView.backgroundColor = RGBACOLOR(241, 241, 241, 1);
        skipView.backgroundColor = RGBACOLOR(249, 249, 249, 1);
        
        toUnderstand1View.backgroundColor = RGBACOLOR(241, 241, 241, 1);
        skip1View.backgroundColor = RGBACOLOR(249, 249, 249, 1);
        
        [self.delegate chooseToUnderstand:_InTheFormOfInt];
        self.hidden = YES;
    }
    
}

-(void)setInTheFormOfInt:(int)InTheFormOfInt{
    _InTheFormOfInt = InTheFormOfInt;
    switch (_InTheFormOfInt) {
        case 1:{
            backgroundView.hidden = NO;
            background1View.hidden = YES;
            registeredView.hidden = YES;
            break;
        }
        case 2:{
            backgroundView.hidden = YES;
            background1View.hidden = NO;
            registeredView.hidden = YES;
            break;
        }
        case 3:{
            backgroundView.hidden = YES;
            background1View.hidden = NO;
            registeredView.hidden = YES;
            break;
        }
        case 4:{
            backgroundView.hidden = YES;
            background1View.hidden = YES;
            registeredView.hidden = NO;
            break;
        }
            
        default:
            break;
    }
    
    if (_InTheFormOfInt == 3) {
        titleLabel.text = @"账号不存在，您可以";
        skip1Label.text = @"取消";
        toUnderstand1Label.text = @"注册";
    }else {
        titleLabel.text = @"允许应用获取手机识别码";
        skip1Label.text = @"允许";
        toUnderstand1Label.text = @"不允许";
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
