//
//  FRPCell.m
//  RACDemo
//
//  Created by joker on 2018/5/7.
//  Copyright © 2018年 joker. All rights reserved.
//

#import "FRPCell.h"
#import "FRPPhotoModel.h"

@interface FRPCell()
@property(nonatomic,weak)UIImageView*imageView;
@property(nonatomic,strong)RACDisposable*subscription;
@end

@implementation FRPCell

-(instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = UIColor.darkGrayColor;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:imageView];
        self.imageView = imageView;
        
        RAC(self.imageView, image) = [[RACObserve(self, photoModel.thumbnailData) ignore:nil] map:^id(id value) {
            return [UIImage imageWithData: value];
        }];
    }
    return self;
}
@end
