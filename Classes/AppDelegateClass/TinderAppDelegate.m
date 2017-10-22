//
//  TinderAppDelegate.m
//  Tinder
//
//  Created by Rahul Sharma on 24/11/13.
//  Copyright (c) 2013 3Embed. All rights reserved.
//

#import "TinderAppDelegate.h"

#import "SplashVC.h"


#define _offsetValue 62
#define _animated  YES

MBProgressHUD* g_hud;
MBProgressHUD* g_toast;

UIActivityIndicatorView* actView;


@implementation TinderAppDelegate

@synthesize navigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //For Push Noti Reg.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
//    self.vcSplash = [[SplashVC alloc]initWithNibName:@"SplashVC" bundle:nil];
//    self.window.rootViewController = self.vcSplash;
//    [self.window makeKeyAndVisible];

    self.vcLogin = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:self.vcLogin];
    self.revealSideViewController= [[PPRevealSideViewController alloc] initWithRootViewController:[TinderAppDelegate sharedAppDelegate].navigationController];
    self.revealSideViewController.delegate = self;
    self.window.rootViewController = [TinderAppDelegate sharedAppDelegate].revealSideViewController;
    [self.window makeKeyAndVisible];

    [self customizeNavigationBar];
    
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];

    return YES;
}


- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark -
#pragma mark - FBSetion Methods

- (void) closeSession
{
//    [[FBSession activeSession] closeAndClearTokenInformation];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

#pragma mark -
#pragma mark - Facebook Methods

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options {
    return [[FBSDKApplicationDelegate sharedInstance] application:app
                                                          openURL:url
                                                sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                                       annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
}

#pragma mark -
#pragma mark Core Data stack

#pragma mark -
#pragma mark - Utility Methods

-(void)addBackButton:(UINavigationItem*)naviItem
{
    UIImage *imgButton = [UIImage imageNamed:@"menu_icon_off.png"];
	UIButton *leftbarbutton = [UIButton buttonWithType:UIButtonTypeCustom];
	[leftbarbutton setBackgroundImage:imgButton forState:UIControlStateNormal];
    [leftbarbutton setBackgroundImage:[UIImage imageNamed:@"menu_icon_on.png"] forState:UIControlStateHighlighted];
	[leftbarbutton setFrame:CGRectMake(0, 0, imgButton.size.width, imgButton.size.height)];
    [leftbarbutton addTarget:self action:@selector(menuClicked) forControlEvents:UIControlEventTouchUpInside];
    naviItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftbarbutton];
}

-(void)menuClicked
{
    MenuViewController *menu=[[MenuViewController alloc]initWithNibName:@"MenuViewController" bundle:nil];
    _revealSideViewController.delegate = self;
    [_revealSideViewController pushViewController:menu onDirection:PPRevealSideDirectionLeft withOffset:_offsetValue animated:_animated];
    PP_RELEASE(menu);
}

-(void)customizeNavigationBar
{
    [[UINavigationBar appearance] setBarTintColor:my_color];
    [[UINavigationBar appearance] setTranslucent:NO];
    
    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor whiteColor], NSForegroundColorAttributeName, nil]];
}

#pragma mark -
#pragma mark Application's Documents directory

/**
 Returns the path to the application's Documents directory.
*/

- (NSString *)applicationDocumentsDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

#pragma mark -
#pragma mark - sharedAppDelegate

+(TinderAppDelegate *)sharedAppDelegate
{
    return (TinderAppDelegate *)[[UIApplication sharedApplication] delegate];
}


-(void) showProgress : (UIView*) view {
    
//    if( actView == nil )
//        actView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    
//    actView.center = view.center;
//    [view addSubview:actView];
//    [actView startAnimating];
    
    if( g_hud == nil ) {
        g_hud = [[MBProgressHUD alloc] initWithWindow:self.window];
    }
    g_hud.color = my_color;
    [view addSubview:g_hud];
    [g_hud show:YES];
}

-(void) dismiss {
    if( g_hud != nil ) {
        [g_hud hide:YES];
    }
//    [actView stopAnimating];
//    [actView removeFromSuperview];
}


-(void)showToastMessage:(NSString *)message
{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.window animated:YES];
    
	// Configure for text only and offset down
	hud.mode = MBProgressHUDModeText;
	hud.detailsLabelText = message;
	hud.margin = 12.f;
	hud.yOffset = 150.f;
	hud.removeFromSuperViewOnHide = YES;
    hud.color = my_color;
	[hud hide:YES afterDelay:2.0];

//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.window animated:YES];
//    
//    // Fire off an asynchronous task, giving UIKit the opportunity to redraw wit the HUD added to the
//    // view hierarchy.
//    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
//        
//        // Do something useful in the background
//        // [self doSomeWork];
//        
//        // IMPORTANT - Dispatch back to the main thread. Always access UI
//        // classes (including MBProgressHUD) on the main thread.
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [hud hideAnimated:YES];
//        });
//    });
    
//    [self performSelector:@selector(hideDelayed) withObject:nil afterDelay:3.0];
}


+(void) showAlert:(NSString *)message {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
    
//    int duration = 3; // duration in seconds
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (double)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [alert dismissWithClickedButtonIndex:0 animated:YES];
//    });
}


+(void)displayToastWithMessage:(NSString *)toastMessage
{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
        UIWindow * keyWindow = [[UIApplication sharedApplication] keyWindow];
        UILabel *toastView = [[UILabel alloc] init];
        toastView.text = toastMessage;
//        toastView.font = [MYUIStyles getToastHeaderFont];
        toastView.textColor = [UIColor whiteColor];
        toastView.backgroundColor = my_color;
        toastView.textAlignment = NSTextAlignmentCenter;
        toastView.frame = CGRectMake(0.0, 0.0, keyWindow.frame.size.width/2.0, 30.0);
        toastView.layer.cornerRadius = 10;
        toastView.layer.masksToBounds = YES;
        toastView.center = keyWindow.center;
        
        [keyWindow addSubview:toastView];
        
        [UIView animateWithDuration: 3.0f
                              delay: 0.0
                            options: UIViewAnimationOptionCurveEaseOut
                         animations: ^{
                             toastView.alpha = 0.0;
                         }
                         completion: ^(BOOL finished) {
                             [toastView removeFromSuperview];
                         }
         ];
    }];
}

@end
