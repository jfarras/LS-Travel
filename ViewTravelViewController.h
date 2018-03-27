#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Travel.h"
#import "ShareTravelTableViewController.h"


@class ViewTravelViewController;
@protocol ViewTravelViewControllerDelegate <NSObject>
-(void) didSaveChanges:(ViewTravelViewController *)controller withData:(Travel *)data;
//-(void) didShareTravel:(ShareTravelTableViewController *)controller withData:(NSMutableArray *)data;
@end
@interface ViewTravelViewController : UIViewController <ShareTravelTableViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UITextField *name;
@property (nonatomic, weak) IBOutlet UITextField *place;
@property (nonatomic, weak) IBOutlet UITextField *dateInici;
@property (nonatomic, weak) IBOutlet UITextField *dateFinal;
@property (nonatomic, weak) IBOutlet UIButton *share;
@property (nonatomic, weak) IBOutlet UIButton *save;
@property (nonatomic, weak) id<ViewTravelViewControllerDelegate>delegate;
@property (nonatomic, copy) NSString *nameToShow;
@property (nonatomic, copy) NSString *placeToShow;
@property (nonatomic, assign) int tipusVista;
@property (nonatomic, copy) NSString *inicialDateToShow;
@property (nonatomic, copy) NSString *finalDateToShow;
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, weak) IBOutlet MKMapView *map;
-(IBAction)saveChangesButtonTouched;
-(IBAction)shareButtonTouched;

@end
