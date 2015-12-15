//
//  LSYEvaluationView.h
//  MarketManage
//
//  Created by liangsiyuan on 15/1/14.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LSYEvaluationViewDelegate <NSObject>
@optional
-(void)gotoCommentList;
-(void)gotoPurchaseConsult;
@end

@interface LSYEvaluationView : UIView<UIScrollViewDelegate>
/** 查看更多的按钮 */
@property (weak, nonatomic) IBOutlet UIButton *loadMore;
/** 评论按钮 */
@property (weak, nonatomic) IBOutlet UIButton *evaluation;
/** 购买咨询按钮 */
@property (weak, nonatomic) IBOutlet UIButton *ziXun;
/** 文字显示的scrollView */
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
/** 评价的名称 */
@property (weak, nonatomic) IBOutlet UILabel *evaluationName;
/** 评价的时间 */
@property (weak, nonatomic) IBOutlet UILabel *evaluationTime;
/** 评价的内容 */
@property (weak, nonatomic) IBOutlet UILabel *evaluationContext;
/** 没有评论的View */
@property (weak, nonatomic) IBOutlet UIView *noEvaluation;
/** 咨询的名字 */
@property (weak, nonatomic) IBOutlet UILabel *ziXunTitle;
/** 咨询的时间 */
@property (weak, nonatomic) IBOutlet UILabel *ziXunTime;
/** 咨询的问题 */
@property (weak, nonatomic) IBOutlet UILabel *ziXunAsk;
/** 咨询的回答 */
@property (weak, nonatomic) IBOutlet UILabel *ziXunAnswer;
/** 红线 */
@property (weak, nonatomic) IBOutlet UIView *redScorllLine;
/** 没有咨询的View */
@property (weak, nonatomic) IBOutlet UIView *noZixun;
@property (nonatomic,strong) NSDictionary * evaluationDic;
@property (nonatomic,strong) NSDictionary * ziXunDic;
@property (weak,nonatomic)id <LSYEvaluationViewDelegate>delegate;
@property (nonatomic,assign)int evaCount;
@property (nonatomic,assign)int zixunCount;


@end
