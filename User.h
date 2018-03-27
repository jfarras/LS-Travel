#import <UIKit/UIKit.h>

@interface User : NSObject
@property (nonatomic,copy) NSString *name;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, assign) NSInteger * identifier2;
@property (nonatomic, copy) NSMutableArray *travels;
-(id)initWithName:(NSString *)aName andMail:(NSString *)aMail andPassword:(NSString *)aPassword andId:(NSInteger *)aIdentifier;
//-(id)initWithId:(NSInteger *)aIdentifier andName:(NSString *)aName;
@end
