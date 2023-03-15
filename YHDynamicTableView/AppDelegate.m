//
//  AppDelegate.m
//  YHDynamicTableView
//
//  Created by YEHAN on 2023/3/15.
//

#import "AppDelegate.h"
#import "ListViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[ListViewController alloc] init]];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
