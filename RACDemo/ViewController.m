//
//  ViewController.m
//  RACDemo
//
//  Created by joker on 2018/5/7.
//  Copyright © 2018年 joker. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self.textField.rac_textSignal subscribeNext:^(id x) {
//        NSLog(@"New value: %@", x);
//    } error:^(NSError *error) {
//        NSLog(@"Error: %@", error);
//    } completed:^{
//        NSLog(@"Completion!");
//    }];
    
    // Or
    
    [self.textField.rac_textSignal subscribeNext:^(id x) {
        NSLog(@"New value: %@", x);
    }];
    
    RACSignal *validEmail = [self.textField.rac_textSignal map:^id(NSString* value) {
        return @([value containsString:@"@"]);
    }];
    
//    RAC(self.button, enabled) = validEmail;
    self.button.rac_command = [[RACCommand alloc] initWithEnabled:validEmail signalBlock:^RACSignal *(id input) {
        NSLog(@"Button was pressed!");
        return [RACSignal empty];
    }];
    RAC(self.textField, textColor) = [validEmail map:^id(id value) {
        if([value boolValue]) {
            return UIColor.greenColor;
        } else {
            return UIColor.redColor;
        }
    }];
}

@end
