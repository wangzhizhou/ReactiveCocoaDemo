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
    
    it(@"should return nil for an out-of-bounds photo index", ^{
        NSArray *model = @[[NSObject new]];
        NSInteger initialPhotoIndex = 1337;
        
        FRPFullSizePhotoViewModel *viewModel = [[FRPFullSizePhotoViewModel alloc] initWithPhotoArray:model initialPhotoIndex:initialPhotoIndex];
        
        id subzeroModel = [viewModel photoModelAtIndex:-1];
        expect(subzeroModel).to.beNil();
        
        id aboveBoundsModel = [viewModel photoModelAtIndex:model.count];
        expect(aboveBoundsModel).to.beNil();
    });
    
    it(@"should return the correct model for photo Model At Index:", ^{
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
        
        // mock对象方式，预估会以initialPhotoIndex参数调用photoModelAtIndex:方法，并且返回model[0]
        // 在[mockViewModel verify]中验证
        [[[mockViewModel expect] andReturn:model[0]] photoModelAtIndex:initialPhotoIndex];
        
        // 测试动作
        id returnedObject = [mockViewModel initialPhotoModel];
        // 使用expect方法验证
        expect(returnedObject).to.equal(model[0]);
        
        // 使用mock对象的方式进行验证
        [mockViewModel verify];
    });
});

SpecEnd
