//
//  LoginInfoVC.m
//  Tinder
//
//  Created by Elluminati - macbook on 08/05/14.
//  Copyright (c) 2014 AppDupe. All rights reserved.
//

#import "SignupVC.h"

#import "SignupVC.h"

@interface SignupVC ()

@end

@implementation SignupVC

@synthesize parent;

-(void) API_Signup {
    
    NSMutableDictionary *dictParam=[[NSMutableDictionary alloc]init];
    [dictParam setObject:_txtUserName.text forKey:@"username"];
    [dictParam setObject:_txtPassword.text forKey:@"password"];
    [dictParam setObject:_txtEmail.text forKey:@"email"];
    NSMutableURLRequest* request = [Service parseMethod:@"apis/auth/signup" withParams:dictParam];
    
    [APPDELEGATE showProgress:self.view];
    
    WebServiceHandler* handler = [[WebServiceHandler alloc] init];
    handler.requestType = eParseKey;
    [handler placeWebserviceRequestWithString:request Target:self Selector:@selector(SignupProc:)];
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        [APPDELEGATE dismiss];
        
        if (!error) {
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:kNilOptions
                                                                   error:&error];
            int errorcode = [[json objectForKey:@"errorcode"] intValue];
            if( errorcode ) {
//                [APPDELEGATE dismiss];
                [TinderAppDelegate showAlert:@"The Sign Up process has failed."];
                return;
            }
            [APPDELEGATE showToastMessage:@"Welcome to the Pet Cupid app!"];
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        else {
//            NSLog( @"error" );
            [TinderAppDelegate showAlert:@"The Sign Up process has failed."];
            return;
        }
    }] resume];
}

-(void) SignupProc:(NSDictionary*)_response {
    [APPDELEGATE dismiss];
    
    if (_response == nil) {
        ;
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }    
}


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

int kbHeight;


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpAllViews];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
}

-(void) viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog( @"%@", _scrlView.description );
}

-(void)setUpAllViews
{
    _btnSingup.layer.borderColor = [UIColor whiteColor].CGColor;
    
    _vUserName.layer.borderColor = [UIColor whiteColor].CGColor;
    _vEmail.layer.borderColor = [UIColor whiteColor].CGColor;
    _vPassword.layer.borderColor = [UIColor whiteColor].CGColor;
    _vConfirm.layer.borderColor = [UIColor whiteColor].CGColor;
    
    _txtUserName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"User name" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];    
    _txtEmail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"E-mail" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    _txtPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    _txtConfirm.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Confirm Password" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    
    _scrlView.contentSize = CGSizeMake(0,
                                       [UIScreen mainScreen].bounds.size.height);
}

-(IBAction) onBtnClick:(id)sender {
    if( sender == _btnSingup ) {
        
        if( _txtUserName.text.length == 0 ) {
            [APPDELEGATE showToastMessage:@"Please enter your username"];
            return;
        }
        
        if( _txtEmail.text.length == 0 ) {
            [APPDELEGATE showToastMessage:@"Please enter your email."];
            return;
        }
        
        if( _txtPassword.text.length == 0 ) {
            [APPDELEGATE showToastMessage:@"Please enter your password."];
            return;
        }
        
        if( _txtConfirm.text.length == 0 ) {
            [APPDELEGATE showToastMessage:@"Please confirm the password."];
            return;
        }
        
        NSString* pw1 = _txtPassword.text;
        NSString* pw2 = _txtConfirm.text;
        
        if( [pw1 isEqualToString:pw2] == false ) {
            [APPDELEGATE showToastMessage:@"The password cannot be confirmed."];
            return;
        }
        [self API_Signup];
        
    } else if( sender == _btnBack ) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if( textField == _txtUserName ) {
        [_txtEmail becomeFirstResponder];
    }
    else if( textField == _txtEmail ) {
        [_txtPassword becomeFirstResponder];
    }
    else if( textField == _txtPassword ) {
        [_txtConfirm becomeFirstResponder];
    }
    else {
        [textField resignFirstResponder];
    }
    return true;
}

- (void)keyboardDidShow: (NSNotification *) notif{
    NSDictionary* keyboardInfo = [notif userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize kbSize = [keyboardFrameBegin CGRectValue].size;
    CGSize scSize = [UIScreen mainScreen].bounds.size;
    _scrlView.frame = CGRectMake(0,0, kbSize.width, scSize.height - kbSize.height);
    _scrlView.contentOffset = CGPointMake(0, kbSize.height);
}

- (void)keyboardDidHide: (NSNotification *) notif{
    CGSize size = [UIScreen mainScreen].bounds.size;
    _scrlView.frame = CGRectMake(0,0, size.width, size.height);
}

#pragma mark -
#pragma mark - Memory Mgmt

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
