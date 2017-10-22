
#import "BaseVC.h"
#import "PPRevealSideViewController.h"



@interface ChangePassVC : UIViewController <UITextFieldDelegate>


@property(weak,nonatomic)IBOutlet UIButton *btnReset;
@property(weak,nonatomic)IBOutlet UITextField *fldPass;
@property(weak,nonatomic)IBOutlet UITextField *fldConfirm;


@end
