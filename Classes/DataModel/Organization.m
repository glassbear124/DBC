

#import "Organization.h"

@implementation Organization

-(void) read:(NSDictionary *)dic
{
    _org_id = [dic objectForKey:@"org_id"];
    _logo = [dic objectForKey:@"logo"];
    _name = [dic objectForKey:@"name"];
    _contact_pers = [dic objectForKey:@"contact_pers"];
    _email = [dic objectForKey:@"email"];
    _tel1 = [dic objectForKey:@"tel1"];
    _tel2 = [dic objectForKey:@"tel2"];
    
    _address = [dic objectForKey:@"address"];
    _animal_count = [[dic objectForKey:@"animal_count"] integerValue];
}

@end
