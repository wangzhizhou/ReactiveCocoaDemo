//
//  FRPFullSizePhotoViewController.m
//  RACDemo
//
//  Created by joker on 2018/5/7.
//  Copyright © 2018年 joker. All rights reserved.
//

#import "FRPFullSizePhotoViewController.h"
#import "FRPPhotoModel.h"
#import "FRPPhotoViewController.h"
#import "FRPFullSizePhotoViewModel.h"

@interface FRPFullSizePhotoViewController () <UIPageViewControllerDelegate, UIPageViewControllerDataSource>
@property(nonatomic,strong)UIPageViewController *pageViewController;

@end

@implementation FRPFullSizePhotoViewController
-(instancetype)init {
    
    if(self = [super init]) {
        self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:@{UIPageViewControllerOptionInterPageSpacingKey:@(30)}];
        self.pageViewController.dataSource = self;
        self.pageViewController.delegate = self;
        
        [self addChildViewController:self.pageViewController];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.blackColor;
    self.pageViewController.view.frame = self.view.bounds;
    [self.pageViewController setViewControllers:@[[self photoViewControllerForIndex:self.viewModel.initialPhotoIndex]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    [self.view addSubview:self.pageViewController.view];
    self.title = self.viewModel.initialPhotoName;
}

- (FRPPhotoViewController *)photoViewControllerForIndex:(NSInteger)index {
    if(index >= 0 && index < self.viewModel.model.count) {
        FRPPhotoModel *photoModel = self.viewModel.model[index];
        
        FRPPhotoViewController *photoViewController = [[FRPPhotoViewController alloc] initWithPhotoModel:photoModel index:index];
        return photoViewController;
    }
    return nil;
}

#pragma mark <UIPageViewControllerDelegate>
-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    
    self.title = [[pageViewController.viewControllers.firstObject photoModel] photoName];
    [self.delegate userDidScroll:self toPhotoAtIndex:[pageViewController.viewControllers.firstObject photoIndex]];
}
#pragma mark <UIPageViewControllerDataSource>

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(FRPPhotoViewController *)viewController {
    return [self photoViewControllerForIndex:viewController.photoIndex - 1];
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(FRPPhotoViewController *)viewController {
    return [self photoViewControllerForIndex:viewController.photoIndex + 1];
}
@end
