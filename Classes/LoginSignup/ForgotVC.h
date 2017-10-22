
#import <UIKit/UIKit.h>

@interface ForgotVC : UIViewController<UITextFieldDelegate>
{
    
}

@property(weak,nonatomic)IBOutlet UIButton *btnForgot;
@property(weak,nonatomic)IBOutlet UIButton *btnBack;

@property (nonatomic, retain) IBOutlet UIView* vEmail;
@property (nonatomic, retain) IBOutlet UITextField* txtEmail;


@end
