#import "ForgotVC.h"

@interface ForgotVC ()

@end

@implementation ForgotVC

-(void) API_ForgotPassword {
    
    NSMutableDictionary *dictParam=[[NSMutableDictionary alloc]init];
    [dictParam setObject:_txtEmail.text forKey:@"email"];
    NSMutableURLRequest* request = [Service parseMethod:@"apis/auth/forgot_password" withParams:dictParam];
    
    [APPDELEGATE showProgress:self.view];
    
    WebServiceHandler* handler = [[WebServiceHandler alloc] init];
    handler.requestType = eParseKey;
    [handler placeWebserviceRequestWithString:request Target:self Selector:@selector(LoginProc:)];
}

-(void) LoginProc: (NSDictionary*)_response {
    [APPDELEGATE dismiss];
    
    if (_response == nil) {
        ;
    }
    else
    {
        [APPDELEGATE showToastMessage:@"Email sent to reset your password."];
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
#pragma mark - ViewLife Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpAllViews];
}

-(void)setUpAllViews
{
    _btnForgot.layer.borderColor = [UIColor whiteColor].CGColor;
    _vEmail.layer.borderColor = [UIColor whiteColor].CGColor;
    _txtEmail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"User name" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
}

-(IBAction) onBtnClick:(id)sender {
    if( sender == _btnForgot ) {
        if( _txtEmail.text.length == 0 ) {
            [APPDELEGATE showToastMessage:@"Please enter your email."];
            return;
        }
        [self API_ForgotPassword];
    } else if( sender == _btnBack ) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return true;
}

#pragma mark -
#pragma mark - Memory Mgmt

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
