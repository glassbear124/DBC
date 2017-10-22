
#import "BaseVC.h"
#import "PPRevealSideViewController.h"
#import "TTTAttributedLabel.h"

@interface AboutVC : BaseVC<PPRevealSideViewControllerDelegate, TTTAttributedLabelDelegate>

@property(weak,nonatomic)IBOutlet UIView *vSub;


@end
