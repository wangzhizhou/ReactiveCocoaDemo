//
//  FRPPhotoViewModelTests.m
//  RACDemoTests
//
//  Created by joker on 2018/5/8.
//  Copyright © 2018年 joker. All rights reserved.
//

#import <Specta.h>

#define EXP_SHORTHAND
#import <Expecta.h>

#import <OCMock.h>
#import <ReactiveViewModel.h>

#import "FRPPhotoModel.h"
#import "FRPPhotoViewModel.h"


// 因为downloadPhotoModelDetails方法是私有方法，所以这里显式声明一次就可以在本文件中调用了
@interface FRPPhotoViewModel()
-(void)downloadPhotoModelDetails;
@end


//
SpecBegin(FRPPhotoViewModel)

describe(@"FRPPhotoViewModel", ^{
    
    it(@"should return the photo's name property when photoName is invoked", ^{
        
//         -(NSString *)photoName {
//            return self.model.photoName;
//         }
       
        // 针对方法中的self.model创建的mock对象，mock对象的photoName返回指定name值"joker"
        NSString *name = @"joker";
        // 对类型Mock后，要显示声明停止Mock，防止影响其它测试用例
        id mockPhotoModel = [OCMockObject mockForClass:[FRPPhotoModel class]];
        [[[mockPhotoModel stub] andReturn:name] photoName];
        
        // 创建一个实际的viewModel对象
        FRPPhotoViewModel *viewModel = [[FRPPhotoViewModel alloc] initWithModel:nil];
        
        // 对实际viewModel对象局部进行修改，把viewModel的model成员替换成上一步创建的mock对象mockPhotoModel
        id mockViewModel = [OCMockObject partialMockForObject:viewModel];
        [[[mockViewModel stub] andReturn:mockPhotoModel] model];
        
        // 调用viewModel的photoName方法返回值
        id returnedName = [mockViewModel photoName];
        
        // 比较返回值和预设值是否相同，从而判断测试用例是否成功
        expect(returnedName).to.equal(name);
        
        // 取消对FRPPhotoModel类的Mock，防止影响其它测试
        [mockPhotoModel stopMocking];
    });
    
    it(@"should download photo model details when it becomes active", ^{
        
        FRPPhotoViewModel *viewModel = [[FRPPhotoViewModel alloc] initWithModel:nil];
        
        id mockViewModel = [OCMockObject partialMockForObject:viewModel];
        
        // 预估downloadPhotoModelDetails方法会在测试的过程中被调用
        [[mockViewModel expect] downloadPhotoModelDetails];
        
        // 测试的动作
        [mockViewModel setActive:YES];
        
        // 对预估进行验证
        [mockViewModel verify];
    });
    
    it(@"should correctly map image data to UIImage", ^{
        
        UIImage *image = [[UIImage alloc] init];
        NSData *imageData = [NSData data];
        
        id mockImage = [OCMockObject mockForClass:[UIImage class]];
        [[[mockImage stub] andReturn:image] imageWithData:imageData];
        
        FRPPhotoModel *photoModel = [[FRPPhotoModel alloc] init];
        photoModel.fullsizedData = imageData;
        
        __unused FRPPhotoViewModel *viewModel =
        [[FRPPhotoViewModel alloc] initWithModel:photoModel];
        
        [mockImage verify];
        
        [mockImage stopMocking];
    });
});

SpecEnd
