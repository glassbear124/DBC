//
//  LoginInfoVC.m
//  Tinder
//
//  Created by Elluminati - macbook on 08/05/14.
//  Copyright (c) 2014 AppDupe. All rights reserved.
//

#import "LoginInfoVC.h"

#import "LoginViewController.h"
#import "ForgotVC.h"
#import "SignupVC.h"
#import "SelectLangVC.h"

#import <FBSDKLoginKit/FBSDKLoginManager.h>

#import "User.h"

@interface LoginInfoVC ()
@end

@implementation LoginInfoVC

@synthesize parent;

#pragma mark -
#pragma mark - Init

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark -
#pragma mark - ViewLife Cycle

-(void) API_fb_login:(NSDictionary*) result {
    NSString* strEmail = [result objectForKey:@"email"];
    NSString* strID = [result objectForKey:@"id"];
    NSString* strUsername = [NSString stringWithFormat:@"user%@", strID];
    NSString* strFirstName = [result objectForKey:@"first_name"];
    NSString* strLastName = [result objectForKey:@"last_name"];

    NSMutableDictionary *dictParam=[[NSMutableDictionary alloc]init];
    [dictParam setObject:strID forKey:@"fb_id"];
    [dictParam setObject:strFirstName forKey:@"first_name"];
    [dictParam setObject:strLastName forKey:@"last_name"];
    [dictParam setObject:strUsername forKey:@"username"];
    [dictParam setObject:strEmail forKey:@"email"];
    
    NSMutableURLRequest* request = [Service parseMethod:@"apis/auth/fb_signin" withParams:dictParam];
    WebServiceHandler* handler = [[WebServiceHandler alloc] init];
    handler.requestType = eParseKey;
    [handler placeWebserviceRequestWithString:request Target:self Selector:@selector(LoginProc:)];
}

-(void) API_login {
    
    NSMutableDictionary *dictParam=[[NSMutableDictionary alloc]init];
    [dictParam setObject:_txtUserName.text forKey:@"username"];
    [dictParam setObject:_txtPassword.text forKey:@"password"];
    NSMutableURLRequest* request = [Service parseMethod:@"apis/auth/signin" withParams:dictParam];
    
    [APPDELEGATE showProgress:self.view];
    WebServiceHandler* handler = [[WebServiceHandler alloc] init];
    handler.requestType = eParseKey;
    [handler placeWebserviceRequestWithString:request Target:self Selector:@selector(LoginProc:)];
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        [APPDELEGATE dismiss];
        
        
        if (!error) {
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:kNilOptions
                                                                   error:&error];
            int errorcode = [[json objectForKey:@"errorcode"] intValue];
            if( errorcode ) {
//                [APPDELEGATE showToastMessage:@"The login has failed."];
                [TinderAppDelegate showAlert:@"The login has failed."];
                return;
            }
            
            NSDictionary* result = [json objectForKey:@"result"];
            if( result == nil ) {
//                [APPDELEGATE showToastMessage:@"The login has failed."];
                [TinderAppDelegate showAlert:@"The login has failed."];
            }
        }
        else {
//            [APPDELEGATE showToastMessage:@"The login has failed."];
            [TinderAppDelegate showAlert:@"The login has failed."];
            NSLog( @"error" );
            return;
        }
    }] resume];
}

-(void) LoginProc: (NSDictionary*)_response {
    [APPDELEGATE dismiss];
    
    if (_response == nil) {
//        [APPDELEGATE showToastMessage:@"The login has failed."];
        [TinderAppDelegate showAlert:@"The login has failed."];
    }
    else
    {
        
        NSString* _apikey = [_response objectForKey:@"apikey"];
        if( _apikey == nil || [_apikey length] == 0 ) {
//            [APPDELEGATE showToastMessage:@"The login have failed"];
                [TinderAppDelegate showAlert:@"The login has failed."];
            return;
        }
        
        gUser = [[User alloc] init];
        [gUser read:_response];
        gUser.username = _txtUserName.text;

        SelectLangVC* vc = [[SelectLangVC alloc] initWithNibName:@"SelectLangVC" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpAllViews];
    
    _txtUserName.text = @"glassbear";
    _txtPassword.text = @"123456";
}

-(void)setUpAllViews
{
    _btnLogin.layer.borderColor = [UIColor whiteColor].CGColor;
    _btnSingup.layer.borderColor = [UIColor whiteColor].CGColor;
    
    _vUserName.layer.borderColor = [UIColor whiteColor].CGColor;
    _vPassword.layer.borderColor = [UIColor whiteColor].CGColor;
    
    _txtUserName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"User name" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];    
    _txtPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
}

-(void) login {
    
    if( _txtUserName.text.length == 0 ) {
        [APPDELEGATE showToastMessage:@"Please enter your username."];
        return;
    }
    
    if( _txtPassword.text.length == 0 ) {
        [APPDELEGATE showToastMessage:@"Please enter your password."];
        return;
    }
    [self API_login];
}


-(IBAction) onBtnClick:(id)sender {
    if( sender == _btnSingup ) {
        SignupVC* signup = [[SignupVC alloc] initWithNibName:@"SignupVC" bundle:nil];
        [self.navigationController pushViewController:signup animated:YES];
    } else if( sender == _btnLogin ) {
        [self login];
    } else if( sender == _btnForgot ) {
        ForgotVC* forgot = [[ForgotVC alloc] initWithNibName:@"ForgotVC" bundle:nil];
        [self.navigationController pushViewController:forgot animated:YES];
    } else if( sender == _btnBack ) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


-(IBAction)onClickbtnFBLogin:(id)sender
{
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    //[login logOut];
    [login logInWithReadPermissions:@[@"email"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {
            // Process error
            NSLog(@"error %@",error);
        } else if (result.isCancelled) {
            // Handle cancellations
            NSLog(@"Cancelled");
        } else {
            if ([result.grantedPermissions containsObject:@"email"]) {
                [APPDELEGATE showProgress:self.view];
                [self fetchUserInfo];
            }
            else {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"ss" message:@"Login Fail" preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }
    }];
}

-(void)fetchUserInfo {
    
    if ([FBSDKAccessToken currentAccessToken]) {
        //[self showLoginIndicator];
        
        NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
        [parameters setValue:@"id,first_name,last_name,email" forKey:@"fields"];
        
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:parameters]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                      id result, NSError *error) {
             NSLog(@"Result: %@", result);
             if ([result isKindOfClass:[NSDictionary class]]) {
                 [self API_fb_login:result];
             }
         }];
        
    } else {
        NSLog(@"User is not Logged in");
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if( textField == _txtUserName ) {
        [_txtPassword becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    return true;
}

#pragma mark -
#pragma mark - Memory Mgmt

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
