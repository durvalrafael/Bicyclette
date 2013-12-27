//
//  BicycletteApplicationDelegate.m
//  Bicyclette
//
//  Created by Nicolas on 02/04/10.
//  Copyright 2010 Nicolas Bouilleaud. All rights reserved.
//

#import "BicycletteApplicationDelegate.h"
#import "Station.h"
#import "RootVC.h"
#import "CitiesController.h"
#import "BicycletteCity.h"

#pragma mark Private Methods

@interface BicycletteApplicationDelegate()
@property CitiesController * citiesController;

@property IBOutlet RootVC *rootVC;
@end

@interface BicycletteApplicationDelegate (GAI)
- (void) setupGAI;
- (void) cleanupGAI;
@end

#pragma mark -

@implementation BicycletteApplicationDelegate

#pragma mark Application lifecycle

- (void) awakeFromNib
{
	// Load Factory Defaults
	[[NSUserDefaults standardUserDefaults] registerDefaults:
	 [NSDictionary dictionaryWithContentsOfFile:
	  [[NSBundle mainBundle] pathForResource:@"FactoryDefaults" ofType:@"plist"]]];

    
    self.citiesController = [CitiesController new];
    
    self.rootVC.citiesController = self.citiesController;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Clear all notifications.
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    // Must not do it automatically, otherwise the UI is broken vertically, initially, on iPad on iOS 5
    self.window.rootViewController = self.rootVC;
	return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [self cleanupGAI];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Clear all notifications.
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    if([notification.userInfo[@"type"] isEqualToString:@"stationsummary"])
        [self.citiesController handleLocalNotificaion:notification];
    else if([notification.userInfo[@"type"] isEqualToString:@"donationrequest"])
        [self.rootVC handleDonationNotification:notification];
}

@end

#pragma mark - Google Analytics Dance

#if !TARGET_IPHONE_SIMULATOR
#import <GAI.h>
#endif

@implementation BicycletteApplicationDelegate (GAI)
- (void) setupGAI
{
#if !TARGET_IPHONE_SIMULATOR
    // Google Analytics
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    [GAI sharedInstance].dispatchInterval = 20;
    NSString * trackingID = [[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"_GoogleAnalytics" ofType:@"plist"]] objectForKey:@"TrackingID"];
    [[GAI sharedInstance] trackerWithTrackingId:trackingID];
#if DEBUG
    [GAI sharedInstance].debug = YES;
    [GAI sharedInstance].defaultTracker.useHttps = NO;
#endif
    [GAI sharedInstance].defaultTracker.anonymize = YES;
#endif
}
- (void) cleanupGAI
{
#if !TARGET_IPHONE_SIMULATOR
    [[GAI sharedInstance] dispatch];
#endif
}
@end
