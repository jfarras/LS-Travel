#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface PhotoCell : UICollectionViewCell
@property(nonatomic, strong) ALAsset *asset;
@property(nonatomic, weak) IBOutlet UIImageView *photoImageView;
@end
