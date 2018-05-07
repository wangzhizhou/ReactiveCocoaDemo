//
//  FRPPhotoViewModel.m
//  RACDemo
//
//  Created by joker on 2018/5/7.
//  Copyright © 2018年 joker. All rights reserved.
//

#import "FRPPhotoViewModel.h"
#import <UIKit/UIKit.h>
#import "FRPPhotoImporter.h"
#import "FRPPhotoModel.h"

@interface FRPPhotoViewModel()
@property (nonatomic, strong)UIImage *photoImage;
@property (nonatomic, assign)BOOL isLoading;
@end

@implementation FRPPhotoViewModel
@dynamic model;

- (instancetype)initWithModel:(FRPPhotoModel *)model {
    if(self = [super initWithModel:model]) {
        @weakify(self);
        [self.didBecomeActiveSignal subscribeNext:^(id x) {
            @strongify(self);
            self.isLoading = YES;
            [[FRPPhotoImporter fetchPhotoDetails:self.model] subscribeError:^(NSError *error) {
                NSLog(@"Could not fetch photo details: %@", error);
            } completed:^{
                self.isLoading = NO;
                NSLog(@"Fetched photo details.");
            }];
        }];
        
        RAC(self, photoImage) = [RACObserve(self.model, fullsizedData) map:^id(id value) {
            return [UIImage imageWithData:value];
        }];
    }
    return self;
}

-(NSString *)photoName {
    return self.model.photoName;
}
@end
