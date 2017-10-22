//
//  UserDefaultHelper.h
//  Tinder
//
//  Created by Elluminati - macbook on 10/04/14.
//  Copyright (c) 2014 AppDupe. All rights reserved.
//

#import <Foundation/Foundation.h>

#define USERDEFAULT [NSUserDefaults standardUserDefaults]


@interface UserDefaultHelper : NSObject
{
    NSString *currentLatitude;
    NSString *currentLongitude;
    NSMutableDictionary *facebookUserDetail;
    NSMutableDictionary *facebookLoginRequest;
    NSString *facebookToken;
    BOOL isFirstLaunchForMatchedList;
    NSString *lastMessageText;
    NSString *fbProfileURL;
    
    BOOL isUploaded;
    
    NSString *fbidd;
    NSMutableDictionary *itsMatch;
    NSString *locationDisable;
    NSString *path;
    BOOL block;
    
    NSString *deviceToken;
    
    NSString *uuid;
}
-(id)init;
+(UserDefaultHelper *)sharedObject;

//getter
-(NSString *)currentLatitude;
-(NSString *)currentLongitude;
-(NSMutableDictionary *)facebookUserDetail;
-(NSMutableDictionary *)facebookLoginRequest;
-(NSString *)facebookToken;
-(BOOL)isFirstLaunchForMatchedList;
-(NSString *)lastMessageText;
-(NSString *)fbProfileURL;
-(BOOL)isUploaded;

-(NSString *)fbidd;
-(NSMutableDictionary *)itsMatch;
-(NSString *)locationDisable;
-(NSString *)path;
-(BOOL)block;

-(NSString *)deviceToken;
-(NSString *)uuid;

//setter
-(void)setCurrentLatitude:(NSString *)newLat;
-(void)setCurrentLongitude:(NSString *)newLong;
-(void)setFacebookUserDetail:(NSMutableDictionary *)newFBUserDetail;
-(void)setFacebookLoginRequest:(NSMutableDictionary *)newFBLoginReq;
-(void)setFacebookToken:(NSString *)newFBToken;
-(void)setIsFirstLaunchForMatchedList:(BOOL)newIsFirstLaunchForMatchedList;
-(void)setLastMessageText:(NSString *)newLastMessageText;
-(void)setFBProfileURL:(NSString *)newFBProfileURL;
-(void)setIsUploaded:(BOOL)newIsUploaded;

-(void)setFbidd:(NSString *)newFbidd;
-(void)setItsMatch:(NSMutableDictionary *)newItsMatch;
-(void)setLocationDisable:(NSString *)newLocationDisable;
-(void)setPath:(NSString *)newPath;
-(void)setBlock:(BOOL)newBlock;

-(void)setDeviceToken:(NSString *)newDeviceToken;

-(void)setUUID;

@end
