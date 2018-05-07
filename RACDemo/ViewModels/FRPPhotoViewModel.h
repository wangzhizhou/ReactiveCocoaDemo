//
//  FRPPhotoViewModel.h
//  RACDemo
//
//  Created by joker on 2018/5/7.
//  Copyright © 2018年 joker. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FRPPhotoModel;
@interface FRPPhotoViewModel : RVMViewModel

@property (nonatomic, readonly, strong)FRPPhotoModel *model;
@property (nonatomic, readonly, strong)UIImage *photoImage;
@property (nonatomic, readonly, assign)BOOL isLoading;

-(NSString *)photoName;
@end
