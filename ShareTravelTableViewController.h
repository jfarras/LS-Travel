
#import <UIKit/UIKit.h>
#import "Manager.h"

@class ShareTravelTableViewController;
@protocol ShareTravelTableViewControllerDelegate <NSObject>
-(void)didShareTravel:(ShareTravelTableViewController *)controller  withData:(NSMutableArray *)data;

@end



@interface ShareTravelTableViewController : UITableViewController <ManagerDelegate>

@property (nonatomic, weak) id<ShareTravelTableViewControllerDelegate>delegate;
@property (nonatomic, assign) int num;

-(IBAction)backButtonTouched;
-(IBAction)doneButtonTouched;
-(void)share;

@end
