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
+(RACSignal *)importPhotos;

+(RACReplaySubject *)fetchPhotoDetails:(FRPPhotoModel *)photoModel;
@end
