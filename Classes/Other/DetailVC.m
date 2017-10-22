
#import "DetailVC.h"
#import "InfoVC.h"
#import "UIImageView+WebCache.h"

@interface DetailVC ()

@end

@implementation DetailVC
{
    NSArray* arrList;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpAllViews];
    
    arrList = @[@"icn_user.png", @"icn_pin.png", @"icn_phone.png", @"icn_phone.png", @"icn_email.png"];
    
    
}

-(void)setUpAllViews
{
    _imgAvatar.layer.borderColor = [UIColor whiteColor].CGColor;
    _tblList.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.navigationController.navigationBarHidden = YES;
    
    [_imgAvatar setImageWithURL:[NSURL URLWithString:_org.logo]];
    _lblTitle.text = _org.name;
}

-(IBAction) onBtnClick:(id)sender {
    if( sender == _btnBack ) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    int ix = (int)indexPath.row;
    
    UIImage* img = [UIImage imageNamed:arrList[ix]];
    cell.imageView.image = img;
    CGFloat widthScale = 30 / img.size.width;
    CGFloat heightScale = 30 / img.size.height;
    cell.imageView.transform = CGAffineTransformMakeScale(widthScale, heightScale);
    cell.layer.backgroundColor = [UIColor clearColor].CGColor;
    
    cell.backgroundColor = [UIColor clearColor];
    
    
    switch (ix) {
        case 0: cell.textLabel.text = _org.contact_pers;
            break;
        case 1: cell.textLabel.text = _org.address;
            break;
        case 2: cell.textLabel.text = _org.tel1;
            break;
        case 3: cell.textLabel.text = _org.tel2;
            break;
        case 4: cell.textLabel.text = _org.email;
            break;
            
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* str;
    switch (indexPath.row) {
        case 0:
            break;
        case 1:
            break;
        case 2: //cell.textLabel.text = _org.tel1;
            str = [NSString stringWithFormat:@"tel:%@", _org.tel1];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{} completionHandler:nil];
            break;
        case 3:// cell.textLabel.text = _org.tel2;
            str = [NSString stringWithFormat:@"tel:%@", _org.tel2];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{} completionHandler:nil];
            break;
        case 4: //cell.textLabel.text = _org.email;
            if ([MFMailComposeViewController canSendMail]) {
                MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
                mailer.mailComposeDelegate = self;
                [mailer setSubject:@""];
                NSArray *toRecipients = [NSArray arrayWithObjects:_org.email, nil];
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

            break;
            
        default:
            break;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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


#pragma mark -
#pragma mark - Memory Mgmt

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
