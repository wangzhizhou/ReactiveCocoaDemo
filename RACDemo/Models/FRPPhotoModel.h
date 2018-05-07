//
//  FRPPhotoModel.h
//  RACDemo
//
//  Created by joker on 2018/5/7.
//  Copyright © 2018年 joker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FRPPhotoModel : NSObject
@property(nonatomic,strong)NSString *photoName;
@property(nonatomic,strong)NSNumber *identifier;
@property(nonatomic,strong)NSString *photographerName;
@property(nonatomic,strong)NSNumber *rating;
@property(nonatomic,strong)NSString *thumbnailURL;
@property(nonatomic,strong)NSData   *thumbnailData;
@property(nonatomic,strong)NSString *fullsizedURL;
@property(nonatomic,strong)NSData   *fullsizedData;
@end
