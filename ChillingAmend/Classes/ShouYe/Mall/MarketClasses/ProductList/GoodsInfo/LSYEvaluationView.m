//
//  LSYEvaluationView.m
//  MarketManage
//
//  Created by liangsiyuan on 15/1/14.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "LSYEvaluationView.h"
#import "MarketAPI.h"

@interface LSYEvaluationView()
/** 评价View */
@property (weak, nonatomic) IBOutlet UIView *evaluateView;
/** 评价View的宽 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *evaluateViewWidth;
/** 咨询View */
@property (weak, nonatomic) IBOutlet UIView *ziXunView;
/** 咨询View的宽 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ziXunViewWidth;
/** 没有咨询View的宽 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *noZiXunViewWidth;

@end
@implementation LSYEvaluationView
//评论按钮
- (IBAction)evaluationBtn:(id)sender
{
    if (!self.evaluation.selected) {
        self.evaluation.selected=YES;
        self.ziXun.selected=NO;
         [self.scrollView scrollRectToVisible:CGRectMake(0,0,SCREENWIDTH,self.scrollView.bounds.size.height) animated:YES];
        if (self.evaCount>0) {
            [self.loadMore setTitle:[NSString stringWithFormat:@"查看更多评论(%d)",self.evaCount] forState:UIControlStateNormal];
        }else{
            [self.loadMore setTitle:@"查看更多评价" forState:UIControlStateNormal];
        }
        [UIView animateWithDuration:0.2 animations:^{
            self.redScorllLine.center=CGPointMake(self.redScorllLine.frame.size.width/2, 41);
        }];
    }

}
//咨询按钮
- (IBAction)zixunBtn:(id)sender
{
    
    if (!self.ziXun.selected) {
        self.ziXun.selected=YES;
        self.evaluation.selected=NO;
        [self.scrollView scrollRectToVisible:CGRectMake(SCREENWIDTH,0,SCREENWIDTH,self.scrollView.bounds.size.height) animated:YES];
        if (self.zixunCount>0) {
            [self.loadMore setTitle:[NSString stringWithFormat:@"查看更多咨询(%d)",self.zixunCount] forState:UIControlStateNormal];
        }else{
            [self.loadMore setTitle:@"查看更多咨询" forState:UIControlStateNormal];
        }
        
        [UIView animateWithDuration:0.2 animations:^{
            self.redScorllLine.center=CGPointMake(self.redScorllLine.frame.size.width*3/2+1, 41);
        }];
    }
}
//查看更多评价
- (IBAction)loadMore:(id)sender
{
    if (self.evaluation.selected) {
        if (self.delegate&&[self.delegate respondsToSelector:@selector(gotoCommentList)]) {
            [self.delegate gotoCommentList];
        }
    }else{
        if (self.delegate&&[self.delegate respondsToSelector:@selector(gotoPurchaseConsult)]) {
            [self.delegate gotoPurchaseConsult];
        }
    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"LSYEvaluationView" owner:self options:nil][0];
        [self setFrame:frame];
        self.scrollView.contentSize=CGSizeMake(SCREENWIDTH*2,self.scrollView.bounds.size.height);
        self.scrollView.maximumZoomScale=2.0;
        self.scrollView.minimumZoomScale=0.5;
        self.scrollView.delegate=self;
        self.scrollView.pagingEnabled=YES;
        self.scrollView.delaysContentTouches=YES;
        self.evaluationDic=[NSDictionary dictionary];
        self.ziXunDic=[NSDictionary dictionary];
        
        [self.scrollView addSubview:self.evaluateView];
        

//        CGFloat H = 109;
//        self.evaluateView.frame = CGRectMake(0, 0, SCREENWIDTH, H);
//        self.evaluateView.backgroundColor = [ UIColor yellowColor];
//        [self.scrollView addSubview:self.evaluateView];
//        
//        self.ziXunView.frame = CGRectMake(SCREENWIDTH, 0, SCREENWIDTH, H);
//        self.ziXunView.backgroundColor = [UIColor blueColor];
//        [self.scrollView addSubview:self.ziXunView];
//        
//        self.noZixun.frame = CGRectMake(SCREENWIDTH, 0, SCREENWIDTH, H);
//        self.noZixun.backgroundColor = [UIColor blackColor];
//        [self.scrollView addSubview:self.noZixun];
        self.evaluateViewWidth.constant = SCREENWIDTH;
        self.ziXunViewWidth.constant = SCREENWIDTH;
        self.noZiXunViewWidth.constant = SCREENWIDTH;
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];


}

- (void)drawRect:(CGRect)rect{

    [super drawRect:rect];
    
}

-(void)setEvaluationDic:(NSDictionary *)evaluationDic
{
    _evaluationDic=evaluationDic;
    NSArray * array=_evaluationDic[@"json"];

    if (self.evaCount>0) {
         NSDictionary * dic=[array objectAtIndex:0];
       self.noEvaluation.hidden=YES;
       self.evaluationContext.text=[dic objectForKey:@"message"];
        self.evaluationName.text=[dic objectForKey:@"nike_name"];
        self.evaluationTime.text=[MarketAPI changeTimeFormat:[dic objectForKey:@"create_time"] andFormat1:@"YYYY-MM-dd HH:mm:ss" andFormat2:@"YYYY-MM-dd"];
        [self.loadMore setTitle:[NSString stringWithFormat:@"查看更多评论(%d)",self.evaCount] forState:UIControlStateNormal];
//        self.loadMore.titleLabel.text=[NSString stringWithFormat:@"查看更多评论(%d)",array.count];
    }else{
         self.noEvaluation.hidden=NO;
         [self.loadMore setTitle:@"查看更多评论" forState:UIControlStateNormal];
//        self.loadMore.titleLabel.text=@"查看更多评论";
    }
}

-(void)setZiXunDic:(NSDictionary *)ziXunDic
{
    _ziXunDic=ziXunDic;
    NSArray * array=_ziXunDic[@"json"];

    if (self.zixunCount>0) {
        NSDictionary * dic=[array objectAtIndex:0];
        self.ziXunTitle.text=[dic objectForKey:@"nike_name"];
        self.ziXunTime.text=[MarketAPI changeTimeFormat:[dic objectForKey:@"create_time"] andFormat1:@"YYYY-MM-dd HH:mm:ss" andFormat2:@"YYYY-MM-dd"];
        self.ziXunAsk.text=[dic objectForKey:@"message"];
        self.ziXunAnswer.text=[dic objectForKey:@"reply"];
        self.noZixun.hidden=YES;
        self.ziXunView.hidden = NO;
//        self.loadMore.titleLabel.text=[NSString stringWithFormat:@"查看更多咨询(%d)",array.count];
//        [self.loadMore setTitle:[NSString stringWithFormat:@"查看更多咨询(%d)",self.zixunCount] forState:UIControlStateNormal];
    }else{
        self.noZixun.hidden = NO;
        self.ziXunView.hidden = YES;
//        [self.loadMore setTitle:@"查看更多咨询" forState:UIControlStateNormal];
//        self.loadMore.titleLabel.text=@"查看更多咨询";
    }
    
}

@end
