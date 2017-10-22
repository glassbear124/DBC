
#import "BaseVC.h"
#import "PPRevealSideViewController.h"

@interface SponserVC : BaseVC<PPRevealSideViewControllerDelegate, UITableViewDelegate, UITableViewDataSource>

@property(weak,nonatomic)IBOutlet UITableView *tblList;

@end
