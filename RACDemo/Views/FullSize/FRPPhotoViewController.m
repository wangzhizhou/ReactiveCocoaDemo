//
//  FRPPhotoViewController.m
//  RACDemo
//
//  Created by joker on 2018/5/7.
//  Copyright © 2018年 joker. All rights reserved.
//

#import "FRPPhotoViewController.h"
#import "FRPPhotoImporter.h"
#import "FRPPhotoViewModel.h"

@interface FRPPhotoViewController ()
@property(nonatomic,strong)FRPPhotoViewModel *viewModel;
@property(nonatomic,assign)NSInteger photoIndex;
@property(nonatomic,weak)UIImageView *imageView;
@end

@implementation FRPPhotoViewController

-(instancetype)initWithPhotoViewModel:(FRPPhotoViewModel *)photoViewModel index:(NSUInteger)photoIndex {
    if(self = [super init]) {
        self.viewModel = photoViewModel;
        self.photoIndex = photoIndex;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.blackColor;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    RAC(imageView, image) = RACObserve(self.viewModel, photoImage);
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageView];
    self.imageView = imageView;
                             
    [RACObserve(self.viewModel,isLoading) subscribeNext:^(NSNumber *loading) {
        if(loading.boolValue) {
            [SVProgressHUD show];
        } else {
            [SVProgressHUD dismiss];
        }
    }];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.viewModel.active = YES;
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    self.viewModel.active = NO;
}

@end
