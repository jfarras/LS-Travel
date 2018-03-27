#import <UIKit/UIKit.h>
#import "Travel.h"
#import "ShareTravelTableViewController.h"
#import "ViewTravelViewController.h"

@class AddTravelViewController;
@protocol AddTravelViewControllerDelegate <NSObject>


-(void)didAddTravel:(AddTravelViewController *)controller withData:(Travel *)data;
-(void)didCancelAddTravel:(AddTravelViewController *)controller;

@end
@interface AddTravelViewController : UIViewController

@property (nonatomic,weak) IBOutlet UITextField *travelName;
@property (nonatomic,weak) IBOutlet UITextField *travelPlace;
@property (nonatomic,weak) IBOutlet UITextField *di;
@property (nonatomic,weak) IBOutlet UITextField *df;
@property (nonatomic, weak) id<AddTravelViewControllerDelegate>delegate;
-(IBAction)saveButtonTouched;
-(IBAction)cancelButtonTouched;

@end
