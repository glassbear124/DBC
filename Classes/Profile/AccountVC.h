
#import "BaseVC.h"
#import "PPRevealSideViewController.h"

@interface AccountVC : UIViewController<UITextFieldDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property(weak,nonatomic)IBOutlet UIImageView *imgRefresh;
@property(weak,nonatomic)IBOutlet UIImageView *imgAvatar;
@property(weak,nonatomic)IBOutlet UILabel *lblID;

@property(weak,nonatomic)IBOutlet UIButton *btnCancel;
@property(weak,nonatomic)IBOutlet UIButton *btnEditSave;

@property(weak,nonatomic)IBOutlet UITextField *fldFirstName;
@property(weak,nonatomic)IBOutlet UITextField *fldLastName;
@property(weak,nonatomic)IBOutlet UITextField *fldEmail;
@property(weak,nonatomic)IBOutlet UITextField *fldPhone;


@property (nonatomic, retain) IBOutlet UIView* vLayer;

@property(weak,nonatomic)IBOutlet UIButton *btnGallery;
@property(weak,nonatomic)IBOutlet UIButton *btnCamera;
@property(weak,nonatomic)IBOutlet UIButton *btnClose;

@property(weak,nonatomic)IBOutlet UIView *vSep1;
@property(weak,nonatomic)IBOutlet UIView *vSep2;
@property(weak,nonatomic)IBOutlet UIView *vSep3;

@end
