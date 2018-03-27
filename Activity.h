
#import <Foundation/Foundation.h>

@interface Activity : NSObject

@property (nonatomic, copy) NSString *activityName;
@property (nonatomic, copy) NSString *activityDescription;
@property (nonatomic, copy) NSString *activityPlace;
@property (nonatomic, copy) NSString *activityPhone;
@property (nonatomic, copy) NSString *activityMail;
@property (nonatomic, copy) NSDate *inicialData;
@property (nonatomic, assign) int identifier;
@property (nonatomic, copy) NSDate *finalData;
-(id)initWithName:(NSString *)aName andDescription:(NSString *)aDescription andPlace:(NSString *)aPlace andPhone:(NSString *)aPhone andMail: (NSString *) aMail andInicialData:(NSDate *)aInicalData andFinalData:(NSDate *)aFinalData andId:(NSInteger )aIdentifier;


@end
