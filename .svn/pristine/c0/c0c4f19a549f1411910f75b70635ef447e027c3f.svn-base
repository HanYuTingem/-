//
//  DOPDropDownMenu.m
//  DOPDropDownMenuDemo
//
//  Created by weizhou on 9/26/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

#import "DOPDropDownMenu.h"
#import "JPCommonMacros.h"

@implementation DOPIndexPath
- (instancetype)initWithColumn:(NSInteger)column row:(NSInteger)row {
    self = [super init];
    if (self) {
        _column = column;
        _row = row;
    }
    return self;
}

+ (instancetype)indexPathWithCol:(NSInteger)col row:(NSInteger)row {
    DOPIndexPath *indexPath = [[self alloc] initWithColumn:col row:row];
    return indexPath;
}
@end

#pragma mark - menu implementation

@interface DOPDropDownMenu ()
@property (nonatomic, assign) NSInteger currentSelectedMenudIndex;
@property (nonatomic, assign) BOOL show;
@property (nonatomic, assign) NSInteger numOfMenu;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, strong) UIView *backGroundView;
@property (nonatomic, strong) UITableView *tableView;
//data source
@property (nonatomic, copy) NSArray *array;
//layers array
@property (nonatomic, copy) NSArray *titles;
@property (nonatomic, copy) NSArray *indicators;
@property (nonatomic, copy) NSArray *bgLayers;
@property (nonatomic ,strong) UIImageView *indicatorImageView;
@end


@implementation DOPDropDownMenu

#pragma mark - getter
- (UIColor *)indicatorColor {
    if (!_indicatorColor) {
        _indicatorColor = [UIColor blackColor];
    }
    return _indicatorColor;
}

- (UIColor *)textColor {
    if (!_textColor) {
        _textColor = [UIColor blackColor];
    }
    return _textColor;
}

- (UIColor *)separatorColor {
    if (!_separatorColor) {
        _separatorColor = [UIColor blackColor];
    }
    return _separatorColor;
}

- (NSString *)titleForRowAtIndexPath:(DOPIndexPath *)indexPath {
    return [self.dataSource menu:self titleForRowAtIndexPath:indexPath];
}

#pragma mark - setter
- (void)setDataSource:(id<DOPDropDownMenuDataSource>)dataSource {
    _dataSource = dataSource;
    
    //configure view
    if ([_dataSource respondsToSelector:@selector(numberOfColumnsInMenu:)]) {
        _numOfMenu = [_dataSource numberOfColumnsInMenu:self];
    } else {
        _numOfMenu = 1;
    }
    
    CGFloat textLayerInterval = self.frame.size.width / ( _numOfMenu * 2);
//    CGFloat separatorLineInterval = self.frame.size.width / _numOfMenu;
    CGFloat bgLayerInterval = self.frame.size.width / _numOfMenu;
    
    NSMutableArray *tempTitles = [[NSMutableArray alloc] initWithCapacity:_numOfMenu];
    NSMutableArray *tempIndicators = [[NSMutableArray alloc] initWithCapacity:_numOfMenu];
    NSMutableArray *tempBgLayers = [[NSMutableArray alloc] initWithCapacity:_numOfMenu];
    
    for (int i = 0; i < _numOfMenu; i++) {
        //bgLayer
        CGPoint bgLayerPosition = CGPointMake((i+0.5)*bgLayerInterval, self.frame.size.height/2);
        CALayer *bgLayer = [self createBgLayerWithColor:[UIColor whiteColor] andPosition:bgLayerPosition];
        [self.layer addSublayer:bgLayer];
        [tempBgLayers addObject:bgLayer];
        //title
        CGPoint titlePosition = CGPointMake( (i * 2 + 1) * textLayerInterval , self.frame.size.height / 2);
        NSString *titleString = [_dataSource menu:self titleForRowAtIndexPath:[DOPIndexPath indexPathWithCol:i row:0]];
        CATextLayer *title = [self createTextLayerWithNSString:titleString withColor:self.textColor andPosition:titlePosition];
        [self.layer addSublayer:title];
        [tempTitles addObject:title];
        //indicator 上下箭头
        CAShapeLayer *indicator = [self createIndicatorWithColor:self.indicatorColor andPosition:CGPointMake(titlePosition.x + title.bounds.size.width / 2 + 8, self.frame.size.height / 2)];
        indicator.hidden = YES;
        [self.layer addSublayer:indicator];
        [tempIndicators addObject:indicator];
        
        self.indicatorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(titlePosition.x + title.bounds.size.width / 2 + 8, self.frame.size.height / 2 - 3, 10, 6)];
        self.indicatorImageView.image = [UIImage imageNamed:@"list_btn_arrow_downward.png"];
        [self addSubview:self.indicatorImageView];
        
        //separator
        /*
        if (i != _numOfMenu - 1) {
            CGPoint separatorPosition = CGPointMake((i + 1) * separatorLineInterval, self.frame.size.height / 2);
            CAShapeLayer *separator = [self createSeparatorLineWithColor:self.separatorColor andPosition:separatorPosition];
            [self.layer addSublayer:separator];
        }
        */
        
    }
    _titles = [tempTitles copy];
    _indicators = [tempIndicators copy];
    _bgLayers = [tempBgLayers copy];
}

#pragma mark - init method
- (instancetype)initWithOrigin:(CGPoint)origin andHeight:(CGFloat)height {
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    self = [self initWithFrame:CGRectMake(origin.x, origin.y, screenSize.width, height)];
    if (self) {
        _origin = origin;
        _currentSelectedMenudIndex = -1;
        _show = NO;
        
        //tableView init
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(origin.x, self.frame.origin.y + self.frame.size.height, self.frame.size.width, 0) style:UITableViewStylePlain];
        _tableView.rowHeight = 44;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorColor = [UIColor colorWithRed:226.0f/255.0f green:226.0f/255.0f blue:226.0f/255.0f alpha:1];
        _tableView.separatorInset = UIEdgeInsetsZero;
        // ios8 分割线
        if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [self.tableView setLayoutMargins:UIEdgeInsetsZero];
        }
        //self tapped
        self.backgroundColor = [UIColor whiteColor];
        UIGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuTapped:)];
        [self addGestureRecognizer:tapGesture];
        
        //background init and tapped
        _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(origin.x, origin.y, screenSize.width, screenSize.height)];
        _backGroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
        _backGroundView.opaque = NO;
        UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTapped:)];
        [_backGroundView addGestureRecognizer:gesture];
        
        //add bottom shadow
        UIView *bottomShadow = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-0.5, screenSize.width, 0.5)];
        bottomShadow.backgroundColor = [UIColor colorWithRed:226.0f/255.0f green:226.0f/255.0f blue:226.0f/255.0f alpha:1];
        [self addSubview:bottomShadow];
    }
    return self;
}

#pragma mark - init support
- (CALayer *)createBgLayerWithColor:(UIColor *)color andPosition:(CGPoint)position {
    CALayer *layer = [CALayer layer];
    
    layer.position = position;
    layer.bounds = CGRectMake(0, 0, self.frame.size.width/self.numOfMenu, self.frame.size.height-1);
//    NSLog(@"bglayer bounds:%@",NSStringFromCGRect(layer.bounds));
//    NSLog(@"bglayer position:%@", NSStringFromCGPoint(position));
    layer.backgroundColor = color.CGColor;
    
    return layer;
}

// 画的箭头
- (CAShapeLayer *)createIndicatorWithColor:(UIColor *)color andPosition:(CGPoint)point {
    CAShapeLayer *layer = [CAShapeLayer new];
    
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(4, 5)];
    [path addLineToPoint:CGPointMake(8, 0)];
    [path closePath];
    
    layer.path = path.CGPath;
    layer.lineWidth = 1.0;
    layer.fillColor = color.CGColor;
    
    CGPathRef bound = CGPathCreateCopyByStrokingPath(layer.path, nil, layer.lineWidth, kCGLineCapButt, kCGLineJoinMiter, layer.miterLimit);
    layer.bounds = CGPathGetBoundingBox(bound);
    
    layer.position = point;
    
    return layer;
}

- (CAShapeLayer *)createSeparatorLineWithColor:(UIColor *)color andPosition:(CGPoint)point {
    CAShapeLayer *layer = [CAShapeLayer new];
    
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(160,0)];
    [path addLineToPoint:CGPointMake(160, 20)];
    
    layer.path = path.CGPath;
    layer.lineWidth = 1.0;
    layer.strokeColor = color.CGColor;
    
    CGPathRef bound = CGPathCreateCopyByStrokingPath(layer.path, nil, layer.lineWidth, kCGLineCapButt, kCGLineJoinMiter, layer.miterLimit);
    layer.bounds = CGPathGetBoundingBox(bound);
    
    layer.position = point;
//    NSLog(@"separator position: %@",NSStringFromCGPoint(point));
//    NSLog(@"separator bounds: %@",NSStringFromCGRect(layer.bounds));
    return layer;
}

- (CATextLayer *)createTextLayerWithNSString:(NSString *)string withColor:(UIColor *)color andPosition:(CGPoint)point {
    
    CGSize size = [self calculateTitleSizeWithString:string];
    
    CATextLayer *layer = [CATextLayer new];
    CGFloat sizeWidth = (size.width < (self.frame.size.width / _numOfMenu) - 25) ? size.width : self.frame.size.width / _numOfMenu - 25;
    layer.bounds = CGRectMake(0, 0, sizeWidth, size.height);
    layer.string = string;
    layer.fontSize = 13.0;
    layer.alignmentMode = kCAAlignmentCenter;
    layer.foregroundColor = color.CGColor;
    layer.contentsScale = [[UIScreen mainScreen] scale];
    
    layer.position = point;
    
    return layer;
}

- (CGSize)calculateTitleSizeWithString:(NSString *)string
{
    CGFloat fontSize = 13.0;
    NSDictionary *dic = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    CGSize size = [string boundingRectWithSize:CGSizeMake(280, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return size;
}

#pragma mark - gesture handle
- (void)menuTapped:(UITapGestureRecognizer *)paramSender {
    CGPoint touchPoint = [paramSender locationInView:self];
    //calculate index
    NSInteger tapIndex = touchPoint.x / (self.frame.size.width / _numOfMenu);
 
    for (int i = 0; i < _numOfMenu; i++) {
        if (i != tapIndex) {
            [self animateIndicator:_indicators[i] Forward:NO complete:^{
                [self animateTitle:_titles[i] show:NO complete:^{
                    
                }];
            }];
            [(CALayer *)self.bgLayers[i] setBackgroundColor:[UIColor whiteColor].CGColor];
        }
    }
    
    if (tapIndex == _currentSelectedMenudIndex && _show) {
        [self animateIdicator:_indicators[_currentSelectedMenudIndex] background:_backGroundView tableView:_tableView title:_titles[_currentSelectedMenudIndex] forward:NO complecte:^{
            _currentSelectedMenudIndex = tapIndex;
            _show = NO;
        }];
        [(CALayer *)self.bgLayers[tapIndex] setBackgroundColor:[UIColor whiteColor].CGColor];
    } else {
        _currentSelectedMenudIndex = tapIndex;
        [_tableView reloadData];
        [self animateIdicator:_indicators[tapIndex] background:_backGroundView tableView:_tableView title:_titles[tapIndex] forward:YES complecte:^{
            _show = YES;
        }];
        // 下拉时标题的背景颜色
        [(CALayer *)self.bgLayers[tapIndex] setBackgroundColor:[UIColor whiteColor].CGColor];
    }
}

- (void)backgroundTapped:(UITapGestureRecognizer *)paramSender
{
    [self animateIdicator:_indicators[_currentSelectedMenudIndex] background:_backGroundView tableView:_tableView title:_titles[_currentSelectedMenudIndex] forward:NO complecte:^{
        _show = NO;
    }];
    [(CALayer *)self.bgLayers[_currentSelectedMenudIndex] setBackgroundColor:[UIColor whiteColor].CGColor];
}

#pragma mark - animation method
- (void)animateIndicator:(CAShapeLayer *)indicator Forward:(BOOL)forward complete:(void(^)())complete {
    [CATransaction begin];
    [CATransaction setAnimationDuration:0.25];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithControlPoints:0.4 :0.0 :0.2 :1.0]];
    // 下拉旋转
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    anim.values = forward ? @[ @0, @(M_PI) ] : @[ @(M_PI), @0 ];
    if (!anim.removedOnCompletion) {
        [indicator addAnimation:anim forKey:anim.keyPath];
    } else {
        [indicator addAnimation:anim forKey:anim.keyPath];
        [indicator setValue:anim.values.lastObject forKeyPath:anim.keyPath];
    }
    [CATransaction commit];
    complete();
}

- (void)animateBackGroundView:(UIView *)view show:(BOOL)show complete:(void(^)())complete {
    if (show) {
        [self.superview addSubview:view];
        [view.superview addSubview:self];
        self.indicatorImageView.image = [UIImage imageNamed:@"list_btn_arrow_up.png"];
        [UIView animateWithDuration:0.2 animations:^{
            // 下拉时背景颜色
            view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        }];
    } else {
        self.indicatorImageView.image = [UIImage imageNamed:@"list_btn_arrow_downward.png"];
        [UIView animateWithDuration:0.2 animations:^{
            view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
        } completion:^(BOOL finished) {
            [view removeFromSuperview];
        }];
    }
    complete();
}

- (void)animateTableView:(UITableView *)tableView show:(BOOL)show complete:(void(^)())complete {
    if (show) {
        tableView.frame = CGRectMake(self.origin.x, self.frame.origin.y + self.frame.size.height, self.frame.size.width, 0);
        [self.superview addSubview:tableView];
        CGFloat tableViewHeight = ([tableView numberOfRowsInSection:0] > 5) ? (5 * tableView.rowHeight) : ([tableView numberOfRowsInSection:0] * tableView.rowHeight);
        [UIView animateWithDuration:0.2 animations:^{
            _tableView.frame = CGRectMake(self.origin.x, self.frame.origin.y + self.frame.size.height, self.frame.size.width, tableViewHeight);
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            _tableView.frame = CGRectMake(self.origin.x, self.frame.origin.y + self.frame.size.height, self.frame.size.width, 0);
        } completion:^(BOOL finished) {
            [tableView removeFromSuperview];
        }];
    }
    complete();
}

- (void)animateTitle:(CATextLayer *)title show:(BOOL)show complete:(void(^)())complete {
    CGSize size = [self calculateTitleSizeWithString:title.string];
    CGFloat sizeWidth = (size.width < (self.frame.size.width / _numOfMenu) - 25) ? size.width : self.frame.size.width / _numOfMenu - 25;
    title.bounds = CGRectMake(0, 0, sizeWidth, size.height);
    complete();
}

- (void)animateIdicator:(CAShapeLayer *)indicator background:(UIView *)background tableView:(UITableView *)tableView title:(CATextLayer *)title forward:(BOOL)forward complecte:(void(^)())complete{
    
    [self animateIndicator:indicator Forward:forward complete:^{
        [self animateTitle:title show:forward complete:^{
            [self animateBackGroundView:background show:forward complete:^{
                [self animateTableView:tableView show:forward complete:^{
                }];
            }];
        }];
    }];
    
    complete();
}

#pragma mark - table datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    NSAssert(self.dataSource != nil, @"menu's dataSource shouldn't be nil");
    if ([self.dataSource respondsToSelector:@selector(menu:numberOfRowsInColumn:)]) {
        return [self.dataSource menu:self
                numberOfRowsInColumn:self.currentSelectedMenudIndex];
    } else {
//        NSAssert(0 == 1, @"required method of dataSource protocol should be implemented");
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"DropDownMenuCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
//    NSAssert(self.dataSource != nil, @"menu's datasource shouldn't be nil");
    if ([self.dataSource respondsToSelector:@selector(menu:titleForRowAtIndexPath:)]) {
        cell.textLabel.text = [self.dataSource menu:self titleForRowAtIndexPath:[DOPIndexPath indexPathWithCol:self.currentSelectedMenudIndex row:indexPath.row]];
    } else {
//        NSAssert(0 == 1, @"dataSource method needs to be implemented");
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont systemFontOfSize:13.0];
    cell.textLabel.textColor = kkCColor;
    cell.separatorInset = UIEdgeInsetsZero;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    if (cell.textLabel.text == [(CATextLayer *)[_titles objectAtIndex:_currentSelectedMenudIndex] string]) {
        // 选中cell的颜色
        cell.backgroundColor = kkDColor;
    }
    
    return cell;
}

#pragma mark - tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate || [self.delegate respondsToSelector:@selector(menu:didSelectRowAtIndexPath:)]) {
        [self confiMenuWithSelectRow:indexPath.row];
        [self.delegate menu:self didSelectRowAtIndexPath:[DOPIndexPath indexPathWithCol:self.currentSelectedMenudIndex row:indexPath.row]];
    } else {
        //TODO: delegate is nil
    }
}

// ios8 分割线
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)confiMenuWithSelectRow:(NSInteger)row {
    CATextLayer *title = (CATextLayer *)_titles[_currentSelectedMenudIndex];
    title.string = [self.dataSource menu:self titleForRowAtIndexPath:[DOPIndexPath indexPathWithCol:self.currentSelectedMenudIndex row:row]];
    
    [self animateIdicator:_indicators[_currentSelectedMenudIndex] background:_backGroundView tableView:_tableView title:_titles[_currentSelectedMenudIndex] forward:NO complecte:^{
        _show = NO;
    }];
    [(CALayer *)self.bgLayers[_currentSelectedMenudIndex] setBackgroundColor:[UIColor whiteColor].CGColor];
    
    CAShapeLayer *indicator = (CAShapeLayer *)_indicators[_currentSelectedMenudIndex];
    indicator.position = CGPointMake(title.position.x + title.frame.size.width / 2 + 8, indicator.position.y);
}






@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
