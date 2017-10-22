//
//  User.h
//  Tinder
//
//  Created by Elluminati - macbook on 07/05/14.
//  Copyright (c) 2014 AppDupe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
{
    
}

@property (nonatomic, retain) NSString *apikey;
@property (nonatomic, retain) NSString *avatar;
@property (nonatomic, retain) NSString *first_name;
@property (nonatomic, retain) NSString *last_name;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString* phone;

@property (nonatomic, retain) NSString* username;

@property(nonatomic,copy)NSString *fbid;
@property(nonatomic,copy)NSString *sex;
@property(nonatomic,copy)NSString *push_token;
@property(nonatomic,copy)NSString *curr_lat;
@property(nonatomic,copy)NSString *curr_long;
@property(nonatomic,copy)NSString *dob;


@property(nonatomic,assign)int flag;

+(User *)currentUser;
-(void)setUser;

-(bool) read:(NSDictionary*) dic;

@end
