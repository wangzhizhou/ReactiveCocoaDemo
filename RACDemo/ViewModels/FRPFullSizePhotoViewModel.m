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
@property(nonatomic, assign)NSUInteger initialPhotoIndex;
@end

@implementation FRPFullSizePhotoViewModel

@dynamic model;

-(instancetype)initWithPhotoArray:(NSArray *)photoArray initialPhotoIndex:(NSInteger)initialPhotoIndex {
    
    if(self = [super initWithModel:photoArray]) {
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
    return [self.model[self.initialPhotoIndex] photoName];
}
@end
