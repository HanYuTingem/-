//
//  RouteListView.m
//  HCheap
//
//  Created by dairuiquan on 14-12-12.
//  Copyright (c) 2014年 qiaohongchao. All rights reserved.
//

#import "RouteListView.h"
#import "RouteViewCell.h"
#define Screen_Height [UIScreen mainScreen].bounds.size.height
#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Version [[[UIDevice currentDevice] systemVersion] floatValue]
@implementation RouteListView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self showUI];
    }
    return self;
}

- (void)showUI
{
    self.backgroundColor = [UIColor clearColor];
    _flag = NO;
    _backImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _backImageView.userInteractionEnabled = NO;
    //_backImageView.backgroundColor = [UIColor purpleColor];
    
    [_backImageView setImage:[UIImage imageNamed:@"map_0001_bg3"]];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    
    
    [self addGestureRecognizer:tap];
    [self addGestureRecognizer:pan];
    
    [self addSubview:_backImageView];
    [self createTableView];
}

- (void)createTableView
{
    if (_tableView == nil)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, Screen_Width, self.frame.size.height-40) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:_tableView];
    }
    
}

//点击手势
- (void)tapClick:(UITapGestureRecognizer *)tap
{
    NSLog(@"dianji");
    [self.delegate routeListTap];

    
}

//拖动手势
- (void)pan:(UIPanGestureRecognizer *)pan
{
    [self.delegate routeListPan:pan];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    RouteViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RouteViewCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSString *str = [[NSString alloc] init];
    if (indexPath.row == 0) {
       str = @"查看详细路线步骤";
    } else {
        str = _dataArray[indexPath.row - 1];
    }
//    NSString *str = _dataArray[indexPath.row];
    NSMutableString *appendStr = [[NSMutableString alloc] init];
    for (int i=0; i<str.length; ++i)
    {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [str substringWithRange:range];
        const char *cString = [subString UTF8String];
        if (strlen(cString) == 3)
        {
           // NSLog(@"汉字:%s", cString);
            [appendStr appendString:subString];
            
        }else if((([subString characterAtIndex:0] >= '0') && ([subString characterAtIndex:0] <= '9'))|| ([subString characterAtIndex:0] == ',') || ([subString characterAtIndex:0] == '.'))
        {
            [appendStr appendString:subString];
            
        }else
        {
            
        }
       
    }
    NSRange range = [appendStr rangeOfString:@"0000000"];
    if (range.location != NSNotFound)
    {
        NSArray *arr = [appendStr componentsSeparatedByString:@"0000000"];
        appendStr = [[NSMutableString alloc] init];
        [appendStr appendString:arr[0]];
        [appendStr appendString:arr[1]];
    }
    cell.routeInfoLabel.text = appendStr;
    if (indexPath.row == 0) {
        cell.routeInfoLabel.textAlignment = NSTextAlignmentCenter;
    }
//    cell.routeInfoLabel.height = [self getInfoHeight:appendStr];
    cell.routeInfoLabel.numberOfLines = 0 ;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSString *str = _dataArray[indexPath.row];
    NSString *str = [[NSString alloc] init];
    if (indexPath.row == 0) {
        str = @"查看详细路线步骤";
    } else {
        str = _dataArray[indexPath.row - 1];
    }
    NSMutableString *appendStr = [[NSMutableString alloc] init];
    for (int i=0; i<str.length; ++i)
    {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [str substringWithRange:range];
        const char *cString = [subString UTF8String];
        if (strlen(cString) == 3)
        {
            [appendStr appendString:subString];
            
        }else if((([subString characterAtIndex:0] >= '0') && ([subString characterAtIndex:0] <= '9'))|| ([subString characterAtIndex:0] == ',') || ([subString characterAtIndex:0] == '.'))
        {
            [appendStr appendString:subString];
            
        }else
        {
            
        }
        
    }
    return 30 + [self getInfoHeight:appendStr];
}

- (CGFloat)getInfoHeight:(NSString *)str{
    
    //根据label 中的内容实际大小来计算 label 的高度
    if (Version >= 7.0) {//iOS7的设备
        NSDictionary *dict=[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName, nil];
        //根据字符串内容 然后算出字符串 需要的高度
        //第一个参数给一个预定的宽和高
        //最后会根据字符串内容的实际大小 进行返回
        //第三个参数就是传一个属性字符串的属性 设置字体
        CGSize size =[str boundingRectWithSize:CGSizeMake(250, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dict context:NULL].size;
        return size.height;
        
    }else{//iOS7 之前的写法
        
        CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(250, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping];
        return size.height;
    }
}
@end
