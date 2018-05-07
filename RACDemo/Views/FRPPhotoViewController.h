//
//  FRPPhotoViewController.h
//  RACDemo
//
//  Created by joker on 2018/5/7.
//  Copyright © 2018年 joker. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FRPPhotoModel;
@interface FRPPhotoViewController : UIViewController

@property(nonatomic,readonly)NSInteger photoIndex;
@property(nonatomic,readonly)FRPPhotoModel *photoModel;

-(instancetype)initWithPhotoModel:(FRPPhotoModel *)photoModel index:(NSUInteger)photoIndex;
@end
