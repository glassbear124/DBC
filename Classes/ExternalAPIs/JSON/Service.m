//
//  Service.m
//  Tinder
//
//  Created by Rahul Sharma on 04/12/13.
//  Copyright (c) 2013 3Embed. All rights reserved.
//

#import "Service.h"
#import "TinderSericeUtils.h"

@implementation Service

+(NSURL*)getURLForMethod:(NSString*)method
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", baseUrl, method]];
}

+(NSMutableURLRequest*)createURLRequestFor:(NSString*)method withData:(NSData*)postData
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[self getURLForMethod:method]];
     
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];

  
        NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
   
    
    return request;
}

+(NSMutableURLRequest *)parseMethod:(NSString*)method withParams:(NSDictionary *)params
{
    NSString *strRequestParm = [TinderSericeUtils paramDictionaryToString:params];
    
    NSData *postData = [strRequestParm dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSMutableURLRequest *request = [self createURLRequestFor:method withData:postData];
    
    return request;
}


+(void) API_setFlag:(int)petID :(int)flag {
    
    // like:1 unlike: 0, -1: delete from like
    NSMutableDictionary *dictParam=[[NSMutableDictionary alloc]init];
    [dictParam setObject:gUser.apikey forKey:@"apikey"];
    [dictParam setObject:[NSString stringWithFormat:@"%d", petID] forKey:@"animal_id"];
    [dictParam setObject:[NSString stringWithFormat:@"%d", flag] forKey:@"flag"];
    NSMutableURLRequest* request = [self parseMethod:@"apis/animals/flag" withParams:dictParam];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request] resume];
}

-(void) non:(NSDictionary*) dic {
    
}


+(NSMutableURLRequest *)parseLogin :(NSDictionary *)params
{
    NSString *strRequestParm = [TinderSericeUtils paramDictionaryToString:params];

    NSData *postData = [strRequestParm dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSMutableURLRequest *request = [self createURLRequestFor:METHOD_LOGIN withData:postData];
    
    return request;
}



+(NSMutableURLRequest *)parseGetUserProfile :(NSDictionary *)params{
    
    NSString *strRequestParm = [TinderSericeUtils paramDictionaryToString:params];

    NSData *postData = [strRequestParm dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSMutableURLRequest *request = [self createURLRequestFor:METHOD_GETPROFILE withData:postData];
    
    return request;
   
}

+(NSMutableURLRequest *)parseGetUpdatePrefrences :(NSDictionary *)params{

    NSString *strRequestParm = [TinderSericeUtils paramDictionaryToString:params];
    
    NSData *postData = [strRequestParm dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSMutableURLRequest *request = [self createURLRequestFor:METHOD_UPDATEPREFERENCES withData:postData];
    
    return request;
   
}
+(NSMutableURLRequest *)parseLogOut :(NSDictionary *)params{
    
    NSString *strRequestParm = [TinderSericeUtils paramDictionaryToString:params];
    
    NSData *postData = [strRequestParm dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSMutableURLRequest *request = [self createURLRequestFor:METHOD_LOGOUT withData:postData];
    
    return request;
    
}
+(NSMutableURLRequest *)parseDeleteAccount :(NSDictionary *)params{
    
    NSString *strRequestParm = [TinderSericeUtils paramDictionaryToString:params];
    
    NSData *postData = [strRequestParm dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSMutableURLRequest *request = [self createURLRequestFor:METHOD_DELETEACCOUNT withData:postData];
    
    return request;
    
}

+(NSMutableURLRequest *)parseEditProfile :(NSDictionary *)params{
    
    NSString *strRequestParm = [TinderSericeUtils paramDictionaryToString:params];
    
    NSData *postData = [strRequestParm dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSMutableURLRequest *request = [self createURLRequestFor:METHOD_EDITPROFILE withData:postData];
    
    return request;
    
}

+(NSMutableURLRequest *)parseGetFindMatches :(NSDictionary *)params
{
    
    NSString *strRequestParm = [TinderSericeUtils paramDictionaryToString:params];

    NSData *postData = [strRequestParm dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSMutableURLRequest *request = [self createURLRequestFor:METHOD_FINDMATCHES withData:postData];
    
    return request;
    
}

+(NSMutableURLRequest *)parseInviteAction :(NSDictionary *)params
{
    
    NSString *strRequestParm = [TinderSericeUtils paramDictionaryToString:params];
    
    NSData *postData = [strRequestParm dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSMutableURLRequest *request = [self createURLRequestFor:METHOD_INVITEACTION withData:postData];
    
    return request;
}


@end
