
#import "BaseVC.h"
#import "PPRevealSideViewController.h"

@interface FevoriteVC : UIViewController<PPRevealSideViewControllerDelegate, UITableViewDelegate, UITableViewDataSource>


@property(weak,nonatomic)IBOutlet UITableView *tblList;
@property(nonatomic, retain) IBOutlet UILabel* lblNoResult;

@end
