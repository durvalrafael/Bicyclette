//
//  BicycletteApplicationDelegate.m
//  Bicyclette
//
//  Created by Nicolas on 02/04/10.
//  Copyright 2010 Nicolas Bouilleaud. All rights reserved.
//

#import "BicycletteApplicationDelegate.h"
#import "VelibModel.h"
#import "Locator.h"
#import "BicycletteBar.h"
#include <unistd.h>
#import "DataUpdater.h"

/****************************************************************************/
#pragma mark Private Methods

@interface BicycletteApplicationDelegate() <BicycletteBarDelegate>

@property (nonatomic, retain) VelibModel * model;
@property (nonatomic, retain) Locator * locator;

- (void) selectTabIndex:(NSUInteger)index;

@end

/****************************************************************************/
#pragma mark -

@implementation BicycletteApplicationDelegate

@synthesize window, tabBarController, toolbar, notificationView;
@synthesize model;
@synthesize locator;

/****************************************************************************/
#pragma mark Application lifecycle

- (void) awakeFromNib
{
	// Load Factory Defaults
	[[NSUserDefaults standardUserDefaults] registerDefaults:
	 [NSDictionary dictionaryWithContentsOfFile:
	  [[NSBundle mainBundle] pathForResource:@"FactoryDefaults" ofType:@"plist"]]];
	
	self.model = [[VelibModel new] autorelease];
	[self.model.updater addObserver:self forKeyPath:@"downloadingUpdate" options:0 context:[BicycletteApplicationDelegate class]];
	self.locator = [[Locator new] autorelease];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[self.window insertSubview:self.tabBarController.view belowSubview:self.toolbar];
	
	// Hide the tabbar, the toolbar's segmented control is used instead
	self.tabBarController.tabBar.hidden = YES;
	UIView * contentView = [self.tabBarController.view.subviews objectAtIndex:0];
	contentView.frame = [[UIScreen mainScreen] bounds];
	
	[self selectTabIndex:[[NSUserDefaults standardUserDefaults] integerForKey:@"SelectedTabIndex"]];
	
	// notification view
	self.notificationView.alpha = 0.f;
	self.notificationView.layer.cornerRadius = 10;
	[self.window addSubview:self.notificationView];
	self.notificationView.center = self.window.center;
	[self.window makeKeyAndVisible];
	
	UIView * fadeView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default"]] autorelease];
	[self.window addSubview:fadeView];
	[UIView beginAnimations:nil context:NULL];
	fadeView.alpha = 0;
	fadeView.transform = CGAffineTransformMakeScale(2, 2);
	[fadeView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:1];
	[UIView commitAnimations];
	
	return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	[self.locator start];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	[self.locator stop];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	[[NSUserDefaults standardUserDefaults] setInteger:(NSInteger)self.tabBarController.selectedIndex forKey:@"SelectedTabIndex"];
	[self.locator stop];
    usleep(500*1000);
}

- (void)dealloc {
	self.window = nil;
	self.tabBarController = nil;
	self.toolbar = nil;
	self.notificationView = nil;
	[self.model.updater removeObserver:self forKeyPath:@"downloadingUpdate"];
	self.model = nil;
	self.locator = nil;
	[super dealloc];
}

/****************************************************************************/
#pragma mark Tab Selection

- (void) bicycletteBar:(BicycletteBar*)bar didSelectIndex:(NSUInteger)index
{
	BOOL shouldPop = self.tabBarController.selectedIndex==index;
	[self selectTabIndex:index];
	if(shouldPop)
		[(UINavigationController*)self.tabBarController.selectedViewController popToRootViewControllerAnimated:YES];
}

- (void) selectTabIndex:(NSUInteger)index
{
	self.tabBarController.selectedIndex = index;
	self.toolbar.selectedIndex = index;
}

/****************************************************************************/
#pragma mark -

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == [BicycletteApplicationDelegate class]) {
		[UIView beginAnimations:nil context:NULL];
		self.notificationView.alpha = self.model.updater.downloadingUpdate?1.f:0.f;
		[UIView commitAnimations];
	}
	else {
		[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
	}
}

@end
