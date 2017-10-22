
#import "BaseVC.h"

#import "PPRevealSideViewController.h"
#import "TinderAppDelegate.h"
//#import <FacebookSDK/FBSessionTokenCachingStrategy.h>
//#import <FacebookSDK/FacebookSDK.h>
//#import "TinderFBFQL.h"

#import "DraggableViewBackground.h"

@interface HomeViewController : BaseVC<PPRevealSideViewControllerDelegate, DraggableViewBackgroundDelegate>
{
    NSString * strProfileUrl;
    int flag;
    IBOutlet UILabel *lblNoFriendAround;
    IBOutlet UIView  *vCategory;
    
    IBOutlet UILabel *lblContent;
    IBOutlet UIView *vGroup;
    IBOutlet UIButton *btnDog;
    IBOutlet UIButton *btnCat;

}

-(void) clickInfo:(UIView *)card;

@end
