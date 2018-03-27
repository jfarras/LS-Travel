#import <UIKit/UIKit.h>
#import "AddTravelViewController.h"
#import "ViewTravelViewController.h"
#import "ShareTravelTableViewController.h"


@interface TravelTableViewController : UITableViewController <AddTravelViewControllerDelegate, ViewTravelViewControllerDelegate,ManagerDelegate>
-(IBAction)addButtonTouched;
-(IBAction)logOutButtonTouched;
@property (nonatomic, assign) int idPropi;
@property (nonatomic, assign) NSString* nomActu;
@end
