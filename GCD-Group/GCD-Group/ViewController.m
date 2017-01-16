//
//  ViewController.m
//  GCD-Group
//
//  Created by lirenqiang on 2016/12/28.
//  Copyright © 2016年 Ninja. All rights reserved.
//
/*
 * dispatch_group 的使用.
 */

#import "ViewController.h"

@interface ViewController ()
{
    //声明一个组变量
    dispatch_group_t _group;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建组对象,虽然有用到create,但是不用手动release.
    _group = dispatch_group_create();
    
    //声明下面的第一个方法要加入到组当中.
    dispatch_group_enter(_group);
    [self requestNews:^(id posts) {
        // code
    }];
    //同上
    dispatch_group_enter(_group);
    [self requestWethear:^(id posts) {
       // code
    }];
    //group里面的所有任务完成后的回调.
    //这个回调对于代码的位置没有固定的要求,放在_group创建的下面也行.
    dispatch_group_notify(_group, dispatch_get_main_queue(), ^{
        NSLog(@"group notify");
    });
    
}
// 下面这段代码,是在子线程中执行的任务.
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//
//        [self requestNews:^(id posts) {
//            // code
//        }];
//    });
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touches Began");
    testGroup();
    
}

void test(NSString *str)
{
    NSLog(@"%@", str);
}

void testGroup()
{
    
    //创建一个group,这里虽然用了create,但是GCD兼容ARC和MRC
    //所以我们这里不需要dispatch_release()
    dispatch_group_t group = dispatch_group_create();
    //这里我们获取一个全局队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //第一个参数是上面创建的组,第二个参数是异步任务要加入的队列,第三个参数就是block,代码块,要执行的代码.
    dispatch_group_async(group, queue, ^(){NSLog(@"block01");});
    dispatch_group_async(group, queue, ^(){NSLog(@"block02");});
    dispatch_group_async(group, queue, ^(){NSLog(@"block03");});    
    /**
     dispatch_group_notify
     @discussion 意思是,监听第一个参数group,如果该group里面的任务全部都完成后,就会调用该方法,在queue中,执行block.
     @param group                   要监听的组
     @param queue 当组结束时,将会把block里的任务提交到该queue中执行,这个参数不能为空.

     @return void
     */
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"block done");
    });
}

void testGroup1()
{
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_async(group, queue, ^(){NSLog(@"block01");});
    dispatch_group_async(group, queue, ^(){NSLog(@"block02");});
    dispatch_group_async(group, queue, ^(){
        for (NSInteger i = 0; i < 10000; ++i) {
            NSLog(@"block03: %zd", i);
        }
    });
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 1ull * NSEC_PER_SEC);
    long result = dispatch_group_wait(group, time); //0表示group全部任务处理接结束,非0表示超时.
    //一旦调用了dispatch_group_wait,那么
//    long result = dispatch_group_wait(group, DISPATCH_TIME_FOREVER); //如果时间设置为FOREVER,那么result恒为0.
    if (result == 0) {
        //处理结束
        NSLog(@"finished");
    } else {
        NSLog(@"not finished");
    }
    NSLog(@"no wait");
}

- (void)requestNews:(void(^)(id posts))success
{
    NSLog(@"requestNews: %@", [NSThread currentThread]);
    success(@{});
    //下面的方法表示任务完成,离开组,如果没有调用,那么将会一直等待该任务的离开
    //如果你没有调用下面的方法,也没有设置dispatch_group_wait
    //那么你的dispatch_group_notify方法里面的block将永远都不会执行.
    dispatch_group_leave(_group);
}

- (void)requestWethear:(void(^)(id posts))success
{
    success(@{});
    //离开组
    dispatch_group_leave(_group);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
