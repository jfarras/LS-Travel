#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Travel : NSObject
@property (nonatomic, copy) NSString *travelType;//0-priv,1-shared,2-follow
@property (nonatomic, copy) NSString *Travelname;
@property (nonatomic, copy) NSString *TravelPlace;
@property (nonatomic, copy) NSDate *inicialData;
@property (nonatomic, copy) NSDate *finalData;
@property (nonatomic, assign) int Id;

//
@property (nonatomic, copy) NSMutableArray *activities;
-(id)initWithType:(NSString *)aType andName:(NSString *)aName andPlace:(NSString *)aPlace andInicialData:(NSDate *)aInicalData andFinalData:(NSDate *)aFinalData andId:(int)aID andActivities:(NSMutableArray *)activities;


@end
