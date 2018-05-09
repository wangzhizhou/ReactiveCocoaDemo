//
//  FRPGalleryViewController.h
//  RACDemo
//
//  Created by joker on 2018/5/7.
//  Copyright © 2018年 joker. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FRPGalleryViewModel;
@interface FRPGalleryViewController : UICollectionViewController
@property (nonatomic, readonly)FRPGalleryViewModel *viewModel;
@end
