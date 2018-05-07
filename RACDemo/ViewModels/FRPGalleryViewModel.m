//
//  FRPGalleryViewModel.m
//  RACDemo
//
//  Created by joker on 2018/5/7.
//  Copyright © 2018年 joker. All rights reserved.
//

#import "FRPGalleryViewModel.h"
#import "FRPPhotoImporter.h"

@interface FRPGalleryViewModel()

@end

@implementation FRPGalleryViewModel
-(instancetype)init {
    if(self = [super init]) {
        RAC(self, model) = [[[FRPPhotoImporter importPhotos] logError] catchTo:[RACSignal empty]];
    }
    return self;
}
@end
