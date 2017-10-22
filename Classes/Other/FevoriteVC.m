
#import "FevoriteVC.h"
#import "InfoVC.h"
#import "MyCell.h"
#import "Pet.h"

#import "UIImageView+WebCache.h"
#import "Service.h"


@interface FevoriteVC ()

@end

@implementation FevoriteVC
{
    NSMutableArray* arrList;
}

-(void) API_getFevorite {
    
    NSMutableDictionary *dictParam=[[NSMutableDictionary alloc]init];
    [dictParam setObject:gUser.apikey forKey:@"apikey"];
    NSMutableURLRequest* request = [Service parseMethod:@"apis/animals/favoritos" withParams:dictParam];

    [APPDELEGATE showProgress:self.view];
    WebServiceHandler* handler = [[WebServiceHandler alloc] init];
    handler.requestType = eParseKey;
    [handler placeWebserviceRequestWithString:request Target:self Selector:@selector(LoadFevorite:)];  
}


-(void) LoadFevorite: (NSDictionary*)_response {
    [APPDELEGATE dismiss];
    if (_response == nil) {
        ;
    }
    else
    {
        [arrList removeAllObjects];
        NSMutableArray* arr = (NSMutableArray*)_response;
        for( NSDictionary* dic in arr ) {
            Pet* pet = [[Pet alloc] init];
            [pet read:dic];
            [arrList addObject:pet];
        }
        
        if( [arrList count] == 0 ) {
            _lblNoResult.hidden = NO;
            _tblList.hidden = YES;
        }
        else {
            _lblNoResult.hidden = YES;
            _tblList.hidden = NO;
            [_tblList reloadData];
        }
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

-(void)setUpAllViews
{
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBarHidden = NO;
    [APPDELEGATE addBackButton:self.navigationItem];
    
    [self.navigationItem setTitle:self.title];
    
    _lblNoResult.hidden = YES;
    if( nCurLang == LangNed ) {
        _lblNoResult.text = @"U heeft nog geen dieren geselecteerd als favoriet.";
    } else if( nCurLang == LangPap )
        _lblNoResult.text = @"Bo no a skohe algun animal komo favorito ahinda.";
    
    [self API_getFevorite];
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
    
    Pet* pet = [arrList objectAtIndex:indexPath.row];
    
    NSURL* url = [NSURL URLWithString:pet.picture];
    [cell.imgAvatar setImageWithURL:url];
    cell.lblTitle.text = pet.name;
    cell.lblDetail.text = [pet getSex];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"  ✕  "  handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        //insert your deleteAction here
        
        Pet* pet = [arrList objectAtIndex:indexPath.row];
        [Service API_setFlag:pet.animal_id :-1];
        
        [arrList removeObject:pet];
        if( [arrList count] == 0  ) {
            _lblNoResult.hidden = NO;
        }
        [_tblList reloadData];
    }];
    deleteAction.backgroundColor = [UIColor redColor];
    return @[deleteAction];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {    
    InfoVC* vc = [[InfoVC alloc] initWithNibName:@"InfoVC" bundle:nil];
    Pet* pet = [arrList objectAtIndex:indexPath.row];
    vc.pet = pet;
    [self.navigationController pushViewController:vc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"delete");
    }
}


#pragma mark -
#pragma mark - Memory Mgmt

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
