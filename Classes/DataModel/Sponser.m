//
//  Speak.m
//  Tinder
//
//  Created by Elluminati - macbook on 25/04/14.
//  Copyright (c) 2014 AppDupe. All rights reserved.
//

#import "Sponser.h"

@implementation Sponser

-(void) read:(NSDictionary *)dic {
    _sponser_id = [[dic objectForKey:@"sponser_id"] integerValue];
    _type = [dic objectForKey:@"type"];
    _image = [dic objectForKey:@"image"];
    _link = [dic objectForKey:@"link"];
    _text = [dic objectForKey:@"text"];
}

@end
