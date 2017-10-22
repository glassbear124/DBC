
#import "ChangePassVC.h"
#import "AllConstants.h"

@interface ChangePassVC ()

@end

@implementation ChangePassVC

-(void) API_ChangePass {
    
    NSMutableDictionary *dictParam=[[NSMutableDictionary alloc]init];
    [dictParam setObject:gUser.apikey forKey:@"apikey"];
    [dictParam setObject:_fldPass.text forKey:@"new_pwd"];
    NSMutableURLRequest* request = [Service parseMethod:@"apis/profile/change_password" withParams:dictParam];
    
    [APPDELEGATE showProgress:self.view];
    
    WebServiceHandler* handler = [[WebServiceHandler alloc] init];
    handler.requestType = eParseKey;
    [handler placeWebserviceRequestWithString:request Target:self Selector:@selector(ChangePassword:)];
}

-(void) ChangePassword: (NSDictionary*)_response {
    [APPDELEGATE dismiss];
    
    if (_response == nil) {
        [APPDELEGATE showToastMessage:@"The password change has failed."];
    }
    else
    {
        [APPDELEGATE showToastMessage:@"The password change has been completed."];
    }
}


#pragma mark -
#pragma mark - Init

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

#pragma mark -
#pragma mark - ViewLife Cycle

- (BOOL) pprevealSideViewController:(PPRevealSideViewController *)controller shouldDeactivateGesture:(UIGestureRecognizer*)gesture forView:(UIView*)view
{
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBarHidden = NO;
    UIImage *imgButton = [UIImage imageNamed:@"btn_back.png"];
    UIButton *leftbarbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftbarbutton setBackgroundImage:imgButton forState:UIControlStateNormal];
    [leftbarbutton setFrame:CGRectMake(0, 0, 30, 30)];
    [leftbarbutton addTarget:self action:@selector(menuClicked) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftbarbutton];
}

-(void) menuClicked {
    [self.navigationController popViewControllerAnimated:YES];
}


-(void) viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self setUpAllViews];
}

-(void)setUpAllViews
{
    _btnReset.layer.borderColor = [UIColor whiteColor].CGColor;
    
    if( nCurLang == LangPap ) {
        _fldPass.placeholder = @"Password nobo";
        _fldConfirm.placeholder = @"Konfirma bo password";
    } else if( nCurLang == LangNed ) {
        _fldPass.placeholder = @"Nieuw paswoord";
        _fldConfirm.placeholder = @"Bevestig wachtwoord";
    }
}

-(IBAction) onBtnClick:(id)sender {
    NSString* str1 = _fldPass.text;
    NSString* str2 = _fldConfirm.text;
    
    if( str1.length == 0 ) {
        [APPDELEGATE showToastMessage:@"Please enter your password."];
        return;
    }
    
    if( str2.length == 0 ) {
        [APPDELEGATE showToastMessage:@"Please confirm the password."];
        return;
    }
    
    if( [str1 isEqualToString:str2] == false ) {
        [APPDELEGATE showToastMessage:@"The password is incorrect."];
        return;
    }
    [self API_ChangePass];
}

#pragma mark -
#pragma mark - Memory Mgmt

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
