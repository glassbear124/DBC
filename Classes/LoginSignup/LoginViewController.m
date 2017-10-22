#import "LoginViewController.h"
#import "TinderAppDelegate.h"
#import "Helper.h"
#import "ProgressIndicator.h"
#import "Service.h"

#import "LoginInfoVC.h"
#import "SignupVC.h"

@interface LoginViewController ()

@property (nonatomic, strong) NSMutableDictionary *paramDict;
@end

@implementation LoginViewController

@synthesize paramDict;


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
    self.navigationController.navigationBarHidden = YES;
    _btnSignup.layer.borderColor = [UIColor whiteColor].CGColor;

}

-(void)viewWillAppear:(BOOL)animated
{
    PPRevealSideInteractions interContent = PPRevealSideInteractionNone;
    self.revealSideViewController.panInteractionsWhenClosed = interContent;
    self.revealSideViewController.panInteractionsWhenOpened = interContent;
}


#pragma mark -
#pragma mark - Actions

-(IBAction) onBtnClick:(id)sender {
    if( sender == _btnLogin ) {        
        LoginInfoVC *vc=[[LoginInfoVC alloc]initWithNibName:@"LoginInfoVC" bundle:nil];
        vc.parent=self;
        [self.navigationController pushViewController:vc animated:true];
    } else {
        SignupVC *vc=[[SignupVC alloc]initWithNibName:@"SignupVC" bundle:nil];
        [self.navigationController pushViewController:vc animated:true];
    }
}

#pragma mark -
#pragma mark - Memory mgmt

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
