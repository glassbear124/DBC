

#import <Foundation/Foundation.h>

@interface Organization : NSObject

@property(nonatomic,copy)NSString *org_id;
@property(nonatomic,copy)NSString *logo;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *contact_pers;

@property(nonatomic,copy)NSString *email;
@property(nonatomic,copy)NSString *tel1;
@property(nonatomic,copy)NSString *tel2;
@property(nonatomic,copy)NSString *address;

@property(nonatomic,assign)int animal_count;


-(void) read:(NSDictionary *)dic;

@end
