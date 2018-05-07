//
//  FRPFullSizePhotoViewModelTests.m
//  RACDemoTests
//
//  Created by joker on 2018/5/7.
//  Copyright © 2018年 joker. All rights reserved.
//

#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import <ReactiveViewModel/ReactiveViewModel.h>
#import "FRPPhotoModel.h"
#import "FRPFullSizePhotoViewModel.h"


@interface FRPFullSizePhotoViewModel()
-(FRPPhotoModel*)initialPhotoModel;
@end


SpecBegin(FRPFullSizePhotoViewModel)

describe(@"FRPFullSizePhotoModel", ^{
    it(@"should assign correct attributes when initialized", ^{
       
        NSArray *model = @[];
        NSInteger initialPhotoIndex = 1337;
        
        FRPFullSizePhotoViewModel *viewModel = [[FRPFullSizePhotoViewModel alloc] initWithPhotoArray:model initialPhotoIndex:initialPhotoIndex];
        
        expect(model).to.equal(viewModel.model);
        expect(initialPhotoIndex).to.equal(viewModel.initialPhotoIndex);
        
    });
    
    it(@"shouldreturnnilforanout-of-boundsphotoindex", ^{
        NSArray *model = @[[NSObject new]];
        NSInteger initialPhotoIndex = 1337;
        
        FRPFullSizePhotoViewModel *viewModel = [[FRPFullSizePhotoViewModel alloc] initWithPhotoArray:model initialPhotoIndex:initialPhotoIndex];
        
        id subzeroModel = [viewModel photoModelAtIndex:-1];
        expect(subzeroModel).to.beNil();
        
        id aboveBoundsModel = [viewModel photoModelAtIndex:model.count];
        expect(aboveBoundsModel).to.beNil();
    });
    
    it(@"shouldreturnthecorrectmodelforphotoModelAtIndex:", ^{
        id photoModel = [NSObject new];
        NSArray *model = @[photoModel];
        NSInteger initialPhotoIndex = 1337;
        
        FRPFullSizePhotoViewModel *viewModel = [[FRPFullSizePhotoViewModel alloc] initWithPhotoArray:model initialPhotoIndex:initialPhotoIndex];
        
        id returnedModel = [viewModel photoModelAtIndex:0];
        expect(returnedModel).to.equal(photoModel);
        
    });
    
    it(@"should return the correct initial photo model", ^{
        NSArray *model = @[[NSObject new]];
        NSInteger initialPhotoIndex = 0;
        
        FRPFullSizePhotoViewModel *viewModel = [[FRPFullSizePhotoViewModel alloc] initWithPhotoArray:model initialPhotoIndex:initialPhotoIndex];
        
        id mockViewModel = [OCMockObject partialMockForObject:viewModel];
        [[[mockViewModel expect] andReturn:model[0]] photoModelAtIndex:initialPhotoIndex];
        
        id returnedObject = [mockViewModel initialPhotoModel];
        expect(returnedObject).to.equal(model[0]);
        [mockViewModel verify];
    });
});

SpecEnd
