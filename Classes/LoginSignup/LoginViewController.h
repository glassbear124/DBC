//
//  LoginViewController.h
//  Tinder
//
//  Created by Rahul Sharma on 24/11/13.
//  Copyright (c) 2013 3Embed. All rights reserved.
//

#import "BaseVC.h"
#import "HomeViewController.h"


@class TinderAppDelegate;
@interface LoginViewController : BaseVC
{
}

@property(nonatomic,weak)IBOutlet UIButton *btnLogin;
@property(weak,nonatomic)IBOutlet UIButton *btnSignup;


@end
