//
//  AppDelegate.m
//  MedControl
//
//  Created by Juan Antonio de los Santos Zarco on 2/3/15.
//  Copyright (c) 2015 Juan Antonio de los Santos Zarco. All rights reserved.
//

#import "AppDelegate.h"
#import "JSZPatientListModel.h"
#import "JSZPatientListController.h"
#import "JSZPatientController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [self configureStyles];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [self configureForPad];
    }else{
        [self configureForPhone];
    }
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
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


#pragma mark - Utils

-(void)configureForPhone{
    
    JSZPatientListModel *model = [[JSZPatientListModel alloc]init];
    
    JSZPatientListController *patientListController = [[JSZPatientListController alloc]initWithModel:model style:UITableViewStylePlain];
    
    UINavigationController *patientsNav = [[UINavigationController alloc] init];
    
    [patientsNav pushViewController:patientListController animated:NO];
    
    patientListController.delegate = patientListController;
    
    self.window.rootViewController = patientsNav;
    
}

-(void)configureForPad{
    
    JSZPatientListModel *model = [[JSZPatientListModel alloc]init];
    
    JSZPatientListController *patientListController = [[JSZPatientListController alloc]initWithModel:model style:UITableViewStylePlain];
    
    JSZPatientController *patientViewController = [[JSZPatientController alloc]initWithModel:[model.patients objectAtIndex:0]];
    
    UINavigationController *navVc = [[UINavigationController alloc]init];
    [navVc pushViewController:patientViewController animated:YES];
    
    UINavigationController *tableNav = [[UINavigationController alloc]init];
    [tableNav pushViewController:patientListController animated:NO];
    
    UISplitViewController *splitVc = [[UISplitViewController alloc]init];
    [splitVc setViewControllers:@[tableNav,navVc]];
    
    splitVc.view.backgroundColor = [UIColor whiteColor];
    splitVc.delegate = patientViewController;
    
    patientListController.delegate = patientViewController;
    
    self.window.rootViewController = splitVc;
        
}


-(void)configureStyles{
    
    [[UITableView appearanceWhenContainedIn:[JSZPatientListController class], nil] setSectionIndexBackgroundColor:[UIColor redColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor greenColor]];
    [[UITableView appearance]setSectionIndexColor:[UIColor yellowColor]];
}

@end
