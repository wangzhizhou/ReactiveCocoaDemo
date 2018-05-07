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

@interface FRPFullSizePhotoViewController () <UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property(nonatomic,strong)NSArray  *photoModelArray;
@property(nonatomic,strong)UIPageViewController *pageViewController;

@end

@implementation FRPFullSizePhotoViewController
-(instancetype)initWithPhotoModels:(NSArray *)photoModelArray currentPhotoIndex:(NSUInteger)photoIndex {
    
    if(self = [super init]) {
        self.photoModelArray = photoModelArray;
        self.title = [self.photoModelArray[photoIndex] photoName];
        
        self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:@{UIPageViewControllerOptionInterPageSpacingKey:@(30)}];
        self.pageViewController.dataSource = self;
        self.pageViewController.delegate = self;
        
        [self addChildViewController:self.pageViewController];
        
        [self.pageViewController setViewControllers:@[[self photoViewControllerForIndex:photoIndex]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.blackColor;
    self.pageViewController.view.frame = self.view.bounds;
    [self.view addSubview:self.pageViewController.view];
}

- (FRPPhotoViewController *)photoViewControllerForIndex:(NSInteger)index {
    if(index >= 0 && index < self.photoModelArray.count) {
        FRPPhotoModel *photoModel = self.photoModelArray[index];
        
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
