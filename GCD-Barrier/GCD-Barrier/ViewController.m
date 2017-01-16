//
//  ViewController.m
//  GCD-Barrier
//
//  Created by lirenqiang on 2016/12/29.
//  Copyright © 2016年 Ninja. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touches Began");
    
    [self barrier];
}

- (void)barrier
{
    dispatch_queue_t queue = dispatch_queue_create("com.example.gcd.for", DISPATCH_QUEUE_CONCURRENT);
    NSMutableArray *arr = @[].mutableCopy;
    [arr addObject:@(1)];
    dispatch_async(queue, ^{
        NSLog(@"bl1 arr: %@", arr);
    });
    dispatch_async(queue, ^{
        NSLog(@"bl2 arr: %@", arr);
    });
   
    dispatch_barrier_async(queue, ^{
        [arr addObject:@(0)];
        [NSThread sleepForTimeInterval:2.0];
        [arr addObject:@(7)];
        NSLog(@"finished: %@", arr);
    });

    dispatch_async(queue, ^{
        NSLog(@"bl4 arr: %@", arr);
    });
    dispatch_async(queue, ^{
        NSLog(@"bl5 arr: %@", arr);
    });
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2.5];
        NSLog(@"bl6 arr: %@", arr);
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

//dispatch_async(queue, ^{
//    [arr addObject:@(0)];
//    [NSThread sleepForTimeInterval:2.0];
//    [arr addObject:@(7)];
//    NSLog(@"finished: %@", arr);
//});























