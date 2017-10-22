//
//  Speak.h
//  Tinder
//
//  Created by Elluminati - macbook on 25/04/14.
//  Copyright (c) 2014 AppDupe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Sponser : NSObject

@property(nonatomic, assign) int sponser_id;
@property(nonatomic, retain) NSString* type;
@property(nonatomic, retain) NSString* image;
@property(nonatomic, retain) NSString* link;
@property(nonatomic, retain) NSString* text;

@property(nonatomic, assign) CGFloat height;
@property(nonatomic, retain) UIImage* imgData;

-(void) read:(NSDictionary *)dict;

@end
