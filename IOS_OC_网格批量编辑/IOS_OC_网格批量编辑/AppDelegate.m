//
//  AppDelegate.m
//  IOS_OC_网格批量编辑
//
//  Created by 张东辉 on 2020-4-14.
//  Copyright © 2020 ZDH. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    ViewController *vc = [ViewController new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = nav;
    return YES;
}



@end
