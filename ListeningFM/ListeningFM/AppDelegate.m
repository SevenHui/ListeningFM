//
//  AppDelegate.m
//  ListeningFM
//
//  Created by apple on 16/9/20.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "AppDelegate.h"
#import "XQ_TabBarViewController.h"
#import "XQ_NavigationController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self CustomizeToController];
    
    return YES;
    
}
#pragma mark - 自定义tabBarController和navigationController
- (void)CustomizeToController {
    XQ_TabBarViewController *tabBarController = [[XQ_TabBarViewController alloc] init];
    tabBarController.tabBar.barTintColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.00];
    XQ_NavigationController *nav = [[XQ_NavigationController alloc] initWithRootViewController:tabBarController];
    self.window.rootViewController = nav;
    
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
