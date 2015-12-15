//
//  Header.h
//  ILoveTheInvention
//
//  Created by sinoMacMini on 13-12-10.
//  Copyright (c) 2013年 qiaohongchao. All rights reserved.
//

#ifndef ILoveTheInvention_Header_h
#define ILoveTheInvention_Header_h



#define LEFT_BUTTON_FRAM CGRectMake(10, 12.5, 12.5, 19)
#define RIGHT_BUTTON_FRAM CGRectMake(290, 12, 13.5, 20)
#define GRAY_BG_COLOR [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1.0];
#define IOS7 [[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0









#define GETYEARS [NSString stringWithFormat:@"%@video/getYears/",ANALYSISS]
/*获取年份
 {
 “imei”:”1”,   // 手机串号
 “version”:”1.0”,   // 版本名称
 }
 ================================
 */







#define VIDEO_LIST_URL [NSString stringWithFormat:@"%@init/getVideoList/",ANALYSISS]
 /*
 {
 “imei”:”1”,   // 手机串号
 “userId”:”1”,   //uid
 “videoId”:”“,   //视频ID
 }
 
*/
#define VIDEO_DETAIL_URL [NSString stringWithFormat:@"%@video/getVideoDetail/",ANALYSISS]
//“imei”:”1”,   // 手机串号
//“userId”:”1”,   //uid
//“videoId”:”“,   //视频ID

#define GET_INVENTION_COUNT [NSString stringWithFormat:@"%@miss/ getInventionCount/",ANALYSISS]
 /*
 
 {
 “imei”:”1”,   // 手机串号
 “userId”:”1”,   //uid
 }
 */
#define OLD_VIDEO_LIST [NSString stringWithFormat:@"%@video/getOldVideoList/",ANALYSISS]


//“imei”:”1”,   // 手机串号
//“userId”:”1”,   //uid
//“year”:”“,   //年份

 /*
 
 “imei”:”1”,   // 手机串号
 “userId”:”1”,   //uid
 “inventionId”:”123”,   //被寻人Id
 “threadId”:”123”,   //线索Id    //二者有一个不为空
 */

#define GET_INVENTION_DETAIL    [NSString stringWithFormat:@"%@miss/getInventionDetail/",ANALYSISS]

//#define GET_INVENTION_DETAIL @"118.145.23.220:8281/WM/inventionLib/inventionLib_getInventionDetail.action"
/*
 “imei”:”1”,   // 手机串号
 “userId”:”1”,   //uid
 “inventionId”:”123”,   //发明Id
 */

#define GET_INVENTIONLIST    [NSString stringWithFormat:@"%@miss/getInventionList/",ANALYSISS]


 /*
 
 “imei”:”1”,   // 手机串号
 “userId”:”1”,   //uid
 “type”:”1”,   //1生活，2交通，（顺序）
 
 */

#define GET_REMARKLIST [NSString stringWithFormat:@"%@userreviewinfo/getReviewALL/",ANALYSISS]
 
 /*
 获取评论列表
 “imei”:”1”,   // 手机串号
 “userId”:”1”,   //uid
 “commentId”:”11”,   //回复ID不为空则查询回复列表
 “type”:”1”,   //0评论话题，1评论视频，2发明列表
 “videoId”:”11”,   //视频ID
 “inventionId”:”123”,   //发明Id
 “topicId”:”123”,   //话题Id
 “key”:”0”,   //0最新，1最热，2推荐
 “page”:”1”,   //页数
 }
 
 */

#define INIT_REQUEST [NSString stringWithFormat:@"%@funcimage/funcImage_getInit.action",ANALYSISS]/*
/*初始化接口
 {
 “imei”:”1”,   // 手机串号
 “version”:”1.0”,   // 版本名称
 }
 
 */
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)




#define ADD_REMARK [NSString stringWithFormat:@"%@userreviewinfo/insert/",ANALYSISS]/*
 “imei”:”1”,   // 手机串号
 “userId”:”1”,   //uid
 “commentId”:”11”,   //回复ID
 “content”:”11111111”,   //评论内容
 “type”:”1”,   //0评论话题，1评论视频，2发明
 “videoId”:”11”,   //视频ID若是话题为null
 “inventionId”:”123”,   //发明Id
 “topicId”:”123”,   //话题Id
 “createDate”:”2013-12-12 12:12:12”,   //创建时间
 */





 #define DO_APPOINTMENT [NSString stringWithFormat:@"%@personCenter/personCenter_doAppointment.action",ANALYSISS]/*
/*添加预约
 “imei”:”1”,   // 手机串号
 “userId”:”1”,   //uid
 “videoId”:”1”,   //视频ID
 */



#define GET_INVENTIONCOUNT [NSString stringWithFormat:@"%@miss/getInventionCount/",ANALYSISS]

 /*获取寻人信息、线索数量

 
 {
 “imei”:”1”,   // 手机串号
 “userId”:”1”,   //uid
 }
 */



#define GET_DIRECTOR_RECORD [NSString stringWithFormat:@"%@video/getDirector/",ANALYSISS]
/*
 编导手记
 
 {
 “imei”:”1”,   // 手机串号
 “userId”:”1”,   //uid
 “videoId”:”“,   //视频ID
 }
 
 */


//#define  APPKEY @"5333c65a56240bb888002cf4"
//#define APPKEY @"532ffb8456240bfa61003192"
//#define  APPID_STRING       @"52c0d040"


#endif
