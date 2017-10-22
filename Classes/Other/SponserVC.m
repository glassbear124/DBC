
#import "SponserVC.h"
#import "Sponser.h"
#import "SponserCell.h"
#import "UIImageView+WebCache.h"

@interface SponserVC ()
{
    NSMutableArray* arrGoldList;
    NSMutableArray* arrPlatList;
    
    UIImageView* imgPlat;
    UIImageView* imgGold;
    
    int nHeightCnt;
    bool isLoad;
    
}
@end

@implementation SponserVC

-(void) API_getSponser {
    
    NSMutableDictionary *dictParam=[[NSMutableDictionary alloc]init];
    [dictParam setObject:gUser.apikey forKey:@"apikey"];
    NSMutableURLRequest* request = [Service parseMethod:@"apis/sponsers" withParams:dictParam];
    
    [APPDELEGATE showProgress:self.view];
    WebServiceHandler* handler = [[WebServiceHandler alloc] init];
    handler.requestType = eParseKey;
    [handler placeWebserviceRequestWithString:request Target:self Selector:@selector(LoadFevorite:)];
}


-(void) LoadFevorite: (NSDictionary*)_response {
    
    if (_response == nil) {
        ;
    }
    else
    {
        [APPDELEGATE dismiss];
        [arrGoldList removeAllObjects];
        [arrPlatList removeAllObjects];
        
        NSMutableArray* arr = (NSMutableArray*)_response;
        for( NSDictionary* dic in arr ) {
            Sponser* sponser = [[Sponser alloc] init];
            [sponser read:dic];
            
            if( sponser.image != nil && sponser.image.length > 0 ) {
                NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:sponser.image]];
                sponser.imgData = [UIImage imageWithData:imageData];
            } else {
                sponser.imgData = nil;
            }
            
            if( [sponser.type isEqualToString:@"gold"] )
                [arrGoldList addObject:sponser];
            else
                [arrPlatList addObject:sponser];
        }
        [_tblList reloadData];
        nHeightCnt = 0;
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
    
    arrGoldList = [[NSMutableArray alloc] init];
    arrPlatList = [[NSMutableArray alloc] init];
    
    isLoad = false;
    self.revealSideViewController.delegate = self;
    [self API_getSponser];
}

-(void) viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

#define img_w 80
#define img_h 70
#define line_w 140


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 110)];
    
    CGFloat initY = 20;
    UIImageView* imgView;
    if( section == 0 )
        imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"platinum.png"]];
    else
        imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gold.png"]];
    imgView.frame = CGRectMake( (tableView.frame.size.width-img_w)/2, 20, img_w, img_h);
    initY += img_h;
    [view addSubview:imgView];

    initY += 3;
    UIView* v1= [[UIView alloc] initWithFrame:CGRectMake((tableView.frame.size.width-line_w)/2, initY, line_w, 0.5)];
    v1.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:v1];
    
    view.backgroundColor = [UIColor clearColor];
    
    return view;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 110;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Sponser* sponser;
    if( indexPath.section == 0 )
        sponser = [arrPlatList objectAtIndex:indexPath.row];
    else
        sponser = [arrGoldList objectAtIndex:indexPath.row];
    
    if( sponser.imgData != nil ) {
        CGFloat w = [UIScreen mainScreen].bounds.size.width - 60;
        CGFloat h = (w/sponser.imgData.size.width) * sponser.imgData.size.height + 10;
        return h;
    }
    else
        return 60;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if( section == 0 )
        return [arrPlatList count];
    else
        return [arrGoldList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SponserCell";
    SponserCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SponserCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    Sponser* sponser;
    if( indexPath.section == 0 )
        sponser = [arrPlatList objectAtIndex:indexPath.row];
    else
        sponser = [arrGoldList objectAtIndex:indexPath.row];
    
    if( sponser.imgData != nil ) {
        
        cell.lblTitle.hidden = YES;
        cell.imgAvatar.image = sponser.imgData;
        nHeightCnt++;
        if( nHeightCnt == [arrPlatList count] + [arrGoldList count]) {
            [APPDELEGATE dismiss];
            isLoad = true;
            [_tblList reloadData];
        }
    }
    else {
        cell.lblTitle.text = sponser.text;
        cell.imgAvatar.hidden = YES;
    }
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    Sponser* sponser;
    if( indexPath.section == 0 )
        sponser = [arrPlatList objectAtIndex:indexPath.row];
    else
        sponser = [arrGoldList objectAtIndex:indexPath.row];
    
    NSURL* url = [NSURL URLWithString:sponser.link];
    if( url == nil ) {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        return;
    }
    
    [[UIApplication sharedApplication] openURL:url];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark -
#pragma mark - Memory Mgmt

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
