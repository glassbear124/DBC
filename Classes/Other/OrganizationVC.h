
#import "BaseVC.h"
#import "PPRevealSideViewController.h"

@interface OrganizationVC : UIViewController<PPRevealSideViewControllerDelegate, UITableViewDelegate, UITableViewDataSource>


@property(weak,nonatomic)IBOutlet UITableView *tblList;


@end
