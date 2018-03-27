
#import <UIKit/UIKit.h>

#import "Manager.h"
#import "Travel.h"

@interface ActivitiesTableViewController : UITableViewController<ManagerDelegate>


@property (nonatomic,copy) Travel* t;
@property (nonatomic, copy) NSString *nameToShow;
@property (nonatomic, copy) NSString *placeToShow;
@property (nonatomic, copy) NSString *inicialDateToShow;
@property (nonatomic, copy) NSString *finalDateToShow;
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, assign) NSInteger idTravel;
@property (nonatomic, assign) NSInteger idPath;
@end