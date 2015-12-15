//
//  LSYBigImgShowView.m
//  MarketManage
//
//  Created by liangsiyuan on 15/1/28.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "LSYBigImgShowView.h"
#import "UIImageView+WebCache.h"
@interface LSYBigImgShowView()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation LSYBigImgShowView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"LSYBigImgShowView" owner:self options:nil][0];
        [self setFrame:frame];
        self.scrollView.delegate=self;
        self.scrollView.pagingEnabled = YES;
        UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        [self.scrollView addGestureRecognizer:tap];
    }
    return self;
}

-(void)setImages:(NSArray *)images
{

    int i=0;
    for (i=0; i<images.count; i++) {
        UIImageView * image=[[UIImageView alloc]initWithFrame:CGRectMake(self.bounds.size.width*i, 0, self.bounds.size.width, self.bounds.size.height)];
        image.contentMode = UIViewContentModeScaleAspectFit;
        NSDictionary * url=images[i];
        [image setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.host,[url objectForKey:@"url"]]] placeholderImage:[UIImage imageNamed:@"defaultimg_7.png"]];
       
        [self.scrollView addSubview:image];
    }
    self.pageControl.backgroundColor = [UIColor clearColor];
    self.pageControl.numberOfPages = i;
    self.pageControl.currentPage = 0;
    [self addSubview:self.pageControl];
    self.scrollView.contentSize=CGSizeMake(self.bounds.size.width*i, self.bounds.size.height);
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageControl.currentPage=scrollView.contentOffset.x/self.frame.size.width;
}

- (void)selectPageImageViewWithPage:(int)page
{
    self.pageControl.currentPage = page;
//    [self.scrollView scrollRectToVisible:CGRectMake(SCREENWIDTH * page, 0, SCREENWIDTH, SCREENHEIGHT) animated:NO];
    [self.scrollView setContentOffset:CGPointMake(SCREENWIDTH * page, 0) animated:NO];
}
-(void)tap
{
    [self removeFromSuperview];
}

@end
