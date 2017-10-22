
#import "SelectLangVC.h"
#import "SliderVC.h"

@interface SelectLangVC ()

@end

@implementation SelectLangVC

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpAllViews];
}

-(void)setUpAllViews
{
    _vGroup.layer.borderColor = [UIColor whiteColor].CGColor;
}

-(IBAction) onBtnClick:(id)sender {
    if( sender == _btnBack ) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        if( sender == _btnEng ) {
            nCurLang = LangEng;
        } else if( sender == _btnNed ) {
            nCurLang = LangNed;
        } else {
            nCurLang = LangPap;
        }
        
        NSString *strTime=[[NSUserDefaults standardUserDefaults] objectForKey:@"logged"];
        if( strTime == nil || strTime.length == 0 ) {
            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"logged"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            SliderVC* vc = [[SliderVC alloc] initWithNibName:@"SliderVC" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            HomeViewController *home ;
            home = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
            [self.navigationController pushViewController:home animated:YES];
        }
    }
}

#pragma mark -
#pragma mark - Memory Mgmt

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
