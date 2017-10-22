
#import "OrganizationVC.h"
#import "DetailVC.h"
#import "Organization.h"
#import "UIImageView+WebCache.h"
#import "MyCell.h"

@interface OrganizationVC ()

@end



@implementation OrganizationVC
{
    NSMutableArray* arrList;
}

-(void) API_getOrganization {
    
    NSMutableDictionary *dictParam=[[NSMutableDictionary alloc]init];
    [dictParam setObject:gUser.apikey forKey:@"apikey"];
    NSMutableURLRequest* request = [Service parseMethod:@"apis/orgs" withParams:dictParam];
    
    [APPDELEGATE showProgress:self.view];
    WebServiceHandler* handler = [[WebServiceHandler alloc] init];
    handler.requestType = eParseKey;
    [handler placeWebserviceRequestWithString:request Target:self Selector:@selector(LoadOrg:)];
}

-(void) LoadOrg: (NSDictionary*)_response {
    [APPDELEGATE dismiss];
    if (_response == nil) {
        ;
    }
    else
    {
        [arrList removeAllObjects];
        NSMutableArray* arr = (NSMutableArray*)_response;
        for( NSDictionary* dic in arr ) {
            Organization* org = [[Organization alloc] init];
            [org read:dic];

            if( [org.name containsString:@"Dierenbescherming"] == true ) {
                [arrList insertObject:org atIndex:0];
            }
            else
                [arrList addObject:org];
        }
        [_tblList reloadData];
    }
}

#pragma mark -
#pragma mark - Init

- (BOOL) pprevealSideViewController:(PPRevealSideViewController *)controller shouldDeactivateGesture:(UIGestureRecognizer*)gesture forView:(UIView*)view
{
    return YES;
}


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
    arrList = [[NSMutableArray alloc] init];
    _tblList.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.revealSideViewController.delegate = self;
    
    [self setUpAllViews];
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

-(void)setUpAllViews
{
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBarHidden = NO;
    [APPDELEGATE addBackButton:self.navigationItem];
    
    [self.navigationItem setTitle:self.title];
    
    [self API_getOrganization];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrList count];    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"MyCell";
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MyCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    Organization* org = [arrList objectAtIndex:indexPath.row];
    
    NSURL* url = [NSURL URLWithString:org.logo];
    [cell.imgAvatar setImageWithURL:url];
    cell.lblTitle.text = org.name;
    cell.lblDetail.text = org.contact_pers;
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {    
    DetailVC* vc = [[DetailVC alloc] initWithNibName:@"DetailVC" bundle:nil];
    vc.org = [arrList objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark -
#pragma mark - Memory Mgmt

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
