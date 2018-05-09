//
//  FRPPhotoViewController.h
//  RACDemo
//
//  Created by joker on 2018/5/7.
//  Copyright © 2018年 joker. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FRPPhotoViewModel;
@interface FRPPhotoViewController : UIViewController
@property(nonatomic, readonly, strong)FRPPhotoViewModel *viewModel;
@property(nonatomic,readonly)NSInteger photoIndex;

-(instancetype)initWithPhotoViewModel:(FRPPhotoViewModel *)photoModel index:(NSUInteger)photoIndex;
@end
