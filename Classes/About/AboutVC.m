
#import "AboutVC.h"
#import "AllConstants.h"

@interface AboutVC ()

@end

@implementation AboutVC

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

- (BOOL) pprevealSideViewController:(PPRevealSideViewController *)controller shouldDeactivateGesture:(UIGestureRecognizer*)gesture forView:(UIView*)view
{
    return YES;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.revealSideViewController.delegate = self;
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBarHidden = NO;
    [APPDELEGATE addBackButton:self.navigationItem];
    if( nCurLang == LangEng )
        [self.navigationItem setTitle:@"About Us"];
    else if( nCurLang == LangNed )
        [self.navigationItem setTitle:@"Over Ons"];
    else
        [self.navigationItem setTitle:@"Tokante di Nos"];
}

-(void) viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self setUpAllViews];
}

-(void)setUpAllViews
{
    NSString* strContent;
    if( nCurLang == LangEng ) {
        strContent = @"Stichting Dierenbescherming Curaçao (Animal Protection Foundation Curaçao) is an organization that strives to prevent animal cruelty, to shelter abandoned animals, to prevent unwanted offspring and to educate the population about animal rights and their proper caretaking. Our organization collaborates with other local organizations to help further this mission.\n\nFor more information about our organization, please visit our website www.dierenbeschermingcuracao.com";
    } else if( nCurLang == LangPap ) {
        strContent = @"Stichting Dierenbescherming Curaçao (Fundashon Protekshon di Animal Kòrsou) ta un organisashon ku ta traha pa prevení krueldad kontra di bestia, pa duna asil na bestianan ku a ser bandoná, pa prevení kòkmentu no deseá i pa eduká e pueblo tokante di e derechonan di animal i nan kuido adekuá. Nos organisashon ta kolaborá ku otro organisashonnan lokal pa asina sigui promové e meta aki.\n\nPa mas informashon tokante di nos organisashon, porfabor bishitá nos wepsait www.dierenbeschermingcuracao.com";
    } else {
        strContent = @"Stichting Dierenbescherming Curaçao is een organisatie die zich inspant om dierenleed te bestrijden, om in te steek gelaten dieren op te vangen, om ongewenste nakomelingen te voorkomen en om mensen voor te lichten omtrent dierenrechten  en de juiste manier van verzorging. Onze organisatie werkt samen met andere lokale organisaties om dit streven te bevorderen. \n\nVoor meer informatie over onze organisatie, bezoek onze website www.dierenbeschermingcuracao.com";
    }
    
    TTTAttributedLabel *myLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
    
    myLabel.numberOfLines = 0;
    myLabel.textColor = my_color;
    myLabel.font = [UIFont systemFontOfSize:16];
    
    CGSize s = _vSub.frame.size;
    myLabel.frame = CGRectMake(0,0, s.width, s.height);
    
    myLabel.linkAttributes = @{(id)kCTForegroundColorAttributeName: [UIColor blueColor],
                               (id)kCTUnderlineStyleAttributeName : [NSNumber numberWithInt:NSUnderlineStyleSingle]};
    myLabel.text = strContent;
    myLabel.delegate = self;
    myLabel.userInteractionEnabled=YES;
    
    myLabel.text = strContent;

    NSString* url1 = @"www.dierenbeschermingcuracao.com";
    NSString* url11 = @"http://www.dierenbeschermingcuracao.com";
    [myLabel addLinkToURL:[NSURL URLWithString:url11] withRange:[strContent rangeOfString:url1]];
    [myLabel sizeToFit];
    [_vSub addSubview:myLabel];
}

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url {
    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
}


-(IBAction) onBtnClick:(id)sender {
   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.sportential.com"]
                                      options:@{}
                            completionHandler:nil];;
}



#pragma mark -
#pragma mark - Memory Mgmt

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
