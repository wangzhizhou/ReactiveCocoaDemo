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
    RACReplaySubject *subject = [RACReplaySubject subject];
    NSURLRequest *request = [self popularURLRequest];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if(data) {
            id results = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSArray *photos = [[[results[@"photos"] rac_sequence] map:^id(NSDictionary * photoDictionary) {
                FRPPhotoModel *model = [FRPPhotoModel new];
                [self configurePhotoModel:model withDictionary:photoDictionary];
                [self downloadThumbnailForPhotoModel:model];
                return model;
            }] array];
            [subject sendNext:photos];
            [subject sendCompleted];
        } else {
            [subject sendError:connectionError];
        }
    }];
    return subject;
}

+ (NSURLRequest *)popularURLRequest {
    return [FRPAppDelegate.apiHelper urlRequestForPhotoFeature:PXAPIHelperPhotoFeaturePopular resultsPerPage:100 page:0 photoSizes:PXPhotoModelSizeThumbnail sortOrder:PXAPIHelperSortOrderRating except:PXPhotoModelCategoryNude];
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
    [self download:photoModel.thumbnailURL withCompletion:^(NSData *data) {
        photoModel.thumbnailData = data;
    }];
}
+ (void)downloadFullsizedImageForPhotoModel:(FRPPhotoModel *)photoModel {
    [self download:photoModel.fullsizedURL withCompletion:^(NSData *data) {
        photoModel.fullsizedData = data;
    }];
}

+ (void)download:(NSString *)urlString withCompletion:(void(^)(NSData *data))completion {
    
    NSAssert(urlString, @"url must not be nil");
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if(completion) completion(data);
    }];
}

+ (NSString *)urlForImageSize:(NSUInteger)size inArray:(NSArray *)array {
    return [[[[array.rac_sequence filter:^BOOL(NSDictionary *value) {
        return [value[@"size"] integerValue] == size;
    }] map:^id(NSDictionary *value) {
        return value[@"url"];
    }] array] firstObject];
}

+(RACReplaySubject *)fetchPhotoDetails:(FRPPhotoModel *)photoModel {
    
    RACReplaySubject *subject = [RACReplaySubject subject];
    
    NSURLRequest *request = [self photoURLRequest:photoModel];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if(data) {
            id results = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            [self configurePhotoModel:photoModel withDictionary:results[@"photo"]];
            [self downloadFullsizedImageForPhotoModel:photoModel];
            
            [subject sendNext:photoModel];
            [subject sendCompleted];
        } else {
            [subject sendError:connectionError];
        }
    }];
    
    return subject;
}


+(NSURLRequest *)photoURLRequest:(FRPPhotoModel *)photoModel {
    return [FRPAppDelegate.apiHelper urlRequestForPhotoID:[photoModel.identifier integerValue]];
}
@end
