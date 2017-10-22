//
//  User.m
//  Tinder
//
//  Created by Elluminati - macbook on 07/05/14.
//  Copyright (c) 2014 AppDupe. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize fbid, sex,push_token,curr_lat,curr_long,dob,flag;

#pragma mark -
#pragma mark - Init

-(id)init{
    
    if((self = [super init]))
    {
        [self setUser];
    }
    return self;
}

-(bool) read:(NSDictionary*) dic {
    
    _email = [dic objectForKey:@"email"];
    _apikey = [dic objectForKey:@"apikey"];
    _avatar = [dic objectForKey:@"avatar"];
    _first_name = [dic objectForKey:@"first_name"];
    _last_name = [dic objectForKey:@"last_name"];
    _phone = [dic objectForKey:@"phone"];
    
    return true;
}

+(User *)currentUser
{
    static User *user = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [[User alloc] init];
    });
    return user;
}


-(void)setUser{
    if([[UserDefaultHelper sharedObject]facebookLoginRequest]!=nil) {
        NSMutableDictionary *dictParam=[[UserDefaultHelper sharedObject] facebookLoginRequest];
        fbid=[dictParam objectForKey:PARAM_ENT_FBID];
        _first_name=[dictParam objectForKey:PARAM_ENT_FIRST_NAME];
        _last_name=[dictParam objectForKey:PARAM_ENT_LAST_NAME];
        sex=[dictParam objectForKey:PARAM_ENT_SEX];
        push_token=[dictParam objectForKey:PARAM_ENT_PUSH_TOKEN];
        curr_lat=[dictParam objectForKey:PARAM_ENT_CURR_LAT];
        curr_long=[dictParam objectForKey:PARAM_ENT_CURR_LONG];
        dob=[dictParam objectForKey:PARAM_ENT_DOB];
        _avatar=[dictParam objectForKey:PARAM_ENT_PROFILE_PIC];
    }
}

@end
