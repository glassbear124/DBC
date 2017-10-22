
#import "AccountVC.h"
#import "ChangePassVC.h"
#import "UIImageView+WebCache.h"
#import "Base64.h"


@interface AccountVC ()

@end

@implementation AccountVC

-(void) API_ChangeAvatar : (UIImage*)img {
    
    NSMutableDictionary *dictParam=[[NSMutableDictionary alloc]init];
    [dictParam setObject:gUser.apikey forKey:@"apikey"];

    AFNHelper *afn=[[AFNHelper alloc]init];
    [afn getDataFromPath:@"apis/profile/change_avatar" withParamDataImage:dictParam andImage:img withBlock:^(id response, NSError *error) {
        if (response) {
            if ([[response objectForKey:@"errorcode"] intValue]==0) {
                NSDictionary* dic = [response objectForKey:@"result"];
                NSString* strPath = [dic objectForKey:@"avatar"];
                [_imgAvatar setImageWithURL:[NSURL URLWithString:strPath]];
                [_vLayer removeFromSuperview];
            }
        }
    }];
}

-(void) API_SaveProfile {
    NSMutableDictionary *dictParam=[[NSMutableDictionary alloc]init];
    [dictParam setObject:gUser.apikey forKey:@"apikey"];
    [dictParam setObject:_fldFirstName.text forKey:@"first_name"];
    [dictParam setObject:_fldLastName.text forKey:@"last_name"];
    [dictParam setObject:_fldEmail.text forKey:@"email"];
    [dictParam setObject:_fldPhone.text forKey:@"phone"];
    NSMutableURLRequest* request = [Service parseMethod:@"apis/profile/edit" withParams:dictParam];
    
    [APPDELEGATE showProgress:self.view];
    WebServiceHandler* handler = [[WebServiceHandler alloc] init];
    handler.requestType = eParseKey;
    [handler placeWebserviceRequestWithString:request Target:self Selector:@selector(SaveProfile:)];
}

-(void) SaveProfile: (NSDictionary*)_response {
    [APPDELEGATE dismiss];
    if (_response == nil) {
        ;
    }
    else
    {
        gUser.first_name = _fldFirstName.text;
        gUser.last_name = _fldFirstName.text;
        gUser.email = _fldEmail.text;
        gUser.phone = _fldPhone.text;
        
        [self editState:false];
    }
}


#pragma mark -
#pragma mark - Init

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark -
#pragma mark - ViewLife Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpAllViews];
    
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


-(void)setUpAllViews
{
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBarHidden = NO;
    [APPDELEGATE addBackButton:self.navigationItem];
    
    UIImage *imgButton = [UIImage imageNamed:@"change_password.png"];
    UIButton *rightbarbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightbarbutton setBackgroundImage:imgButton forState:UIControlStateNormal];
    [rightbarbutton setFrame:CGRectMake(0, 0, 30, 30)];
    [rightbarbutton addTarget:self action:@selector(clickedRightButton) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightbarbutton];
    
    [self.navigationItem setTitle:self.title];
    
    _imgAvatar.layer.borderColor = [UIColor whiteColor].CGColor;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected)];
    singleTap.numberOfTapsRequired = 1;
    _imgAvatar.userInteractionEnabled = YES;
    [_imgAvatar addGestureRecognizer:singleTap];
    
    
    if( nCurLang == LangPap ) {
        [_btnEditSave setTitle:@"Kambia" forState:UIControlStateNormal];
        [_btnCancel setTitle:@"Kansela" forState:UIControlStateNormal];
        
        _fldFirstName.placeholder = @"Nomber";
        _fldLastName.placeholder = @"Fam";
        _fldPhone.placeholder = @"Number di telefon";
        
    } else if( nCurLang == LangNed ) {
        [_btnEditSave setTitle:@"Bewerk" forState:UIControlStateNormal];
        [_btnCancel setTitle:@"Annuleren" forState:UIControlStateNormal];
        
        _fldFirstName.placeholder = @"Voornaam";
        _fldLastName.placeholder = @"Achternaam";
        _fldPhone.placeholder = @"Telefoonnummer";
    }
    // "e-mail", "save" is same string
    
    if( gUser != nil ) {
        _lblID.text = gUser.username;
        _fldFirstName.text = gUser.first_name;
        _fldLastName.text = gUser.last_name;
        _fldPhone.text = gUser.phone;
        _fldEmail.text = gUser.email;
        [_imgAvatar setImageWithURL:[NSURL URLWithString:gUser.avatar]];
    }
    
    [self editState:false];
    
    _vSep1.frame = CGRectMake(_vSep1.frame.origin.x, _vSep1.frame.origin.y, _vSep1.frame.size.width, 0.5f);
    _vSep2.frame = CGRectMake(_vSep2.frame.origin.x, _vSep2.frame.origin.y, _vSep2.frame.size.width, 0.5f);
    _vSep3.frame = CGRectMake(_vSep3.frame.origin.x, _vSep3.frame.origin.y, _vSep3.frame.size.width, 0.5f);
}

-(void) clickedRightButton {
    ChangePassVC* vc = [[ChangePassVC alloc] initWithNibName:@"ChangePassVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)tapDetected{
    [self.view addSubview:_vLayer];
    NSLog( @"Tap!!!" );
}

-(void) editState:(bool)isEdit {
    
    UITextBorderStyle borderStyle = UITextBorderStyleNone;
    if( isEdit == true ) {
        borderStyle = UITextBorderStyleRoundedRect;
    }
    
    _fldFirstName.borderStyle = _fldLastName.borderStyle = borderStyle;
    _fldEmail.borderStyle = borderStyle;
    _fldPhone.borderStyle = borderStyle;
    
    _fldFirstName.enabled = _fldLastName.enabled = isEdit;
    _fldEmail.enabled = isEdit;
    _fldPhone.enabled = isEdit;
    
    _imgRefresh.hidden = !isEdit;
    _btnCancel.hidden = !isEdit;
    
    _btnEditSave.selected = isEdit;
}


-(IBAction) onBtnClick:(id)sender {
    if( sender == _btnEditSave ) {
        if( _btnEditSave.selected == false )
            [self editState:!_btnEditSave.selected];
        else {
            [self API_SaveProfile];
        }
    } else if( sender == _btnCancel ){
        [self editState:false];
    } else if( sender == _btnClose ) {
        [_vLayer removeFromSuperview];
    } else if( sender == _btnGallery ) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:picker animated:YES completion:NULL];
    } else if( sender == _btnCamera ) {
        
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            return;
        }
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:NULL];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    
    CGFloat h = chosenImage.size.height * (300/chosenImage.size.width);
    UIImage* newImg = [self imageWithImage:chosenImage scaledToSize:CGSizeMake(300, h)];
    
    [self API_ChangeAvatar:newImg];
//    _imgAvatar.image = newImg;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}







- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if( textField == _fldFirstName )
        [_fldLastName becomeFirstResponder];
    else if( textField == _fldLastName )
        [_fldEmail becomeFirstResponder];
    else
        [textField resignFirstResponder];
    return true;
}

#pragma mark -
#pragma mark - Memory Mgmt

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
