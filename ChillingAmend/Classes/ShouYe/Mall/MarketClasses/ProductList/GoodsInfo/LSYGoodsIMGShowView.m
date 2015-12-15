//
//  LSYGoodsIMGShowView.m
//  MarketManage
//
//  Created by liangsiyuan on 15/1/14.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "LSYGoodsIMGShowView.h"
#import "UIImageView+WebCache.h"

@implementation LSYGoodsIMGShowView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"LSYGoodsIMGShowView" owner:self options:nil][0];
        [self setFrame:frame];
    }
    return self;
}

-(void)setGoods:(LSYGoodsInfo *)goods
{
    _goods=goods;
    int i;
    for (i=0; i<_goods.images.count; i++) {
        NSDictionary * dic= [_goods.images objectAtIndex:i];
        UIImageView * iv =[[UIImageView alloc]initWithFrame:CGRectMake(i*self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height)];
        [iv setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",_goods.host,[dic objectForKey:@"url"]]]placeholderImage:[UIImage imageNamed:@"defaultimg_7.png"]];
        UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImg:)];
        [iv addGestureRecognizer:tap];
        iv.userInteractionEnabled=YES;
        iv.tag=i;
        [self.scorllView addSubview:iv];
    }
    if (_goods.images.count>1) {
        //遮罩图
        UIImageView * imageBg=[[UIImageView alloc]initWithFrame:CGRectMake(self.bounds.size.width*i-86, 0, 86, self.frame.size.width)];
        imageBg.alpha=0.8;
        imageBg.image=[UIImage imageNamed:@"mall_gallery_img.png"];
        [self.scorllView addSubview:imageBg];
        
        //查看更多
        UIImageView * image=[[UIImageView alloc]initWithFrame:CGRectMake(self.bounds.size.width*i-66, 80, 58, 147 )];
        image.image=[UIImage imageNamed:@"lsy_goodsinfo_more.png"];
        [self.scorllView addSubview:image];
        self.pageControl.backgroundColor = [UIColor clearColor];
        self.pageControl.numberOfPages = i;
        self.pageControl.currentPage = 0;
        [self addSubview:self.pageControl];
        [self.pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    }
       
    self.scorllView.contentSize=CGSizeMake(self.bounds.size.width*i,self.bounds.size.height);
    self.scorllView.maximumZoomScale=2.0;
    self.scorllView.minimumZoomScale=0.5;
    self.scorllView.delegate=self;
    self.scorllView.pagingEnabled=YES;
    self.scorllView.delaysContentTouches=YES;
}

- (void)changePage:(id)sender
{

}
//点击图片跳转
-(void)tapImg:(UITapGestureRecognizer*) sender
{
    UITapGestureRecognizer  * tap = (UITapGestureRecognizer*)sender;
    UIImageView  * imageView =(UIImageView*) tap.view;
    
    int  index = (int)imageView.tag;
    if (self.delegate&&[self.delegate respondsToSelector:@selector(didTapImg:andIndex:andHost:)]) {
        [self.delegate didTapImg:self.goods.images andIndex:index andHost:self.goods.host];
    }
}

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    
//    if (scrollView.contentOffset.x>self.scorllView.contentSize.width-self.scorllView.frame.size.width+20) {
//        [self didScrollToINC];
//    }
//    
//    self.pageControl.currentPage=scrollView.contentOffset.x/self.frame.size.width;
//}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView.contentOffset.x+scrollView.frame.size.width>=scrollView.contentSize.width+20) {
        [self didScrollToINC];
    }
//    self.pageControl.currentPage=scrollView.contentOffset.x/self.frame.size.width;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageControl.currentPage=scrollView.contentOffset.x/self.frame.size.width;
}
//滑动后页面跳转
-(void)didScrollToINC
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(didScrollToINC)]) {
        [self.delegate didScrollToINC];
    }
}
@end
