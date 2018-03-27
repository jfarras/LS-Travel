#import <UIKit/UIKit.h>
#import "Manager.h"

@interface RegisterViewController : UIViewController <ManagerDelegate>

@property (nonatomic, weak) IBOutlet UITextField *name;
@property (nonatomic, weak) IBOutlet UITextField *mail;
@property (nonatomic, weak) IBOutlet UITextField *password;
-(IBAction)saveButtonTouched;
-(IBAction)cancelButtonTouched;
@end
