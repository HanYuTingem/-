//
//  TableHeaderView.m
//  QQList
//
//  Created by sunsu on 15/6/23.
//  Copyright (c) 2015年 CarolWang. All rights reserved.
//

#import "TableHeaderView.h"

#define _allowAppearance    NO

@interface TableHeaderView()<DZNSegmentedControlDelegate>
{
    UIImageView * _locationImg;
    UIImageView * _backImg;
    UIImageView * _bgImg;
}




@end
@implementation TableHeaderView
-(instancetype)init{
    self = [super init];
    if (self) {
        self.segTitles = [NSMutableArray array];
    }
    return self;
}

+(instancetype)headerViewWithFrame:(CGRect)frame andModel:(GetMerOrVideoModel*)model{
    return [[[self class]alloc]initWithHeaderViewFrame:frame andModel:model];
}

-(instancetype)initWithHeaderViewFrame:(CGRect)frame andModel:(GetMerOrVideoModel*)model{
    self = [super initWithFrame:frame];
    if (self) {
        [self createFoodImageView];
        
        if ([model.state intValue]==1) {
            self.segTitles = [NSMutableArray arrayWithObjects:@"信息",@"商品", nil];
        }else{
            self.segTitles = [NSMutableArray arrayWithObjects:@"信息", nil];
        }
        ZNLog(@"segTitles=%@-model.state:%@",self.segTitles,model.state);
        [self addSubview:[self createControlWithItems:self.segTitles]];
    }
    return self;
}

-(void)createFoodImageView{
    
    _locationImg = [[UIImageView alloc]init];
    _locationImg.image = [UIImage imageNamed:@"mapicon.png"];
    
    self.locationLabel = [[UILabel alloc]init];
    self.locationLabel.font = [UIFont systemFontOfSize:12];
    self.locationLabel.tag = TAG_LOCATIONIMG;
    self.locationLabel.textColor = RGBCOLOR(250, 250, 250);
    self.locationLabel.numberOfLines = 0;
    [self.locationLabel sizeToFit];
    //self.locationLabel.backgroundColor = [UIColor yellowColor];
    
    
    self.foodImg = [[UIImageView alloc]init];
    self.foodImg.contentMode = UIViewContentModeScaleToFill;
    
    _bgImg = [[UIImageView alloc]init];
    _bgImg.image = [UIImage imageNamed:@"shanghubg.png"];
    _bgImg.backgroundColor = [UIColor clearColor];
    
    _backImg = [[UIImageView alloc]init];
    _backImg.image = [UIImage imageNamed:@"programme_list_abg.png"];
    
    [self addSubview:self.foodImg];
    [self addSubview:_bgImg];
    [self addSubview:_backImg];
    [_backImg addSubview:self.locationLabel];
    [_backImg addSubview:_locationImg];
    
    
    self.mapButton = [[UIButton  alloc]init];
    [self.mapButton addTarget:self action:@selector(gotoMap) forControlEvents:UIControlEventTouchUpInside];
    self.mapButton.userInteractionEnabled = YES;
    self.mapButton.backgroundColor = [UIColor clearColor];
    [self bringSubviewToFront:self.mapButton];
    [self addSubview:self.mapButton];
    
}

-(void)gotoMap{
    if (self.deleagte && [self.deleagte respondsToSelector:@selector(turnToMap)]) {
        [self.deleagte turnToMap];
    }
}

- (DZNSegmentedControl *)createControlWithItems:(NSArray*)items
{
    if (!_control)
    {
        
        _control = [[DZNSegmentedControl alloc] initWithItems:items];
        _control.selectedSegmentIndex = 0;
        _control.bouncySelectionIndicator = YES;
        _control.tintColor = RGBCOLOR(239, 60, 80);
        _control.animationDuration = 0.5;
        _control.backgroundColor = RGBCOLOR(250, 250, 250);
        _control.font = [UIFont fontWithName:@"EuphemiaUCAS" size:14.0];
        [_control setShowsGroupingSeparators:NO];
        _control.adjustsFontSizeToFitWidth = NO;
        _control.frame = CGRectMake(0, CGRectGetMaxY(self.foodImg.frame), SCREEN_WIDTH, 50);
        [_control setShowsCount:NO];
        [_control addTarget:self action:@selector(selectedSegment:) forControlEvents:UIControlEventTouchUpInside];
        _control.hairlineColor = [UIColor lightGrayColor];
        self.control.userInteractionEnabled = YES;
        [_control setTitleColor:RGBCOLOR(103, 103, 103) forState:UIControlStateNormal];
    }
    return _control;
}


- (void)selectedSegment:(DZNSegmentedControl *)control
{
    if (self.deleagte && [self.deleagte respondsToSelector:@selector(clickByIndex:)]) {
        [self.deleagte clickByIndex:control.selectedSegmentIndex];
    }
}



/**
 *  自定义HeaderView界面控件frame设置
 */
-(void)layoutSubviews{
    [super layoutSubviews];
    
   
    
}

/**
 *  赋值
 *  @param merchantModel 商户详情Model
 */
-(void)setMerchantModel:(MerchantModel *)merchantModel{
    _merchantModel = merchantModel;
    NSString * imageStr = [NSString stringWithFormat:@"%@%@",NiceFood_ImageUrl,_merchantModel.imageUrl];
    [_foodImg setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:[UIImage imageNamed:DefaultPicture]];    
    _locationLabel.text = _merchantModel.address;
    
    /**  商户图片frame设置 */
    CGFloat headerViewH = 250;
    CGRect headerViewFrame = CGRectMake(0, 0, SCREEN_WIDTH, headerViewH);
    self.foodImg.frame = headerViewFrame;
    
    _bgImg.frame = headerViewFrame;
    
    CGFloat backImgH = 50;
    _backImg.frame = CGRectMake(0, headerViewH-backImgH, SCREEN_WIDTH, backImgH);
    
    /**  商户定位图片frame设置 */
    CGRect locationImgFrame = CGRectMake(2*PADDING, (backImgH-20)/2, 20, 20);
    _locationImg.frame = locationImgFrame;
    
    // *  商户地址frame设置
    CGFloat locationLabelH = [MyUtils sizeWithString:self.locationLabel.text font:12.0f maxSize:CGSizeMake(SCREEN_WIDTH-4*PADDING, MAXFLOAT)].height;//[self getHeight:self.locationLabel.text];
    CGFloat height = 20;
    if (locationLabelH > 20) {
        height = locationLabelH;
    }else{
        height = 20;
    }
    CGFloat locationLabelX = CGRectGetMaxX(locationImgFrame)+PADDING;
    CGRect locationLabelFrame = CGRectMake(locationLabelX,(_backImg.frame.size.height-height)/2, SCREEN_WIDTH-locationLabelX-PADDING,height);
    self.locationLabel.frame = locationLabelFrame;
    
    self.mapButton.frame =  CGRectMake(0, 200, SCREEN_WIDTH, 50);
    
    /** 商户显示按钮frame设置 */
    _control.frame = CGRectMake(0, CGRectGetMaxY(self.foodImg.frame), SCREEN_WIDTH, 50);}


-(void)setGetMerOrVideoModel:(GetMerOrVideoModel *)getMerOrVideoModel{
    _getMerOrVideoModel = getMerOrVideoModel;
    
}

@end

