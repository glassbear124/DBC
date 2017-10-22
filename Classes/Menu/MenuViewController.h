//
//  MenuViewController.h
//  Tinder
//
//  Created by Rahul Sharma on 29/11/13.
//  Copyright (c) 2013 3Embed. All rights reserved.
//

#import "BaseVC.h"
#import "PPRevealSideViewController.h"

@interface MenuViewController : BaseVC<PPRevealSideViewControllerDelegate,UIActionSheetDelegate>
{
    IBOutlet UIButton *btnStart;    
    IBOutlet UIButton *btnFavorite;
    IBOutlet UIButton *btnOrganization;
    IBOutlet UIButton *btnAccount;
    IBOutlet UIButton *btnAboutUs;
    IBOutlet UIButton *btnSponsers;
    IBOutlet UIButton *btnContatcUs;
    IBOutlet UIButton *btnLogout;
}


-(IBAction)btnAction:(id)sender;

@end
