//
//  FRPFullSizePhotoViewController.h
//  RACDemo
//
//  Created by joker on 2018/5/7.
//  Copyright © 2018年 joker. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FRPFullSizePhotoViewController;
@class FRPFullSizePhotoViewModel;
@protocol FRPFullSizePhotoViewControllerDelegate<NSObject>
-(void)userDidScroll:(FRPFullSizePhotoViewController*)viewController toPhotoAtIndex:(NSInteger)index;
@end

@interface FRPFullSizePhotoViewController : UIViewController
@property (nonatomic, weak)id<FRPFullSizePhotoViewControllerDelegate> delegate;
@property(nonatomic,strong)FRPFullSizePhotoViewModel *viewModel;
@end
