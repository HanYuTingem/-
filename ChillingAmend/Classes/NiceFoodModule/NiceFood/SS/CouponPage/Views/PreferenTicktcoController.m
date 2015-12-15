//
//  PreferenTicktcoController.m
//  MyNiceFood
//
//  Created by liujinhe on 15/7/28.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import "PreferenTicktcoController.h"
#import "CouonlScrollView.h"
#import  "DownLoadData.h"
#import "XiangqinMdel.h"
#import "MerchantsListModel.h"
#import "ListTableViewController.h"
#import "OtherShopListViewController.h"
#import "UMSocial.h"


/**   从我的优惠劵界面进入 */

@interface PreferenTicktcoController ()
{
    CouonlScrollView * _couponDetailScrollView;
}
@property (nonatomic,strong) NSArray *dataDictionaey;
@property (nonatomic,strong) NSArray *shopDictionaey;
@property (nonatomic,strong) CouonlScrollView * couponDetailScrollView;
@property (nonatomic,strong) UIImage *imageIcn;
@end

@implementation PreferenTicktcoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeUI];
    [self downLodendData];
}


- (void)makeUI{
    titleButton.hidden = NO;
    [titleButton setTitle:@"优惠券详情" forState:UIControlStateNormal];//@"优惠劵详情"
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self showStartHud1];
}


- (void) reschUI{
    CGRect couponFrame = CGRectMake(0, 65, SCREEN_WIDTH, SCREEN_HEIGHT-65);
    _couponDetailScrollView = [[CouonlScrollView alloc]initWithCouponDetailViewFrame:couponFrame];
    [_couponDetailScrollView setUserInteractionEnabled:YES];
    _couponDetailScrollView.showsVerticalScrollIndicator = NO;
//    _couponDetailScrollView.contentSize =  CGSizeMake(SCREEN_WIDTH ,1.3*SCREEN_HEIGHT);
    if (self.flagToStatus == 1) {
        [_couponDetailScrollView.getMoneyButton setBackgroundImage:[UIImage imageNamed:@"settingmessagelogin_message_btn_verification_bg_normal"] forState:UIControlStateNormal];
        [_couponDetailScrollView.getMoneyButton setUserInteractionEnabled:NO];
    }else{
        [_couponDetailScrollView.getMoneyButton addTarget:self action:@selector(shareToFriend:) forControlEvents:UIControlEventTouchUpInside];
    }
    [_couponDetailScrollView.merchantListView.merchantNameBtn setTitle:_shopName forState:UIControlStateNormal];
    [_couponDetailScrollView.merchantListView.merchantNameBtn addTarget:self action:@selector(nameTuern:) forControlEvents:UIControlEventTouchUpInside];
    [_couponDetailScrollView.merchantListView.merchantPhoneBtn addTarget:self action:@selector(telPhoneCall:) forControlEvents:UIControlEventTouchUpInside];
    _couponDetailScrollView.useLabel.text = _usedTre;
    _couponDetailScrollView.textLabel.text = _valideTime;
    [_couponDetailScrollView.checkButton addTarget:self action:@selector(getCoupon) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_couponDetailScrollView];
    if (_shopDictionaey.count==0) {
        _couponDetailScrollView.checkButton.hidden = YES;
        _couponDetailScrollView.horzLabel.hidden = YES;
    }else{
        _couponDetailScrollView.checkButton.hidden = NO;
        if (_shopDictionaey.count==1) {
            _couponDetailScrollView.checkButton.hidden = YES;
            _couponDetailScrollView.horzLabel.hidden = YES;
        }
        MerchantsListModel *merModel = _shopDictionaey[0];
        _couponDetailScrollView.merchantListView.merchantAddressLabel.text = merModel.address;
        [_couponDetailScrollView.merchantListView.merchantNameBtn setTitle:merModel.merchantName forState:UIControlStateNormal];
        _phoneNumber = merModel.phone;
    }
    XiangqinMdel *xiangModel = _dataDictionaey[0];
    NSLog(@"%@",xiangModel.couponDesc);
//    _couponDetailScrollView.precautionsLabel.text = xiangModel.couponDesc;
//    _couponDetailScrollView.precautionsLabel.frame = CGRectMake(10, 350, SCREEN_WIDTH-20,[self getHeight:xiangModel.couponDesc]);
//    _couponDetailScrollView.precautionsLabel.textAlignment = NSTextAlignmentLeft;
    
    NSString * htmlStr = xiangModel.couponDesc;
    [_couponDetailScrollView.detailWebview loadHTMLString:htmlStr baseURL:nil];
    _couponDetailScrollView.detailWebview.frame = CGRectMake(10, 350, SCREEN_WIDTH-20,100);
    
    _couponDetailScrollView.baseKetView.frame = CGRectMake(0,CGRectGetMaxY(_couponDetailScrollView.detailWebview.frame), SCREEN_WIDTH,200);
    [_couponDetailScrollView.checkButton setTitle:[NSString stringWithFormat:@"查看全部%ld家分店",(unsigned long)_shopDictionaey.count] forState:UIControlStateNormal];
    _couponDetailScrollView.bianLabel.text =[NSString stringWithFormat:@"优惠券编号:%@",xiangModel.couponId];
    _couponDetailScrollView.contentSize =  CGSizeMake(SCREEN_WIDTH ,CGRectGetMaxY(_couponDetailScrollView.baseKetView.frame)+20);
}

- (void)downLodendData{
    NSDictionary *parameter = @{@"couponId":_couponId,@"proIden":PROIDEN,@"oId":HUserId,@"phone":PhoneNumber};
    NSDictionary *dic = @{@"method":GETCOUPONDETAIL,@"json":[parameter JSONRepresentation]};
    [DownLoadData tesitTimelinePostsWithBlock:^(NSArray *posts, NSArray *post, NSError *error) {
        [self stopHud:@"加载完成"];
        _dataDictionaey = posts;
        _shopDictionaey = post;
        [self reschUI];
    } andWithdic:dic];
    
}

#pragma mark - 导航栏方法;
-(void)sendBtn:(id)sender{
    
}

-(void)backToView{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getCoupon{
    NSArray *sortedArray = [_shopDictionaey sortedArrayUsingComparator:^(MerchantsListModel *model1,MerchantsListModel *model2) {
        
        double val1 = [self somewhereFromTheUserDistanceByLat:model1.lat lng:model1.lng];
        double val2 = [self somewhereFromTheUserDistanceByLat:model2.lat lng:model2.lng];
        if (val1 <= val2) {
            return NSOrderedAscending;
        } else {
            return NSOrderedDescending;
        }
    }];
    //   其余五家的方法
    NSLog(@"查看其余方法在这里实现");
    OtherShopListViewController *otherShopListVC = [[OtherShopListViewController alloc] init];
    otherShopListVC.shopListMutableArray = sortedArray;
    [self.navigationController pushViewController:otherShopListVC animated:YES];
    
}
//根据经纬度算出距某地的距离
- (CLLocationDistance)somewhereFromTheUserDistanceByLat:(NSString *)latStr lng:(NSString *)lngStr
{
    float mlat =  [latStr floatValue];
    float mlng = [lngStr floatValue];
    //获取其他商户经纬度点
    BMKMapPoint point1 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(mlat,mlng));
    //优惠券详情商家经纬度点
    BMKMapPoint point2 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(LATITUDE,LONGITUDE));
    //获取两点之间的距离
    CLLocationDistance distance = BMKMetersBetweenMapPoints(point1,point2);
    return distance;
}
- (void)telPhoneCall:(UIButton*)button{
    NSLog(@"电话方法在这里实现");
    if (_phoneNumber!=nil) {
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",_phoneNumber];
        NSLog(@"str======%@",str);
        BOOL b = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:str]];
        if (b) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }else{
            [self showMsg:@"该设备无法拨打电话"];
        }
    }
    
}
- (void)nameTuern:(UIButton*)button{
    NSLog(@"name方法在这里实现");
    if (_shopDictionaey.count>0) {
        MerchantsListModel *merModel = _shopDictionaey[0];
        ListTableViewController *merchantDetailVC = [[ListTableViewController alloc] init];
        merchantDetailVC.ownerId = merModel.ownerId;
        merchantDetailVC.oId = HUserId;
        [self.navigationController pushViewController:merchantDetailVC animated:YES];
    }
    
    
}
- (void)shareToFriend:(UIButton*)button{
    NSLog(@"分享方法在这里实现");
    if ([_status isEqualToString:@"1"] ) {
        [self showMsg:@"该优惠券已过期"];
        
    }else{
        /*
         分享
         @param title 分享到各平台的标题
         @param url 分享的链接
         @param content 分享的文字内容
         @param imagePath 分享的图片地址 // 这个不用传
         @param type 来自某个平台的分享  投票首页1 投票详情2  报名详情3 节目首页4 节目详情5  爆料首页6 爆料详情7 活动详情8 资讯详情9 评论分享10  个人足迹分享11  获奖详情分享12 邀请分享13 关于界面的分享14  扫一扫分享15 魔幻拼图分享16 接金币17 小鸟18
         @param AimgStr  图片
         @param AdomainName 域名  此变量不用了/
        */
        XiangqinMdel *xiangModel = _dataDictionaey[0];
        MerchantsListModel *mermode = _shopDictionaey[0];
        NSString * urlStr = [NSString stringWithFormat:@"%@coupon?couponId=%@&productId=2&merchantId=%@",Http,xiangModel.couponId,self.ownerId];
        NSString *sharesina = [NSString stringWithFormat:@"我看到[%@]发优惠券啦![%@]好东西要和你一起分享!快点领取,完了就没啦! %@",_shopName,xiangModel.couponName,urlStr];
        NSString *shareqq = [NSString stringWithFormat:@"[%@]优惠券!快点领取,晚了就没了!",xiangModel.couponName];
        NSString *shareqqZ = [NSString stringWithFormat:@"我看到[%@]发优惠券啦![%@]好东西要和你一起分享!快点领取,晚了就没啦!",_shopName,xiangModel.couponName];
        NSString *shareWe = [NSString stringWithFormat:@"[%@]发了[%@]优惠券",_shopName,xiangModel.couponName];
        NSString *shareWecht= [NSString stringWithFormat:@"[%@]发优惠券啦![%@]快点领取,晚了就没啦!",_shopName,xiangModel.couponName];
        
        NSString *imageUrl = [NSString stringWithFormat:@"%@%@",NiceFood_ImageUrl,mermode.merchantUrl];
        if (mermode.merchantUrl == nil) {
            imageUrl = @"";
        }

        [self baseShareText:mermode.businessDesc withUrl:urlStr withContent:@"" withImageName:@"" ImgStr:imageUrl domainName:@"" withqqTitle:shareqq withqqZTitle:shareqqZ withweCTitle:shareWe withweChtTitle:shareWecht withsinaTitle:sharesina];
    }
}


//计算高度
-(CGFloat)getHeight:(NSString*)text{
    CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH-20, 0);
    if (![text isEqual:[NSNull null]]) {
        frame=[text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-20, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
        frame.size.height += 0.001;
    }
    return frame.size.height;
}



@end
