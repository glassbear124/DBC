
#import "BaseVC.h"
#import "PPRevealSideViewController.h"
#import "Organization.h"
#import <MessageUI/MessageUI.h>

@interface DetailVC : UIViewController<PPRevealSideViewControllerDelegate, UITableViewDataSource, UITabBarDelegate, MFMailComposeViewControllerDelegate>

@property(weak,nonatomic)IBOutlet UIButton *btnBack;
@property(weak,nonatomic)IBOutlet UIImageView *imgAvatar;
@property(weak,nonatomic)IBOutlet UILabel* lblTitle;

@property(weak,nonatomic)IBOutlet UITableView* tblList;

@property (nonatomic, retain) Organization* org;

@end
