
#import "TakePhotoViewController.h"
#import "User.h"
#import "Manager.h"

@interface TakePhotoViewController ()


@end



@implementation TakePhotoViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        self.title = @"Take photo";
        
    }

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -Buttons

- (IBAction)takePhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (IBAction)selectPhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
    
}


#pragma mark - Image Picker Controller delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
   
    float actualHeight = self.imageView.image.size.height;
    float actualWidth = self.imageView.image.size.width;
    float imgRatio = actualWidth/actualHeight;
    float maxRatio = 10/10;
    
    if(imgRatio!=maxRatio){
        if(imgRatio < maxRatio){
            imgRatio = 480.0 / actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = 480.0;
        }
        else{
            imgRatio = 320.0 / actualWidth;
            actualHeight = imgRatio * actualHeight;
            actualWidth = 320.0;
        }
    }
    CGRect rect = CGRectMake(0.0, 0.0, 50, 50);
    UIGraphicsBeginImageContext(rect.size);
    [self.imageView.image drawInRect:rect];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    
    
    
   
    
    NSData *imageData = UIImagePNGRepresentation(self.imageView.image);
    //NSString *encodedString =[NSString stringWithFormat:@"data:image/png;base64,%@",[ imageData base64Encoding]];
    NSString *encodedString = [NSString stringWithFormat:@"data:image/png;base64,%@", [UIImagePNGRepresentation(img) base64EncodedStringWithOptions:0]];
    NSLog(encodedString);
    NSUserDefaults *credentials = [NSUserDefaults standardUserDefaults];
    NSString *mail = [credentials stringForKey:@"username"];
    NSString *pass = [credentials stringForKey:@"password"];
    User *userAux = [[User alloc]initWithName:nil andMail:mail andPassword:pass andId:0];
    NSString *travelName = [credentials stringForKey:@"travelName"];
    //EL ID SEMPRE VAL 0, CAL PUJARLO VE A LA SESSIO
    NSString *identifier =  [credentials stringForKey:@"tripId"];
    NSLog(@"ID_recived: %ld", (long)identifier.integerValue);
    Manager *manager = [Manager sharedInstance];
    manager.delegate = self;
    
    NSString *aux = [encodedString stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    
    [manager addImage:userAux andId:identifier.integerValue andName:travelName andImg:aux ];
    UIImageWriteToSavedPhotosAlbum(chosenImage,nil, nil, nil);
    
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
-(void)didAddImage:(Manager *)manger withResponse:(id)information{
    if ([[information objectForKey:@"res"]integerValue] == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"This user already exists"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ok"
                                                                message:@"Image added"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
                
    }
    NSLog([information objectForKey:@"info"]);
    self.imageView.image = nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
