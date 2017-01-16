//
//  ViewController.m
//  GCD-Apply
//
//  Created by lirenqiang on 2016/12/30.
//  Copyright © 2016年 Ninja. All rights reserved.
//
/*
    文档说的已经很好了,不过有一点我需要补充的就是,queue不能为mainQueue.
 */

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_queue_t serialQueue = dispatch_queue_create("serialQueue", DISPATCH_QUEUE_SERIAL);
    /*
        void dispatch_apply( size_t iterations, dispatch_queue_t queue, void (^block)( size_t));
     iterations | The number of iterations to perform.
     queue      | The queue on which to submit the block. This parameter cannot be NULL.
     block      | The application-defined function to be submitted. This parameter cannot be NULL.
     
     
     */
    dispatch_apply(10000, globalQueue, ^(size_t i) {
        NSLog(@"i: %zd thread: %@", i, [NSThread currentThread]);
    });
    
    NSLog(@"finished");
    /*
     discussion:
     This function submits a block to a dispatch queue for multiple invocations and waits for all iterations of the task block to complete before returning. If the target queue is a concurrent queue returned by dispatch_get_global_queue, the block can be invoked concurrently, and it must therefore be reentrant-safe. Using this function with a concurrent queue can be useful as an efficient parallel for loop.
     
     The current index of iteration is passed to each invocation of the block.
     */
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
