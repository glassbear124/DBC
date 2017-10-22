
#import "BaseVC.h"
#import "PPRevealSideViewController.h"
#import "Pet.h"

@interface InfoVC : UIViewController

@property(weak,nonatomic)IBOutlet UIImageView *imgPhoto;

@property(weak,nonatomic)IBOutlet UILabel *lblGender;
@property(weak,nonatomic)IBOutlet UILabel *lblAge;
@property(weak,nonatomic)IBOutlet UILabel *lblSize;

@property(weak,nonatomic)IBOutlet UITextView *txtComment;

@property(weak,nonatomic)IBOutlet UIButton *btnAdapt;

@property(weak,nonatomic)IBOutlet UILabel *lblText;


@property (nonatomic, retain) Pet* pet;

@end
