//
//  FRPPhotoModel.h
//  RACDemo
//
//  Created by joker on 2018/5/7.
//  Copyright © 2018年 joker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FRPPhotoModel : NSObject
@property(nonatomic,strong)NSString *photoName;             //图片名称
@property(nonatomic,strong)NSNumber *identifier;            //图片id
@property(nonatomic,strong)NSString *photographerName;      //图片作者
@property(nonatomic,strong)NSNumber *rating;                //图片排名
@property(nonatomic,strong)NSString *thumbnailURL;          //图片缩略图拉取地址
@property(nonatomic,strong)NSData   *thumbnailData;         //图片缩略图数据
@property(nonatomic,strong)NSString *fullsizedURL;          //图片原图拉取地址
@property(nonatomic,strong)NSData   *fullsizedData;         //图片原图数据
@end
