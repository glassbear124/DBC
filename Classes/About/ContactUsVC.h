
#import "BaseVC.h"
#import "PPRevealSideViewController.h"
#import <MessageUI/MessageUI.h>
#import "TTTAttributedLabel.h"

@interface ContactUsVC : BaseVC <TTTAttributedLabelDelegate, PPRevealSideViewControllerDelegate, MFMailComposeViewControllerDelegate>

//@property(weak,nonatomic)IBOutlet TTTAttributedLabel *lblContent;

@property(weak,nonatomic)IBOutlet UIView *vSub;


@end
