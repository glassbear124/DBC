

#import "SplashVC.h"
#import "TinderAppDelegate.h"

@interface SplashVC ()

@end

@implementation SplashVC

#pragma mark -
#pragma mark - Init

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

#pragma mark -
#pragma mark - ViewLife Cycle

-(void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(removeSplash) userInfo:nil repeats:NO];
}

#pragma mark -
#pragma mark - Methods

- (void)removeSplash
{
//    if ([[FacebookUtility sharedObject]isLogin]) {
//        HomeViewController *home ;
//        home = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
//        [TinderAppDelegate sharedAppDelegate].navigationController = [[UINavigationController alloc] initWithRootViewController:home];
//    }
//    else
    {
        LoginViewController *login = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        [TinderAppDelegate sharedAppDelegate].navigationController = [[UINavigationController alloc] initWithRootViewController:login];
    }
    
    [TinderAppDelegate sharedAppDelegate].revealSideViewController= [[PPRevealSideViewController alloc] initWithRootViewController:[TinderAppDelegate sharedAppDelegate].navigationController];
    [TinderAppDelegate sharedAppDelegate].revealSideViewController.delegate = self;
    [TinderAppDelegate sharedAppDelegate].window.rootViewController = [TinderAppDelegate sharedAppDelegate].revealSideViewController;
    [[TinderAppDelegate sharedAppDelegate].window makeKeyAndVisible];
}

#pragma mark -
#pragma mark - Memory Mgmt

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
