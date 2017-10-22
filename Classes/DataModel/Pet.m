

#import "Pet.h"
#import "AllConstants.h"

@implementation Pet

-(void)read:(NSDictionary *)dic
{
    _animal_id = [[dic objectForKey:@"animal_id"] integerValue];
    _category = [dic objectForKey:@"category"];
    _sex = [dic objectForKey:@"sex"];
    _name = [dic objectForKey:@"name"];
    _age_unit = [dic objectForKey:@"age_unit"];
    _age = [dic objectForKey:@"age"];
    _color = [dic objectForKey:@"color"];
    _size = [dic objectForKey:@"size"];
    _status = [dic objectForKey:@"status"];
    _picture = [dic objectForKey:@"picture"];
}


-(NSString*) getSex {
    
    if( [_sex isEqualToString:@"male"] == true )
    {
        if( nCurLang == LangEng )
            return @"Male";
        else if( nCurLang == LangNed )
            return @"Reu";
        else
            return @"Macho";
    } else {
        if( nCurLang == LangEng )
            return @"Female";
        else if( nCurLang == LangNed )
            return @"Teef";
        else
            return @"Muhe";
    }
}

-(NSString*) getAge {
    return [NSString stringWithFormat:@"%@ %@", _age, [self getAgeUnit]];
}

-(NSString*) getAgeUnit {
    if( [_age_unit isEqualToString:@"day"] == true)
    {
        if( nCurLang == LangEng )
            return @"days";
        else if( nCurLang == LangNed )
            return @"dagen";
        else
            return @"dia";
    }
    else if( [_age_unit isEqualToString:@"week"] == true)
    {
        if( nCurLang == LangEng )
            return @"weeks";
        else if( nCurLang == LangNed )
            return @"weken";
        else
            return @"siman";
    }
    else if( [_age_unit isEqualToString:@"month"] == true )
    {
        if( nCurLang == LangEng )
            return @"months";
        else if( nCurLang == LangNed )
            return @"maanden";
        else
            return @"luna";
    }
    else {
        if( nCurLang == LangEng )
            return @"years";
        else if( nCurLang == LangNed )
            return @"aña";
        else
            return @"jaren";
    }
}

-(NSString*) getSize {
    if( [_size isEqualToString:@"small"] ) {
        
        if( nCurLang == LangEng )
            return @"Small";
        else if( nCurLang == LangNed )
            return @"Klein";
        else
            return @"Chikitu";
        
    } else if( [_size isEqualToString:@"medium"] ) {
        
        if( nCurLang == LangEng )
            return @"Medium";
        else if( nCurLang == LangNed )
            return @"Middelgroot";
        else
            return @"Mediano";
        
    } else {
        if( nCurLang == LangEng )
            return @"Large";
        else if( nCurLang == LangNed )
            return @"Groot";
        else
            return @"Grandi";
    }
}

@end
