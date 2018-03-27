#import <UIKit/UIKit.h>
#import "Activity.h"

@class AddActivityViewController;
@protocol AddActivityViewControllerDelegate <NSObject>

-(void)didAddActivity:(AddActivityViewController *)controller withData:(Activity *)data;
-(void)didCancel:(AddActivityViewController *)controller;

@end
@interface AddActivityViewController : UIViewController

@property (nonatomic, weak) IBOutlet UITextField *name;
@property (nonatomic, weak) IBOutlet UITextView *descr;
@property (nonatomic, weak) IBOutlet UITextField *phone;
@property (nonatomic, weak) IBOutlet UITextField *mail;
@property (nonatomic, weak) IBOutlet UITextField *place;
@property (nonatomic, weak) IBOutlet UITextField *dateInici;

@property (nonatomic, weak) IBOutlet UITextField *dateFinal;
@property (nonatomic, weak) id<AddActivityViewControllerDelegate> delegate;
-(IBAction)saveButtonTouched;
-(IBAction)cancelButtonTouched;

@end
