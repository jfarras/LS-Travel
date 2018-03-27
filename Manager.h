#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "User.h"
#import "Activity.h"
#import "Travel.h"

@class Manager;
@protocol ManagerDelegate <NSObject>

@optional
-(void) didFinishLogin:(Manager* )manager withResponse:(id)information;
-(void) didFinishCompartir:(Manager* )manager withResponse:(id)information;
-(void) didFinishRegister:(Manager *)manager withResponse:(id)information;
-(void) didGetUsers:(Manager *)manager withResponse:(NSDictionary *)information;
-(void) didAddTravel:(Manager *)manager withResponse:(id)information;
-(void) didGetUserInfo:(Manager *)manager withResponse:(id)information;
-(void) didRemoveTravel:(Manager *)manager withResponse:(id)information;
-(void) didAddActivity:(Manager *)manager withResponse:(id)information;
-(void) didGetUserActivities:(Manager *)manger withResponse:(id)information;
-(void) didRecovery:(Manager *)manger withResponse:(id)information;
-(void) didAddImage:(Manager *)manger withResponse:(id)information;

@end


@interface Manager : NSObject <NSURLConnectionDataDelegate>

@property (nonatomic, weak) id<ManagerDelegate> delegate;


+(id)sharedInstance;

-(void)updateTrip:(User *)aUser andTravel:(Travel *)aTravel;
-(void)loginWithUser:(User*)aUser;
-(void)registerUser:(User *)aUser;
-(void) shareTrip:(User *)aUser aTravel: (Travel *)aTravel andIndex : (int)index;
-(void) getUsers;
-(void) addTravel:(Travel *)aTravel andUser:(User *)aUser;
-(void) getUserInfo:(User *)aUser;
-(void) getUserActivities:(User *)aUser;
-(void) removeTravel:(Travel * )aTravel andUser:(User *)aUser;
-(void) addActivity:(Activity *)aActivity andUser:(User *)aUser andId:(NSString *)aId;
-(void) recovery:(NSString *)mail;
-(void) removeImage:(User *) aUser andId:(NSInteger)atravelId andImageId:(int) aImgId;
-(void) addImage:(User *)aUser andId: (NSInteger )atravelId andName:(NSString *)aName andImg:(NSString *) aImg;
-(void) removeImage:(User *)aUser andId: (NSInteger )atravelId andImg:(int) aImg;
-(void)removeActivity:(Activity *)aActivity andUser:(User *)aUser andId:(NSString *)aId;
@end
