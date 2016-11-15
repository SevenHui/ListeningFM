//
//  XQ_TabBarViewController.m
//  ListeningFM
//
//  Created by apple on 16/9/21.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//  设置tabbarController的控制器

#import "XQ_TabBarViewController.h"
#import "XQ_FindVC.h"
#import "XQ_SubVC.h"

@implementation XQ_TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 发现
    UINavigationController *find = [XQ_FindVC defaultFindUINavigationController];
    [self setChildController:find imageName: @"tabbar_find_n" selectImage:@"tabbar_find_h"];
    // 中间占位
    UIViewController *vc = [[UIViewController alloc] init];
    [self setChildController:vc imageName:nil selectImage:nil];
    // 订阅
    UINavigationController *sub = [XQ_SubVC defaultSubscibeViewUINavigationController];
    [self setChildController:sub imageName:@"tabbar_sound_n" selectImage:@"tabbar_sound_h"];

    
}
#pragma mark - 设置item对应页面的主控制器并设置tabBar属性
- (void)setChildController:(UIViewController *)vc imageName:(NSString *)imageName selectImage:(NSString *)selectedImage {
    // 创建tabBarItem并设置图片不被渲染
    vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    // 设置图片间距
    vc.tabBarItem.imageInsets = UIEdgeInsetsMake(8, 0, -8, 0);

    [self addChildViewController:vc];
}

@end
