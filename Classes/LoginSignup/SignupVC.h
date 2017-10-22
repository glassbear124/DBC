//
//  LoginInfoVC.h
//  Tinder
//
//  Created by Elluminati - macbook on 08/05/14.
//  Copyright (c) 2014 AppDupe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignupVC : UIViewController<UITextFieldDelegate, UIScrollViewDelegate>
{
    
}
@property(nonatomic,strong)id parent;


@property(weak,nonatomic)IBOutlet UIButton *btnSingup;
@property(weak,nonatomic)IBOutlet UIButton *btnBack;

@property (nonatomic, retain) IBOutlet UIView* vUserName;
@property (nonatomic, retain) IBOutlet UIView* vEmail;
@property (nonatomic, retain) IBOutlet UIView* vPassword;
@property (nonatomic, retain) IBOutlet UIView* vConfirm;

@property (nonatomic, retain) IBOutlet UITextField* txtUserName;
@property (nonatomic, retain) IBOutlet UITextField* txtEmail;
@property (nonatomic, retain) IBOutlet UITextField* txtPassword;
@property (nonatomic, retain) IBOutlet UITextField* txtConfirm;

@property (nonatomic, retain) IBOutlet UIScrollView* scrlView;


@end
