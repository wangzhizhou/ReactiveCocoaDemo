//
//  FRPFullSizePhotoViewModel.m
//  RACDemo
//
//  Created by joker on 2018/5/7.
//  Copyright © 2018年 joker. All rights reserved.
//

#import "FRPFullSizePhotoViewModel.h"
#import "FRPPhotoModel.h"

@interface FRPFullSizePhotoViewModel()
@property(nonatomic, strong)NSArray *model;
@property(nonatomic, assign)NSUInteger initialPhotoIndex;
@end

@implementation FRPFullSizePhotoViewModel

-(instancetype)initWithPhotoArray:(NSArray *)photoArray initialPhotoIndex:(NSInteger)initialPhotoIndex {
    
    if(self = [super init]) {
        self.model = photoArray;
        self.initialPhotoIndex = initialPhotoIndex;
    }
    return self;
}

-(FRPPhotoModel *)photoModelAtIndex:(NSInteger)index {
    if(index >= 0 && index < self.model.count) {
        return self.model[index];
    }
    return nil;
}
-(NSString *)initialPhotoName {
    FRPPhotoModel *photoModel = [self initialPhotoModel];
    return [photoModel photoName];
}

- (FRPPhotoModel *)initialPhotoModel {
    return [self photoModelAtIndex:self.initialPhotoIndex];
}
@end
