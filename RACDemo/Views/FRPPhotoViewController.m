//
//  FRPPhotoViewController.m
//  RACDemo
//
//  Created by joker on 2018/5/7.
//  Copyright © 2018年 joker. All rights reserved.
//

#import "FRPPhotoViewController.h"
#import "FRPPhotoModel.h"
#import "FRPPhotoImporter.h"

@interface FRPPhotoViewController ()
@property(nonatomic,assign)NSInteger photoIndex;
@property(nonatomic,strong)FRPPhotoModel *photoModel;
@property(nonatomic,weak)UIImageView *imageView;
@end

@implementation FRPPhotoViewController

-(instancetype)initWithPhotoModel:(FRPPhotoModel *)photoModel index:(NSUInteger)photoIndex {
    if(self = [super init]) {
        self.photoModel = photoModel;
        self.photoIndex = photoIndex;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.blackColor;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    RAC(imageView, image) = [RACObserve(self.photoModel, fullsizedData) map:^id(id value) {
        return [UIImage imageWithData:value];
    }];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageView];
    self.imageView = imageView;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [SVProgressHUD show];
    
    [[FRPPhotoImporter fetchPhotoDetails:self.photoModel] subscribeError:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"Error"];
    } completed:^{
        [SVProgressHUD dismiss];
    }];
}

@end
