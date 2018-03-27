#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewActivityViewController : UIViewController

@property (nonatomic, weak) IBOutlet UILabel *name;
@property (nonatomic, weak) IBOutlet UILabel *descr;
@property (nonatomic, weak) IBOutlet UILabel *phone;
@property (nonatomic, weak) IBOutlet UILabel *mail;
@property (nonatomic, weak) IBOutlet UILabel *place;
@property (nonatomic, weak) IBOutlet UILabel *dateInici;
@property (nonatomic, weak) IBOutlet UILabel *dateFinal;
@property (nonatomic, weak) IBOutlet MKMapView *map;

@property (nonatomic, copy) NSString *nameToShow;
@property (nonatomic, copy) NSString *placeToShow;
@property (nonatomic, copy) NSString *phoneToShow;
@property (nonatomic, copy) NSString *mailToShow;
@property (nonatomic, copy) NSString *inicialDateToShow;
@property (nonatomic, copy) NSString *finalDateToShow;
@property (nonatomic, copy) NSString *descrToShow;

-(IBAction)backButtonTouched;
-(IBAction)callButtonTouched;
-(IBAction)contactButtonTouched;


@end
