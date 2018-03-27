
#import "Travel.h"

@implementation Travel
-(id)initWithType:(NSString *)aType andName:(NSString *)aName andPlace:(NSString *)aPlace andInicialData:(NSDate *)aInicalData andFinalData:(NSDate *)aFinalData andId:(int)aID andActivities:(NSMutableArray *)aActivities {
    if(self = [super init]){
        _travelType = aType;
        _Travelname = aName;
        _TravelPlace = aPlace;
        _inicialData = aInicalData;
        _finalData = aFinalData;
        _Id = aID;
        _activities = aActivities;
        
    }
    return self;
}
@end
