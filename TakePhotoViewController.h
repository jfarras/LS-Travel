#import <UIKit/UIKit.h>
#import "Manager.h"

@interface TakePhotoViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, ManagerDelegate>


@property (strong, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)takePhoto:  (UIButton *)sender;
- (IBAction)selectPhoto:(UIButton *)sender;

@end
