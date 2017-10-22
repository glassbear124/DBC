
#import "InfoVC.h"
#import "DetailVC.h"
#import "Organization.h"
#import "UIImageView+WebCache.h"

@interface InfoVC ()
{
    Organization* org;
    NSDictionary* dicInfo;
}
@end

@implementation InfoVC


-(void) API_getDetail {

    NSMutableDictionary *dictParam=[[NSMutableDictionary alloc]init];
    [dictParam setObject:gUser.apikey forKey:@"apikey"];
    [dictParam setObject:[NSString stringWithFormat:@"%d", _pet.animal_id] forKey:@"animal_id"];
    NSMutableURLRequest* request = [Service parseMethod:@"apis/animals/detail" withParams:dictParam];

    [APPDELEGATE showProgress:self.view];
    WebServiceHandler* handler = [[WebServiceHandler alloc] init];
    handler.requestType = eParseKey;
    [handler placeWebserviceRequestWithString:request Target:self Selector:@selector(LoadInfo:)];

}

-(void) LoadInfo: (NSDictionary*)_response {
    [APPDELEGATE dismiss];
    if (_response == nil) {
        ;
    }
    else
    {
        NSDictionary* dicObj = [_response objectForKey:@"org"];
        dicInfo = [_response objectForKey:@"info"];

        org = [[Organization alloc] init];
        [org read:dicObj];

//        dispatch_sync(dispatch_get_main_queue(), ^{
            if( dicInfo ) {
                if( nCurLang == LangEng ) {
                    _txtComment.text = [dicInfo objectForKey:@"en"];
                } else if( nCurLang == LangNed ) {
                    _txtComment.text = [dicInfo objectForKey:@"nl"];
                } else {
                    _txtComment.text = [dicInfo objectForKey:@"pap"];
                }
            }
//        });
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
    
    self.navigationController.navigationBar.translucent = NO;
    
    UIImage *imgButton = [UIImage imageNamed:@"btn_back.png"];
    UIButton *leftbarbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftbarbutton setBackgroundImage:imgButton forState:UIControlStateNormal];
    [leftbarbutton setFrame:CGRectMake(0, 0, 30, 30)];
    [leftbarbutton addTarget:self action:@selector(menuClicked) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftbarbutton];

    [self setUpAllViews];
    [self API_getDetail];
}

-(void) fillInfo {
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

-(void)setUpAllViews
{
    [_imgPhoto setImageWithURL:[NSURL URLWithString:_pet.picture]];
    _lblText.text = _pet.name;
    
    UIFont* font = [UIFont boldSystemFontOfSize:17];
    
    NSString* strGender;
    if( nCurLang == LangEng ) {
        strGender = @"Gender:";
    } else if( nCurLang == LangNed ) {
        strGender = @"Geslacht:";
    } else {
        strGender = @"Sexo:";
    }
    
    NSString* genderValue = [_pet getSex];
    int genLen = [strGender length];
    
    NSMutableAttributedString *genderString;
    genderString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@", strGender, genderValue]];
    [genderString addAttribute:NSFontAttributeName
                         value:font
                         range:NSMakeRange(0,genLen)];
    _lblGender.attributedText = genderString;
    

    NSString* strAge;
    if( nCurLang == LangEng ) {
        strAge = @"Age:";
    } else if( nCurLang == LangNed ) {
        strAge = @"Leeftijd:";
    } else {
        strAge = @"Edat:";
    }
    int ageLen = [strAge length];
    NSString* ageValue = [_pet getAge];
    NSMutableAttributedString *ageString;
    ageString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@", strAge, ageValue]];
    [ageString addAttribute:NSFontAttributeName
                      value:font
                      range:NSMakeRange(0,ageLen)];
    _lblAge.attributedText  = ageString;

    
    NSString* strSize;
    if( nCurLang == LangEng ) {
        strSize = @"Size:";
    } else if( nCurLang == LangNed ) {
        strSize = @"Grootte:";
    } else {
        strSize = @"Grandura:";
    }
    int sizeLen = [strSize length];
    NSString* sizeValue = [_pet getSize];
    NSMutableAttributedString *sizeString;
    sizeString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@", strSize, sizeValue]];
    [sizeString addAttribute:NSFontAttributeName
                       value:font
                       range:NSMakeRange(0,sizeLen)];
    _lblSize.attributedText  = sizeString;    
    
    if( nCurLang == LangNed ) {
        [_btnAdapt setTitle:@"Adopteer mij" forState:UIControlStateNormal];
    } else if( nCurLang == LangPap ) {
        [_btnAdapt setTitle:@"Adopta'mi" forState:UIControlStateNormal];
    }
}

-(void) menuClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction) onBtnClick:(id)sender {
    DetailVC* vc = [[DetailVC alloc] initWithNibName:@"DetailVC" bundle:nil];
    vc.org = org;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -
#pragma mark - Memory Mgmt

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
