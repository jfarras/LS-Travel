#import "Manager.h"
#import <UIKit/UIKit.h>

@interface galeryPrivates : UIViewController <UIAlertViewDelegate,UICollectionViewDataSource, UICollectionViewDelegate,ManagerDelegate>

@property(nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *assets;
@property (nonatomic, assign) NSInteger idTravel;
@property (nonatomic, assign) NSInteger idPath;
@end
