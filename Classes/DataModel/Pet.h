

#import <Foundation/Foundation.h>

@interface Pet : NSObject

@property (nonatomic, assign) int animal_id;
@property (nonatomic, retain) NSString *category;
@property (nonatomic, retain) NSString *sex;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *age_unit;
@property (nonatomic, retain) NSString *age;
@property (nonatomic, retain) NSString *color;
@property (nonatomic, retain) NSString *size;
@property (nonatomic, retain) NSString *status;
@property (nonatomic, retain) NSString *picture;

-(void) read:(NSDictionary*)dic;
-(NSString*) getSex;
-(NSString*) getAgeUnit;
-(NSString*) getAge;
-(NSString*) getSize;

@end
