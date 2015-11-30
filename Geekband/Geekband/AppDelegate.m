//
//  AppDelegate.m
//  Geekband
//
//  Created by sleepinge on 15/11/26.
//  Copyright © 2015年 sleepinge. All rights reserved.
//
#import "AppDelegate.h"
#import "KGLoginAndRegisterViewController.h"
#import "KGMyViewController.h"
#import "KGSquareViewController.h"
#import "KGPublishViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)loadMainViewWithController:(UIViewController *)controller {
    // square
    UIStoryboard *squareStoryboard = [UIStoryboard storyboardWithName:@"KGSquare" bundle:[NSBundle mainBundle]];
    KGSquareViewController *squareVC = [squareStoryboard instantiateViewControllerWithIdentifier:@"SquareStoryboard"];
    //    squareVC.view.backgroundColor = [UIColor redColor];
    UINavigationController *squareNav = [[UINavigationController alloc]initWithRootViewController:squareVC];
    squareNav.navigationBar.barTintColor = [[UIColor alloc]initWithRed:230/255.0 green:106/255.0 blue:58/255.0 alpha:1];
    squareNav.tabBarItem.title = @"广场";
    squareNav.tabBarItem.image = [UIImage imageNamed:@"square"];
    
    // my
    UIStoryboard *myStoryboard = [UIStoryboard storyboardWithName:@"KGMy" bundle:[NSBundle mainBundle]];
    KGMyViewController *myVC = [myStoryboard instantiateViewControllerWithIdentifier:@"MyStoryboard"];
    myVC.tabBarItem.title = @"我的";
    myVC.tabBarItem.image = [UIImage imageNamed:@"my"];
    
    self.tabBarController = [[UITabBarController alloc]init];
    self.tabBarController.viewControllers = @[squareNav, myVC];
    
    [controller presentViewController:self.tabBarController animated:YES completion:nil];
    
    // publish
    CGFloat viewWidth = [UIScreen mainScreen].bounds.size.width;
    UIButton *photoButton = [[UIButton alloc]initWithFrame:CGRectMake(viewWidth/2-60, -25, 120, 50)];
    [photoButton setImage:[UIImage imageNamed:@"publish"] forState:UIControlStateNormal];
    [photoButton addTarget:self action:@selector(photoButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBarController.tabBar addSubview:photoButton];
}

- (void)photoButtonClicked {
    UIStoryboard *publishStoryboard = [UIStoryboard storyboardWithName:@"KGPublish" bundle:[NSBundle mainBundle]];
    KGPublishViewController *publishVC = [publishStoryboard instantiateViewControllerWithIdentifier:@"CMJ"];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:publishVC];
    [self.tabBarController presentViewController:nav animated:YES completion:nil];
}

- (void)loadLoginView {
    UIStoryboard *loginStoryboard = [UIStoryboard storyboardWithName:@"KGLoginAndRegister" bundle:[NSBundle mainBundle]];
    KGLoginAndRegisterViewController *loginController = [loginStoryboard instantiateViewControllerWithIdentifier:@"LoginStoryboard"];
    [loginController dismissViewControllerAnimated:YES completion:nil];
}

#pragma Mark App lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
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
