#import "Activity.h"

@implementation Activity

-(id)initWithName:(NSString *)aName andDescription:(NSString *)aDescription andPlace:(NSString *)aPlace andPhone:(NSString *)aPhone andMail:(NSString *)aMail andInicialData:(NSDate *)aInicalData andFinalData:(NSDate *)aFinalData andId:(int)aIdentifier{
    
    if (self = [super init]){
        _activityName = aName;
        _activityDescription = aDescription;
        _activityPlace = aPlace;
        _activityPhone = aPhone;
        _activityMail = aMail;
        _inicialData = aInicalData;
        _identifier = aIdentifier;
        _finalData = aFinalData;
    }
    return self;
}
@end
