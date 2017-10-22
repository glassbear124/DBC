//
//  MyCell.h
//  Tinder
//
//  Created by Admin on 9/6/17.
//  Copyright © 2017 AppDupe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCell : UITableViewCell

@property(nonatomic, weak) IBOutlet UIImageView *imgAvatar;
@property(nonatomic, weak) IBOutlet UILabel *lblTitle;
@property(nonatomic, weak) IBOutlet UILabel *lblDetail;

@end
