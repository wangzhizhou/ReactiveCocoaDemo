//
//  FRPGalleryViewController.m
//  RACDemo
//
//  Created by joker on 2018/5/7.
//  Copyright © 2018年 joker. All rights reserved.
//

#import "FRPGalleryViewController.h"
#import "FRPGalleryFlowLayout.h"
#import "FRPCell.h"
#import "FRPPhotoImporter.h"
#import "FRPFullSizePhotoViewController.h"

@interface FRPGalleryViewController () <FRPFullSizePhotoViewControllerDelegate>
@property (nonatomic, strong)NSArray *photosArray;
@end

@implementation FRPGalleryViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[FRPCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    self.title = @"Popular on 500px";
    
    FRPGalleryFlowLayout *flowLayout = [[FRPGalleryFlowLayout alloc] init];
    self.collectionView.collectionViewLayout = flowLayout;
    
    @weakify(self);
    [RACObserve(self, photosArray) subscribeNext:^(id x) {
        @strongify(self);
        [self.collectionView reloadData];
    }];
    [self loadPopularPhotos];
}

- (void)loadPopularPhotos {
    [[FRPPhotoImporter importPhotos] subscribeNext:^(id x) {
        self.photosArray = x;
    } error:^(NSError *error) {
        NSLog(@"Couldn't fetch photos from 500px: %@", error);
    }];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photosArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FRPCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    [cell setPhotoModel:self.photosArray[indexPath.item]];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FRPFullSizePhotoViewController *viewController = [[FRPFullSizePhotoViewController alloc] initWithPhotoModels:self.photosArray currentPhotoIndex:indexPath.item];
    viewController.delegate = self;
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark <FRPFullSizePhotoViewControllerDelegate>
-(void)userDidScroll:(FRPFullSizePhotoViewController *)viewController toPhotoAtIndex:(NSInteger)index {
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
}
@end
