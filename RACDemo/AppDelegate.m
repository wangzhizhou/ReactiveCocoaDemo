//
//  AppDelegate.m
//  RACDemo
//
//  Created by joker on 2018/5/7.
//  Copyright © 2018年 joker. All rights reserved.
//

#import "AppDelegate.h"
#import <RXCollections/RXCollection.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self mapDemo];
    [self filterDemo];
    [self foldDemo];
    return YES;
}

- (void)mapDemo {
    NSArray *array = @[@(1), @(2), @(3)];
    NSArray *mappedArray = [array rx_mapWithBlock:^id(id each) {
        return @(pow([each integerValue],2));
    }];
    NSLog(@"Origin Array: %@",array);
    NSLog(@"Mapped Array: %@",mappedArray);
}

- (void)filterDemo {
    NSArray *array = @[@(1), @(2), @(3)];
    NSArray *filteredArray = [array rx_filterWithBlock:^BOOL(id each) {
        return [each integerValue] % 2 == 0;
    }];
    NSLog(@"Origin Array: %@",array);
    NSLog(@"Filtered Array: %@",filteredArray);
}

- (void)foldDemo {
    NSArray *array = @[@(1), @(2), @(3)];
    NSArray *foldArray = [array rx_foldWithBlock:^id(id memo, id each) {
        return @([memo integerValue] + [each integerValue]);
    }];
    NSLog(@"Origin Array: %@",array);
    NSLog(@"folded Array: %@",foldArray);
}
@end
