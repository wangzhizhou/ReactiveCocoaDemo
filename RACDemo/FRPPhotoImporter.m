//
//  FRPPhotoImporter.m
//  RACDemo
//
//  Created by joker on 2018/5/7.
//  Copyright © 2018年 joker. All rights reserved.
//

#import "FRPPhotoImporter.h"
#import "FRPPhotoModel.h"

@implementation FRPPhotoImporter
+ (RACSignal *)importPhotos {
    
    NSURLRequest *request = [self popularURLRequest];
    
    return [[[[[[NSURLConnection rac_sendAsynchronousRequest:request] reduceEach:^id(NSURLResponse*response,NSData*data){
        return data;
    }] deliverOn:[RACScheduler mainThreadScheduler]] map:^id(NSData *data) {
        id results = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        return [[[results[@"photos"] rac_sequence] map:^id(NSDictionary * photoDictionary) {
            FRPPhotoModel *model = [FRPPhotoModel new];
            [self configurePhotoModel:model withDictionary:photoDictionary];
            [self downloadThumbnailForPhotoModel:model];
            return model;
        }] array];
    }] publish] autoconnect];
}

+ (NSURLRequest *)popularURLRequest {
    
    return [[PXRequest apiHelper] urlRequestForPhotoFeature:PXAPIHelperPhotoFeaturePopular resultsPerPage:100 page:0 photoSizes:PXPhotoModelSizeThumbnail sortOrder:PXAPIHelperSortOrderRating except:PXPhotoModelCategoryNude];
}

+ (void)configurePhotoModel:(FRPPhotoModel *)photoModel withDictionary:(NSDictionary *)dictionary {
    
    photoModel.photoName = dictionary[@"name"];
    photoModel.identifier = dictionary[@"id"];
    photoModel.photographerName = dictionary[@"user"][@"username"];
    photoModel.rating = dictionary[@"rating"];
    photoModel.thumbnailURL = [self urlForImageSize:3 inArray:dictionary[@"images"]];
    
    if(dictionary[@"comments_count"]) {
        photoModel.fullsizedURL = [self urlForImageSize:4 inArray:dictionary[@"images"]];
    }
}

+ (void)downloadThumbnailForPhotoModel:(FRPPhotoModel *)photoModel {
    RAC(photoModel,thumbnailData) = [self download:photoModel.thumbnailURL];
}
+ (void)downloadFullsizedImageForPhotoModel:(FRPPhotoModel *)photoModel {
    RAC(photoModel,fullsizedData) = [self download:photoModel.fullsizedURL];
}

+ (RACSignal *)download:(NSString *)urlString {
    
    NSAssert(urlString, @"url must not be nil");
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];

    return [[[NSURLConnection rac_sendAsynchronousRequest:request] map:^id(RACTuple *value) {
        return [value second];
    }] deliverOn: [RACScheduler mainThreadScheduler]];
}

+ (NSString *)urlForImageSize:(NSUInteger)size inArray:(NSArray *)array {
    return [[[[array.rac_sequence filter:^BOOL(NSDictionary *value) {
        return [value[@"size"] integerValue] == size;
    }] map:^id(NSDictionary *value) {
        return value[@"url"];
    }] array] firstObject];
}

+(RACSignal *)fetchPhotoDetails:(FRPPhotoModel *)photoModel {
    
    NSURLRequest *request = [self photoURLRequest:photoModel];
    return [[[[[[NSURLConnection rac_sendAsynchronousRequest:request] reduceEach:^id(NSURLResponse*response,NSData*data){
        return data;
    }] deliverOn:[RACScheduler mainThreadScheduler]] map:^id(NSData *data) {
        
        id results = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        [self configurePhotoModel:photoModel withDictionary:results[@"photo"]];
        [self downloadFullsizedImageForPhotoModel:photoModel];
        
        return photoModel;
    }] publish] autoconnect];
}


+(NSURLRequest *)photoURLRequest:(FRPPhotoModel *)photoModel {
    return [[PXRequest apiHelper] urlRequestForPhotoID:[photoModel.identifier integerValue]];
}
@end
