
#import "SliderVC.h"
#import "HomeViewController.h"

@interface SliderVC ()

@end

@implementation SliderVC

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
    if( nCurLang == LangNed ) {
        [_btnContinue setTitle:@"Doorgaan" forState:UIControlStateNormal];
        _lblContent.text =
        @"Bedankt voor het downloaden van onze app. Op zoek naar een nieuw maatje?"
        "\n\n"
        "Geef asiel dieren een kans want ook zij zijn op zoek naar iemand om lief te hebben! Browse simpelweg door  de profielen en selecteer jouw favoriete dier(en). Heb je een keuze gemaakt? Neem dan contact op met de respectievelijke organisatie* voor een ontmoeting."
        "\n\n"
        "*Stichting Dierenbescherming Curaçao werkt samen met andere locale stichtingen om zoveel mogelijk asiel dieren een tweede kans te geven.";
    } else if( nCurLang == LangPap ) {
        [_btnContinue setTitle:@"Sigui" forState:UIControlStateNormal];
        _lblContent.text =
        @"Danki pa a “download” nos aplikashon. Bo ta buskando un bon amigu nobo?"
        "\n\n"
        "Duna nos bestia nan di asil un oportunidat! Pasó nan tambe ta buskando un hende pa stima. Djis “browse” dor di e aplikashon i selektá bo faborito(nan). Bo ta kere bo a haña esun perfekto? Tuma kontakto ku e organisashon respektivo* pa traha un sita."
        "\n\n"
        "*Stichting Dierenbescherming Curaçao ta kolaborá ku otro organisashonnan lokal pa mas tantu posibel duna bestia nan di asil un di dos oportunidat.";
    }
}

-(IBAction) onBtnClick:(id)sender {
    HomeViewController *home ;    
    home = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    [self.navigationController pushViewController:home animated:YES];
}

#pragma mark -
#pragma mark - Memory Mgmt

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
