//
//  DHHomePageTool.h
//  MarketManage
//
//  Created by 许文波 on 15/7/16.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Home.h"
@interface DHHomePageTool : NSObject




-(UILabel *)set_Labelframe:(CGRect )frame  Label_text:(NSString *)Text Label_Font:(CGFloat)m_Font;

-(UIImageView *)set_imgframe:(CGRect)frame imgBack:(NSString *)img;

-(UIButton *)set_ButtonFrame:(CGRect)frame  andImg:(NSString *)img ButtonTag:(int)tag;





@end
