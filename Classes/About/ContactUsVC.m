
#import "ContactUsVC.h"
#import "AllConstants.h"

@interface ContactUsVC ()

@end

@implementation ContactUsVC

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
    [APPDELEGATE addBackButton:self.navigationItem];
    [self.navigationItem setTitle:self.title];
    self.revealSideViewController.delegate = self;
}


-(void) viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self setUpAllViews];
}

-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

-(void)setUpAllViews
{
    NSString* strContent;
    NSString* phone1;
    NSString* phone2;


    if( nCurLang == LangEng ) {
        strContent = @"Stichting Dierenbescherming Curaçao\n"
            "Abattoirweg 7, Parera\n"
            "Postbus 4456"
            "\n\n"
            "+5999 465 4307 (office)\n"
            "+5999 465 4300 (shelter)"
            "\n\n"
            "info@dierenbeschermingcuracao.com\n"
            "www.dierenbeschermingcuracao.com\n"
            "www.facebook.com/dierenbeschermingcuracao\n"
            "\n\n"
            "For donations:\n"
            "MCB 28449007\n"
            "RBC 1241184\n"
            "Giro 1114493\n"
            "ING Leeuwarden NL33INGB0004270530"
            "\n\n";
        
        phone1 = @"+5999 465 4307 (office)";
        

    
    } else if( nCurLang == LangPap ) {
        strContent = @"Stichting Dierenbescherming Curaçao\n"
        "Abattoirweg 7, Parera\n"
        "Postbus 4456"
        "\n\n"
        "+5999 465 4307 (ofisina)\n"
        "+5999 465 4300 (shelter)"
        "\n\n"
        "info@dierenbeschermingcuracao.com\n"
        "www.dierenbeschermingcuracao.com\n"
        "www.facebook.com/dierenbeschermingcuracao"
        "\n\n"
        "Pa donashon:\n"
        "MCB 28449007\n"
        "RBC 1241184\n"
        "GIRO 1114493\n"
        "ING Leeuwarden NL33INGB0004270530"
        "\n\n";
        
        phone1 = @"+5999 465 4307 (ofisina)";
        
    } else {
        strContent = @"Stichting Dierenbescherming Curaçao\n"
        "Abattoirweg 7, Parera\n"
        "Postbus 4456"
        "\n\n"
        "+5999 465 4307 (kantoor)\n"
        "+5999 465 4300 (shelter)"
        "\n\n"
        "info@dierenbeschermingcuracao.com\n"
        "www.dierenbeschermingcuracao.com\n"
        "www.facebook.com/dierenbeschermingcuracao"
        "\n\n"
        "Voor donaties:\n"
        "MCB 28449007\n"
        "RBC 1241184\n"
        "Giro 1114493\n"
        "ING Leeuwarden NL33INGB0004270530"
        "\n\n";
        
        phone1 = @"+5999 465 4307 (kantoor)";
    }

    TTTAttributedLabel *myLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
    
    myLabel.numberOfLines = 0;
    myLabel.textColor = my_color;
    myLabel.textAlignment = NSTextAlignmentCenter;
    myLabel.font = [UIFont systemFontOfSize:14];
    
    
    CGSize s = _vSub.frame.size;
    myLabel.frame = CGRectMake(0,0, s.width, s.height);
    
    myLabel.linkAttributes = @{(id)kCTForegroundColorAttributeName: [UIColor blueColor],
                               (id)kCTUnderlineStyleAttributeName : [NSNumber numberWithInt:NSUnderlineStyleSingle]};
    myLabel.text = strContent;
    myLabel.delegate = self;
    myLabel.userInteractionEnabled=YES;

    NSString* url1 = @"www.dierenbeschermingcuracao.com";
    NSString* url2 = @"www.facebook.com/dierenbeschermingcuracao";
    
    NSString* url11 = @"http://www.dierenbeschermingcuracao.com";
    NSString* url22 = @"http://www.facebook.com/dierenbeschermingcuracao";
    NSString* email = @"info@dierenbeschermingcuracao.com";
    
    [myLabel addLinkToURL:[NSURL URLWithString:url11] withRange:[strContent rangeOfString:url1]];
    [myLabel addLinkToURL:[NSURL URLWithString:url22] withRange:[strContent rangeOfString:url2]];
    [myLabel addLinkToURL:[NSURL URLWithString:email] withRange:[strContent rangeOfString:email]];
    
    phone2 = @"+5999 465 4300 (shelter)";
    [myLabel addLinkToPhoneNumber:@"telprompt:+59994654307" withRange:[strContent rangeOfString:phone1]];
    [myLabel addLinkToPhoneNumber:@"telprompt:+59994654300" withRange:[strContent rangeOfString:phone2]];
    
    [_vSub addSubview:myLabel];
}

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url {
    
    NSString* str = [url absoluteString];
    if( [self NSStringIsValidEmail:str] == true ) {
        
        if ([MFMailComposeViewController canSendMail]) {
            MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
            mailer.mailComposeDelegate = self;
            [mailer setSubject:@""];
            NSArray *toRecipients = [NSArray arrayWithObjects:str, nil];
            [mailer setToRecipients:toRecipients];
            NSString *emailBody = @"";
            [mailer setMessageBody:emailBody isHTML:NO];
            mailer.navigationBar.barStyle = UIBarStyleBlackOpaque;
            [self presentViewController:mailer animated:YES completion:nil];
        }
        else
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Failure" message:@"Your device doesn't support the composer sheet" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    } else {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }
}


- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved: you saved the email message in the drafts folder.");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
            break;
        default:
            NSLog(@"Mail not sent.");
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)attributedLabel:(TTTAttributedLabel *)label
didSelectLinkWithPhoneNumber:(NSString *)phoneNumber {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber] options:@{} completionHandler:nil];
}

#pragma mark -
#pragma mark - Memory Mgmt

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
