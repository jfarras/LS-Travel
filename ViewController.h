#import <UIKit/UIKit.h>
#import "Manager.h"

@interface ViewController : UIViewController <ManagerDelegate>

@property (nonatomic, weak) IBOutlet UITextField *login;
@property (nonatomic, weak) IBOutlet UITextField *password;
-(IBAction) signInButtonTouched;
-(IBAction) registerButtonTouched;
-(IBAction) recoveryButtonTouched;



@end

