
//
//  HomeViewController.m
//  Tinder
//
//  Created by Rahul Sharma on 24/11/13.
//  Copyright (c) 2013 3Embed. All rights reserved.
//

#import "HomeViewController.h"

#import <QuartzCore/QuartzCore.h>
#import "RoundedImageView.h"

#import "UIImageView+WebCache.h"
#import "SDWebImageDownloader.h"

#import "TinderGenericUtility.h"
#import "MenuViewController.h"

#import "InfoVC.h"

@interface HomeViewController ()
{
    DraggableViewBackground *draggableBackground;
    NSMutableArray* arrList;
}

@end

@implementation HomeViewController

-(void) API_Reset {
    
    lblNoFriendAround.hidden = YES;
    draggableBackground.hidden = YES;
    
    NSMutableDictionary *dictParam=[[NSMutableDictionary alloc]init];
    [dictParam setObject:gUser.apikey forKey:@"apikey"];
    NSMutableURLRequest* request = [Service parseMethod:@"apis/animals/reset" withParams:dictParam];
    
    [APPDELEGATE showProgress:self.view];
    
    WebServiceHandler* handler = [[WebServiceHandler alloc] init];
    handler.requestType = eParseKey;
    [handler placeWebserviceRequestWithString:request Target:self Selector:@selector(ResetProc:)];
}

-(void) ResetProc:(NSDictionary*)_response {
    
    if (_response == nil) {
        [APPDELEGATE dismiss];
    } else {
        [self API_GetFeed:false];
    }
}

-(void) API_GetFeed : (bool)isProgress {
    
    lblNoFriendAround.hidden = YES;
    draggableBackground.hidden = YES;
    
    NSMutableDictionary *dictParam=[[NSMutableDictionary alloc]init];
    [dictParam setObject:gUser.apikey forKey:@"apikey"];
    if( nCurLike == LikeDog )
        [dictParam setObject:@"dog" forKey:@"category"];
    else
        [dictParam setObject:@"cat" forKey:@"category"];
    NSMutableURLRequest* request = [Service parseMethod:@"apis/animals/feed" withParams:dictParam];
    
    if( isProgress == true )
        [APPDELEGATE showProgress:self.view];
    
    WebServiceHandler* handler = [[WebServiceHandler alloc] init];
    handler.requestType = eParseKey;
    [handler placeWebserviceRequestWithString:request Target:self Selector:@selector(LoadPets:)];    
}

-(void) LoadPets: (NSDictionary*)_response {
    [APPDELEGATE dismiss];
    
    if (_response == nil) {
        ;
    }
    else
    {
        NSMutableArray* arr = (NSMutableArray*)_response;
        for( NSDictionary* dic in arr ) {
            Pet* pet = [[Pet alloc] init];
            [pet read:dic];
            [arrList addObject:pet];
        }
        [draggableBackground setCard:arrList];
        
        if( arrList.count == 0 ) {
            lblNoFriendAround.hidden = NO;
        }
        else {
            draggableBackground.hidden = NO;
        }
    }
    //    [pi hideProgressIndicator];
}

#pragma mark -
#pragma mark - Init

-(void) clickInfo:(Pet *)pet {
    InfoVC* vc = [[InfoVC alloc] initWithNibName:@"InfoVC" bundle:nil];
    vc.pet = pet;
    [self.navigationController pushViewController:vc animated:YES];    
}

-(void) emptyList {
    lblNoFriendAround.hidden = NO;
    draggableBackground.hidden = YES;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark -
#pragma mark - View cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:vCategory];
    
    vGroup.layer.borderColor = my_color.CGColor;
    
    if( nCurLang == LangNed ) {
        lblContent.text = @"Kies de categorie Honden of Katten:";
        lblNoFriendAround.text = @"Er zijn op dit moment geen nieuwe dieren om uit te kiezen.";
    } else if( nCurLang == LangPap ) {
        lblContent.text = @"Skohe e kategoria Kacho of Pushi:";
        lblNoFriendAround.text = @"Na e momentu aki no tin animal nobo pa skohe.";
    }
    
//    btnDog.enabled = false;
//    btnCat.enabled = false;
//    if( nCurLike == LikeDog )
//        btnCat.enabled = true;
//    else
//        btnDog.enabled = true;
    
    arrList = [[NSMutableArray alloc]init];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBarHidden = NO;
    [APPDELEGATE addBackButton:self.navigationItem];
    [self.navigationItem setTitle:@"Pet Cupid"];
    
    [self.revealSideViewController setDirectionsToShowBounce: PPRevealSideDirectionLeft];
    self.revealSideViewController.delegate = self;
}

-(IBAction) onBtnClick:(id)sender {
    
    if( sender == btnDog ) {
        nCurLike = LikeDog;
    } else if(sender == btnCat ) {
        nCurLike = LikeCat;
    }
    [vCategory removeFromSuperview];
    

    UIImage *imgButton = [UIImage imageNamed:@"reset.png"];
    UIButton *rightbarbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightbarbutton setBackgroundImage:imgButton forState:UIControlStateNormal];
    [rightbarbutton setFrame:CGRectMake(0, 0, 30, 30)];
    [rightbarbutton addTarget:self action:@selector(rightButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightbarbutton];
    

    CGSize s = [UIScreen mainScreen].bounds.size;
    CGRect bg = CGRectMake(0,0, s.width, s.height-44);
    draggableBackground = [[DraggableViewBackground alloc] initWithFrame:bg];
    [self.view addSubview:draggableBackground];
    draggableBackground.delegate = self;

    [self API_GetFeed:true];
    
}


-(void) rightButtonClicked {
    
    NSString* strMsg, *strYes, *strNo;
    if( nCurLang == LangEng ) {
        strMsg = @"Do you want to see all animals again?";
        strYes = @"Yes";
        strNo  = @"No";
    } else if( nCurLang == LangNed) {
        strMsg = @"Wil je alle dieren opnieuw zien?";
        strYes = @"Ja";
        strNo  = @"Nee";
    } else {
        strMsg = @"Bo ke wak tur animal di nobo?";
        strYes = @"Si";
        strNo  = @"No";
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:strMsg
                                                   delegate:self
                                          cancelButtonTitle:strNo
                                          otherButtonTitles:strYes, nil];
    [alert show];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch(buttonIndex) {
        case 0: //"No" pressed
            //do something?
            break;
        case 1:
            [self API_Reset];
            break;
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    PPRevealSideInteractions interContent = PPRevealSideInteractionContentView;
    self.revealSideViewController.panInteractionsWhenClosed = interContent;
    self.revealSideViewController.panInteractionsWhenOpened = interContent;
    [self performSelector:@selector(preloadLeft) withObject:nil afterDelay:0.1];
}

#pragma mark -
#pragma mark - Nav button methods

-(void)preloadLeft
{
    MenuViewController *menu=[[MenuViewController alloc]initWithNibName:@"MenuViewController" bundle:nil];
    [self.revealSideViewController preloadViewController:menu forSide:PPRevealSideDirectionLeft];
    PP_RELEASE(menu);
}

#pragma mark -
#pragma mark - PPRevealSideViewControllerDelegate

- (BOOL) pprevealSideViewController:(PPRevealSideViewController *)controller shouldDeactivateGesture:(UIGestureRecognizer*)gesture forView:(UIView*)view
{
//    if ([view isEqual:draggableBackground] )
//    {
//        return YES;
//    }
//    return NO;
    return YES;
}


#pragma mark -
#pragma mark - Memory Mgmt

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
