#import "User.h"

@implementation User

-(id)initWithName:(NSString *)aName andMail:(NSString *)aMail andPassword:(NSString *)aPassword andId:(NSInteger *)aIdentifier{
    if (self = [super init]){
        _name = aName;
        _userName = aMail;
        _password = aPassword;
        _identifier2 = aIdentifier;
    }
    return self;
}
/*-(id) initWithId:(NSInteger *)aIdentifier andName:(NSString *)aName{
    if (self = [super init]){
        _identifier = aIdentifier;
        _userName = aName;
    }
    return self;
}*/
@end
