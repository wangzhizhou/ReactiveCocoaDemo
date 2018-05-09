//
//  FRPFullSizePhotoViewModel.h
//  RACDemo
//
//  Created by joker on 2018/5/7.
//  Copyright © 2018年 joker. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FRPPhotoModel;

@interface FRPFullSizePhotoViewModel : RVMViewModel

@property(nonatomic, readonly, strong)NSArray *model;
@property(nonatomic, readonly)NSUInteger initialPhotoIndex;
@property(nonatomic, readonly)NSString *initialPhotoName;

-(instancetype)initWithPhotoArray:(NSArray*)photoArray initialPhotoIndex:(NSInteger)initialPhotoIndex;

-(FRPPhotoModel*)photoModelAtIndex:(NSInteger)index;
@end
