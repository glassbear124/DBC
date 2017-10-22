//
//  TinderAppDelegate.h
//  Tinder
//
//  Created by Rahul Sharma on 24/11/13.
//  Copyright (c) 2013 3Embed. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LoginViewController.h"
#import "MenuViewController.h"

#import "PPRevealSideViewController.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@class SplashVC;

@interface TinderAppDelegate : UIResponder <UIApplicationDelegate,PPRevealSideViewControllerDelegate>
{
@private
//    NSManagedObjectContext *managedObjectContext_;
//    NSManagedObjectModel *managedObjectModel_;
//    NSPersistentStoreCoordinator *persistentStoreCoordinator_;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) SplashVC *vcSplash;
@property (strong, nonatomic) LoginViewController *vcLogin;
@property (strong, nonatomic) UINavigationController *navigationController;
//@property (strong, nonatomic) FBSession *loggedInSession;
@property (strong, nonatomic) PPRevealSideViewController *revealSideViewController;
//@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
//@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
//@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void) closeSession;
-(void)addBackButton:(UINavigationItem*)naviItem;

+(TinderAppDelegate *)sharedAppDelegate;
-(void)showToastMessage:(NSString *)message;

-(void) showProgress:(UIView*)view;
-(void) dismiss;

+(void)displayToastWithMessage:(NSString *)toastMessage;

+(void) showAlert:(NSString*)message;

@end
