//
//  ZXYFillerView.m
//  LiaoNing
//
//  Created by Rice on 14/11/25.
//  Copyright (c) 2014年 Sinoglobal. All rights reserved.
//

#import "ZXYFillerView.h"
#import "MarketAPI.h"

//标记tag值的倍数
#define NumTag 1000

@interface ZXYFillerView ()

{
    /** 全局的头View */
    //    CJFillerView *_headerView;
    /** 添加的CJFillerView的数组 */
    NSMutableArray *_fillerViewArray;
    NSInteger _row;
    
    CGRect _frame;
    CGFloat _btnH;
    /** 用来记录选中的第一行按钮是现金，还是积分 等 */
//    NSString *_oneSelectBtn;
    
//    
//    BOOL _once;
//    NSString *cashorIntegral;
//    
}
/** 完成按钮 */
@property (nonatomic, strong) UIButton *finishBtn;

@end

@implementation ZXYFillerView

+(ZXYFillerView *)shareInstance
{
    static ZXYFillerView *fillerView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fillerView = [[ZXYFillerView alloc] init];
        fillerView.saveModel = [ZXYFillerSaveModel shareInstance];
        
    });
    return fillerView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.fillerTableview = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        self.fillerTableview.separatorStyle = UITableViewCellSelectionStyleNone;
        self.fillerTableview.delegate = self;
        self.fillerTableview.dataSource = self;
        self.fillerTableview.bounces = NO;
        self.fillerTableview.tableFooterView = [[UIView alloc] init];
        if ([self.fillerTableview respondsToSelector:@selector(setSeparatorInset:)]) {
            [self.fillerTableview setSeparatorInset:UIEdgeInsetsZero];
        }
        
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        [self addSubview:self.fillerTableview];
        _row = -1;
        _fillerViewArray = [NSMutableArray array];
        
        _oneSelectBtn = @"";
        
        // 支付分类按钮
        NSMutableArray *dataArray = [NSMutableArray arrayWithObject:@[@"现金",@"积分",@"现金＋积分"]];
        for (int i = 0; i <dataArray.count; i++) {
            CJFillerView *fillerView = [self makeCJFillerViewWithDataArray:dataArray[i] numTag:i subTitleName:@""];
            [_fillerViewArray addObject:fillerView];
        }
        
        _frame = frame;
        
        /**
         * 添加完成按钮
         */
        [self makeFinishBtn];
        
        
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(btnDown:) name:@"Button1111111" object:nil];
        //        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideSelf)];
        //        [self addGestureRecognizer:tap];
        [self initSectionTags];
    }
    return self;
}

-(void)btnDown:(NSNotification *)no{
    
    
    NSLog(@"%@",no);
    
    [self.fillerTableview reloadData];

    //判断选择类型 传值给商品列表
    [self exSectionWithButton:[no.userInfo objectForKey:@"btn"]];
    UIButton *btn = [no.userInfo objectForKey:@"btn"];
    NSLog(@"%lu",btn.selected);
    _once = btn.selected;
    NSLog(@"%@",btn.titleLabel.text);
    _cashorIntegral = btn.titleLabel.text;
  
}
/**
 * 添加完成按钮
 */
- (void)makeFinishBtn
{
    _btnH = 46 * SP_HEIGHT;
    self.finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.finishBtn.frame = CGRectMake(0,  _btnH, SCREENWIDTH, _btnH);
    self.finishBtn.backgroundColor = [UIColor colorWithRed:0.72f green:0.02f blue:0.02f alpha:1.00f];
    [self.finishBtn setTitle:@"完成" forState:UIControlStateNormal];
    [self.finishBtn setTitle:@"完成" forState:UIControlStateHighlighted];
    [self.finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.finishBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.finishBtn addTarget:self action:@selector(finishBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.finishBtn];
}

/**
 * 完成按钮的点击事件
 */
- (void)finishBtnClick
{
    //判断选择类型 传值给商品列表
    [self judgFillertypeAndSelectValueToDelegate];
}

/**
 * 创建筛选按钮下得cellView
 */
- (CJFillerView *)makeCJFillerViewWithDataArray:(NSArray *)dataArray numTag:(NSInteger)numTag subTitleName:(NSString*)subTitleName
{
    NSArray *array = @[@"支付类型",@"商品分类:"];
    NSArray *subArray = @[@"",subTitleName];
    CJFillerView *fillerView = [[CJFillerView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 44) titleName:array[numTag] subTitleName:subArray[numTag] dataArray:dataArray numTag:numTag * NumTag oneSelsctBtnName:_oneSelectBtn];
//    if (_oneSelectBtn.length) {
//        [self exCurrentSecion];
//    }
    fillerView.tag = numTag;
    if (dataArray.count < 4) {
        fillerView.fillerLableBtn.hidden = YES;
    } else {
        fillerView.fillerLableBtn.hidden = NO;
    }
    //下拉按钮的点击事件的回调方法
    fillerView.blockFillerDownBtnClick = ^(UIButton *fillerViewBtn){
        
        [_fillerViewArray removeObjectAtIndex:fillerViewBtn.superview.tag];
        [_fillerViewArray insertObject:fillerViewBtn.superview atIndex:fillerViewBtn.superview.tag];
        
        [self.fillerTableview reloadData];
    };
    
    //里面大按钮的点击事件的回调
    fillerView.blockBtnText = ^(UIButton *fillerBt){
        [self exSectionWithButton:fillerBt];
        
    };
    return fillerView;
}

-(void)hideSelf
{
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"scrollHideCatagoryView" object:self];
}

-(void)setListFrame:(CGRect)frame fillerCategoryArray:(NSMutableArray *)fillerCategoryArray subTitleName:(NSString *)subTitleName
{
    [self setFrame:frame];
    
    //改变完成按钮的frame
    CGRect btnFrame = self.finishBtn.frame;
    btnFrame.origin.y = frame.size.height - self.finishBtn.size.height;
    self.finishBtn.frame = btnFrame;
    
    [self.fillerTableview setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - _btnH)];
    self.fillerTableview.backgroundColor = [UIColor clearColor];
    
    
    _fillerViewArray = [NSMutableArray array];
    
    
    // 支付分类按钮
    NSMutableArray *dataArray = [NSMutableArray arrayWithObject:@[@"现金",@"积分",@"现金＋积分"]];
    
    if (fillerCategoryArray.count) {
        [dataArray addObject:fillerCategoryArray];
    }
    
    int num = (int)dataArray.count;
    if (num == 1) {
        num = 2;
    }
    
    for (int i = 0; i <num; i++) {
        NSMutableArray *array = [NSMutableArray array];
        if (i < dataArray.count) {
            array.array = dataArray[i];
        }
        CJFillerView *fillerView = [self makeCJFillerViewWithDataArray:array numTag:i subTitleName:subTitleName];
        self.fillerView = fillerView;
        [_fillerViewArray addObject:fillerView];
    }
    
    
//    self.currExTag = [self.saveModel.currentType integerValue];
//    self.lastExTag = [self.saveModel.lastType integerValue];
    if (self.currExTag == 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectCash" object:nil];
    }else if (self.currExTag == 1){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectCoin" object:nil];
    }
    [self.fillerTableview reloadData];
    
}

#pragma mark - UItablviewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{

//    if ((section == 0 && self.currExTag < 2  && self.currExTag != -1) || (section == 0 && _once == YES)) {
//            return 1;
//        }
    if (section == 0) {
        return 1;
    }else
    {
        return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return _fillerViewArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CJFillerView *fillerView = (CJFillerView *)_fillerViewArray[section];
    return CGRectGetHeight(fillerView.frame);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
#if 0
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 44)];
    headerView.backgroundColor = [UIColor whiteColor];
    UIButton *exBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [exBtn setFrame:CGRectMake(0, 0, SCREENWIDTH, 44)];
    [exBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [exBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    [exBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    exBtn.titleLabel.font = [UIFont systemFontOfSize:14.];
    [exBtn setTag:section + 100];
    [exBtn addTarget:self action:@selector(exSectionWithButton:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *selectStatu = [[UIImageView alloc] initWithFrame:CGRectMake(260, 10, 24, 24)];
    if (self.currExTag == section) {
        selectStatu.image = [UIImage imageNamed:@"zxy_spanner_icon_selected"];
    }else {
        selectStatu.image = [UIImage imageNamed:@"zxy_spanner_btn_normal"];
    }
    [exBtn addSubview:selectStatu];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0,43, SCREENWIDTH, 0.7)];
    line.backgroundColor = [UIColor grayColor];
    line.alpha = .3;
    [headerView addSubview:line];
    
    switch (section) {
        case 0:
        {
            [exBtn setTitle:@"现金购买" forState:UIControlStateNormal];
            break;
        }
        case 1:
        {
            [exBtn setTitle:[NSString stringWithFormat:@"%@购买",INTERGRAL_NAME] forState:UIControlStateNormal];
            break;
        }
        case 2:
        {
            [exBtn setTitle:[NSString stringWithFormat:@"现金+%@",INTERGRAL_NAME] forState:UIControlStateNormal];
            break;
        }
        case 3:
        {
            UIColor *titleColor = [UIColor colorWithRed:164/255. green:0 blue:0 alpha:1];
            exBtn.layer.cornerRadius = 6.;
            exBtn.layer.borderColor = titleColor.CGColor;
            exBtn.layer.borderWidth = 1;
            [exBtn setFrame:CGRectMake(self.bounds.size.width / 3, 7, self.bounds.size.width / 3, 30)];
            [exBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
            [exBtn setTitleEdgeInsets:UIEdgeInsetsZero];
            [exBtn setTitleColor:titleColor forState:UIControlStateNormal];
            [exBtn setTitle:@"完成" forState:UIControlStateNormal];
            
            break;
        }
        default:
            break;
    }
    [headerView addSubview:exBtn];
#endif
    
    // 支付分类按钮
    CJFillerView *headerView = _fillerViewArray[section];
    
    return headerView;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    ZXYFillerCell *slideCell = [tableView dequeueReusableCellWithIdentifier:@"fillerCell"];
    if (slideCell == nil) {
        slideCell = [[NSBundle mainBundle] loadNibNamed:@"ZXYFillerCell" owner:self options:nil][0];
        slideCell.selectionStyle = UITableViewCellSelectionStyleNone;
        slideCell.delegate = self;
    }
    return slideCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        if (_once) {
            if ([_cashorIntegral isEqualToString:@"现金＋积分"]) {
                return 0;
            }else{
                return 80;
            }
        }
        
    }
    return 0;
}
#pragma mark - EX

-(void)initSectionTags
{
    self.lastExTag = -1;
    self.currExTag = -1;
}

/** 判断点击的是现金 积分 现金+积分 还是完成 */
-(void)exSectionWithButton:(UIButton *)sender
{
    //判断是第一个端头的View(0) 还是其他的断头
    if (sender.superview.tag == 0) {
        UIButton *exBtn = (UIButton *)sender;
        NSInteger row = exBtn.tag % NumTag;
        if (row == 3) {
            self.saveModel.currentType = [NSString stringWithFormat:@"%ld",(long)self.currExTag];
            self.saveModel.lastType = [NSString stringWithFormat:@"%ld",(long)self.lastExTag];
        }
        
        //选择现金+积分或完成
        if (row > 1) {
            //            _row = -1;
            if (self.currExTag == row) {
                [self initSectionTags];
                [self.fillerTableview reloadData];
            }else{
                self.currExTag = row;
                switch (self.currExTag) {
                    case 2:{//现金+积分
                        [self.fillerTableview reloadData];
                        self.lastExTag = self.currExTag;
                        _oneSelectBtn = @"现金＋积分";
                        break;
                    }
                    case 3:{//完成
                        [self judgFillertypeAndSelectValueToDelegate];
                        break;
                    }
                    default:
                        break;
                }
            }
            
            return;
        }
        //        _row = 0;
        //展开逻辑
        if (self.currExTag == 2) {
            self.lastExTag = -1;            
        }
        if (self.lastExTag == -1) {
            self.currExTag = row;
            [self exCurrentSecion];
            self.lastExTag = self.currExTag;
        }else if(self.lastExTag == row){
            self.currExTag = -1;
            [self delLastSecion];
            [self initSectionTags];
        }else if (self.lastExTag != -1 ){
            self.currExTag = -1;
            [self delLastSecion];
            self.currExTag = row;
            self.lastExTag = self.currExTag;
            [self exCurrentSecion];
        }
        
        
        //通知cell更换选择类别
        switch (exBtn.tag % NumTag) {
            case 0:
            {
                _oneSelectBtn = @"现金";
                [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectCash" object:nil];
                break;
            }
                //            case 1:
                //            {
                //                [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectCash" object:nil];
                //                break;
                //            }
            case 1:
            {
                _oneSelectBtn = @"积分";
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectCoin" object:nil];
                break;
            }
            default:
                break;
        }
        
        [self.fillerTableview reloadData];
    } else if (sender.superview.tag == 1) {
        self.blockFillerCategoryBtn(sender.tag % 1000);
    }
    
}
//-(void)Storage{
//    
//}
/** cell的展开 */
-(void)exCurrentSecion
{
    
    [self.fillerTableview reloadData];
//    NSLog(@"展开%ld",(long)self.currExTag);
//    NSArray *indexAry = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0],nil];
//    [self.fillerTableview insertRowsAtIndexPaths:indexAry withRowAnimation:UITableViewRowAnimationNone];
}
/** cell的关闭 */
-(void)delLastSecion
{
    [self.fillerTableview reloadData];
//    NSLog(@"删除%ld",(long)self.lastExTag);
//    NSArray *indexAry = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0],nil];
//    [self.fillerTableview deleteRowsAtIndexPaths:indexAry withRowAnimation:UITableViewRowAnimationNone];
}

/**判断选择类型 传值给商品列表
 */
-(void)judgFillertypeAndSelectValueToDelegate
{
    if (self.lastExTag == 0 || self.lastExTag == 1) {//现金/积分
        if ([self.delegate respondsToSelector:@selector(fillerResultWithType:andLeftValue:andRightValue:)]) {
            [self.delegate fillerResultWithType:self.lastExTag andLeftValue:[self.saveModel.leftValueAry[self.lastExTag] floatValue] andRightValue:[self.saveModel.rightValueAry[self.lastExTag] floatValue]];
        }
    }else if(self.lastExTag == 2){//现金+积分
        if ([self.delegate respondsToSelector:@selector(fillerResultWithType:andLeftValue:andRightValue:)]) {
            [self.delegate fillerResultWithType:2 andLeftValue:0 andRightValue:0];
        }
    }else{//未选择 传3
        if ([self.delegate respondsToSelector:@selector(fillerResultWithType:andLeftValue:andRightValue:)]) {
            [self.delegate fillerResultWithType:3 andLeftValue:0 andRightValue:0];
        }
    }
}

-(void)updateValueForSliderWithLeftValue:(CGFloat)leftValue andRightValue:(CGFloat)rightValue
{
    self.sliderLeftValue = leftValue;
    self.sliderRightValue = rightValue;
    switch (self.currExTag) {
        case 0://现金
        {
            self.saveModel.leftValueAry[0] = [NSString stringWithFormat:@"%.2f",leftValue];
            self.saveModel.rightValueAry[0] = [NSString stringWithFormat:@"%.2f",rightValue];
            break;
        }
        case 1://积分
        {
            self.saveModel.leftValueAry[1] = [NSString stringWithFormat:@"%.2f",leftValue];
            self.saveModel.rightValueAry[1] = [NSString stringWithFormat:@"%.2f",rightValue];
            break;
        }
        default:
            break;
    }
    
}



@end
