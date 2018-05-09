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

@property (nonatomic, strong)FRPPhotoModel *model;
@property (nonatomic, strong)UIImage *photoImage;
@property (nonatomic, assign)BOOL isLoading;
@end

@implementation FRPPhotoViewModel

- (instancetype)initWithModel:(FRPPhotoModel *)model {
    
    if(self = [super init]) {
        self.model = model;
        
        @weakify(self);
        RAC(self, photoImage) = [RACObserve(self.model, fullsizedData) map:^id(id value) {
            return [UIImage imageWithData:value];
        }];
        
        [self.didBecomeActiveSignal subscribeNext:^(id x) {
            @strongify(self);
            [self downloadPhotoModelDetails];
        }];
    }
    return self;
}

-(void)downloadPhotoModelDetails {
    self.isLoading = YES;
    [[FRPPhotoImporter fetchPhotoDetails:self.model] subscribeError:^(NSError *error) {
        NSLog(@"Could not fetch photo details: %@", error);
    } completed:^{
        self.isLoading = NO;
        NSLog(@"Fetched photo details.");
    }];
}

-(NSString *)photoName {
    return self.model.photoName;
}
@end
