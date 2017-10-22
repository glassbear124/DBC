#import "MenuViewController.h"
#import "RoundedImageView.h"

#import "Helper.h"


#import "HomeViewController.h"

#import "AllConstants.h"
#import "LoginViewController.h"

#import "AboutVC.h"
#import "ContactUsVC.h"
#import "SponserVC.h"
#import "AccountVC.h"
#import "FevoriteVC.h"
#import "OrganizationVC.h"


@interface MenuViewController ()
{
    RoundedImageView *profileImageView;
}
@end

@implementation MenuViewController

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
    [self prefersStatusBarHidden];
    self.navigationController.navigationBarHidden = YES;
    
    if( nCurLang == LangEng ) {
        [btnFavorite setTitle:@"My Favorites" forState:UIControlStateNormal];
        [btnOrganization setTitle:@"Organizations" forState:UIControlStateNormal];
        [btnAccount setTitle:@"My Account" forState:UIControlStateNormal];
        [btnAboutUs setTitle:@"About Us" forState:UIControlStateNormal];
        [btnSponsers setTitle:@"Sponsors" forState:UIControlStateNormal];
        [btnContatcUs setTitle:@"Contact Us" forState:UIControlStateNormal];
        [btnLogout setTitle:@"Logout" forState:UIControlStateNormal];
    } else if( nCurLang == LangNed ) {
        [btnFavorite setTitle:@"Mijn favorieten" forState:UIControlStateNormal];
        [btnOrganization setTitle:@"Organisaties" forState:UIControlStateNormal];
        [btnAccount setTitle:@"Mijn profiel" forState:UIControlStateNormal];
        [btnAboutUs setTitle:@"Over Ons" forState:UIControlStateNormal];
        [btnSponsers setTitle:@"Sponsors" forState:UIControlStateNormal];
        [btnContatcUs setTitle:@"Onze Contactgegevens" forState:UIControlStateNormal];
        [btnLogout setTitle:@"Uitloggen" forState:UIControlStateNormal];
    } else {
        [btnFavorite setTitle:@"Mi favoritonan" forState:UIControlStateNormal];
        [btnOrganization setTitle:@"Organisashonnan" forState:UIControlStateNormal];
        [btnAccount setTitle:@"Mi kuenta" forState:UIControlStateNormal];
        [btnAboutUs setTitle:@"Tokante di Nos" forState:UIControlStateNormal];
        [btnSponsers setTitle:@"Spònsers" forState:UIControlStateNormal];
        [btnContatcUs setTitle:@"Pa Kontakto" forState:UIControlStateNormal];
        [btnLogout setTitle:@"Logout" forState:UIControlStateNormal];
    }
}

#pragma  mark -
#pragma  mark - Button Action Method

-(IBAction) btnXClick:(id)sender {
    [self.revealSideViewController popViewControllerAnimated:YES];
}


-(IBAction)btnAction:(id)sender
{
    UIViewController* c = nil;
    UIButton* btn = (UIButton*)sender;
    if( sender == btnStart ) {
        HomeViewController *vc = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
        c = vc;
    }
    else if( sender == btnFavorite) {
        FevoriteVC* vc= [[FevoriteVC alloc] initWithNibName:@"FevoriteVC" bundle:nil];
        c = vc;
    }
    else if( sender == btnOrganization ) {
        OrganizationVC* vc= [[OrganizationVC alloc] initWithNibName:@"OrganizationVC" bundle:nil];
        c = vc;
    }
    else if( sender == btnAccount ) {
        AccountVC* vc= [[AccountVC alloc] initWithNibName:@"AccountVC" bundle:nil];
        c = vc;        
    }
    else if( sender == btnAboutUs ) {
        AboutVC* vc= [[AboutVC alloc] initWithNibName:@"AboutVC" bundle:nil];
        c = vc;
    }
    else if( sender == btnSponsers) {
        SponserVC* vc = [[SponserVC alloc] initWithNibName:@"SponserVC" bundle:nil];
        c = vc;
    }
    else if( sender == btnContatcUs) {
        ContactUsVC* vc= [[ContactUsVC alloc] initWithNibName:@"ContactUsVC" bundle:nil];
        c = vc;
    }
    else if( sender == btnLogout ) {
        
        FBSDKLoginManager *fbLogin = [[FBSDKLoginManager alloc] init];
        [fbLogin logOut];
        
        TinderAppDelegate* appDel = [TinderAppDelegate sharedAppDelegate];
        LoginViewController *login = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        appDel.navigationController = [[UINavigationController alloc] initWithRootViewController:login];
        
        appDel.revealSideViewController= [[PPRevealSideViewController alloc] initWithRootViewController:appDel.navigationController];
        appDel.revealSideViewController.delegate = self;
        appDel.window.rootViewController = appDel.revealSideViewController;
        
        PP_RELEASE(login);

    }
    
    if( c ) {
        c.title = btn.titleLabel.text;
        UINavigationController *n = [[UINavigationController alloc] initWithRootViewController:c];
        [self.revealSideViewController popViewControllerWithNewCenterController:n
                                                                       animated:YES];
        PP_RELEASE(c);
        PP_RELEASE(n);
    }
    
    return;
}

#pragma mark -
#pragma mark - Memory Mgmt

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end;
