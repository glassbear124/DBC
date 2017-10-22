//
//  LoginInfoVC.h
//  Tinder
//
//  Created by Elluminati - macbook on 08/05/14.
//  Copyright (c) 2014 AppDupe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginInfoVC : UIViewController<UITextFieldDelegate, FBSDKLoginButtonDelegate>
{
    
}
@property(nonatomic,strong)id parent;

@property(nonatomic,weak)IBOutlet UIButton *btnLogin;
@property(weak,nonatomic)IBOutlet UIButton *btnSingup;
@property(weak,nonatomic)IBOutlet UIButton *btnForgot;
@property(weak,nonatomic)IBOutlet UIButton *btnBack;
@property(weak,nonatomic)IBOutlet UIButton *btnFacebook;

@property (nonatomic, retain) IBOutlet UIView* vUserName;
@property (nonatomic, retain) IBOutlet UIView* vPassword;

@property (nonatomic, retain) IBOutlet UITextField* txtUserName;
@property (nonatomic, retain) IBOutlet UITextField* txtPassword;


@end
