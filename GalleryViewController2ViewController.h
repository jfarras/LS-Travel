#import "Manager.h"
#import <UIKit/UIKit.h>

@interface Gallery2 : UICollectionViewController <UIAlertViewDelegate,UICollectionViewDataSource, UICollectionViewDelegate,ManagerDelegate>

@property(nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *assets;
@property (nonatomic, assign) NSInteger idTravel;
@property (nonatomic, assign) NSInteger idPath;
@end
