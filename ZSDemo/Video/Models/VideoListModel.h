//
//  VideoListModel.h
//  ZSDemo
//
//  Created by abnerzhang on 2016/11/21.
//  Copyright © 2016年 abnerzhang. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface VideoListModel : JSONModel


@property (nonatomic, strong)NSString<Optional> *cover;
@property (nonatomic, strong)NSString<Optional> *descriptionDe;
@property (nonatomic, strong)NSString<Optional> *length;
@property (nonatomic, strong)NSString<Optional> *m3u8Hd_url;
@property (nonatomic, strong)NSString<Optional> *m3u8_url;
@property (nonatomic, strong)NSString<Optional> *mp4Hd_url;
@property (nonatomic, strong)NSString<Optional> *mp4_url;

@property (nonatomic, assign)NSInteger playCount;
@property (nonatomic, strong)NSString<Optional> *playersize;
@property (nonatomic, strong)NSString<Optional> *ptime;
@property (nonatomic, strong)NSString<Optional> *replyBoard;
@property (nonatomic, strong)NSString<Optional> *replyid;
@property (nonatomic, strong)NSString<Optional> *sectiontitle;
@property (nonatomic, strong)NSString<Optional> *title;

@property (nonatomic, strong)NSString<Optional> *topicDesc;
@property (nonatomic, strong)NSString<Optional> *topicImg;
@property (nonatomic, strong)NSString<Optional> *topicName;
@property (nonatomic, strong)NSString<Optional> *topicSid;
@property (nonatomic, strong)NSString<Optional> *videosource;

@property (nonatomic, strong)NSNumber<Optional> *descriptionHeight;
@end
