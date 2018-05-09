//
//  FRPPhotoImporter.h
//  RACDemo
//
//  Created by joker on 2018/5/7.
//  Copyright © 2018年 joker. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FRPPhotoModel;
@interface FRPPhotoImporter : NSObject


/**
 获取图片缩略图信号

 @return 缩略图数据拉取信号
 */
+(RACSignal *)importPhotos;


/**
 获取原图片信号

 @param photoModel 具体图片的信息
 @return 原图数据拉取信号
 */
+(RACSignal *)fetchPhotoDetails:(FRPPhotoModel *)photoModel;

@end
