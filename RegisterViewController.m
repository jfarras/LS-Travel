#import "RegisterViewController.h"
#import "User.h"
#import "Manager.h"
#import "TravelTableViewController.h"

@implementation RegisterViewController{
    bool error;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
#pragma mark - setUp
- (void)viewDidLoad {
    [super viewDidLoad];
    self.name.placeholder = @"Name";
    self.mail.placeholder = @"Ex: student@salleurl.edu";
    self.password.placeholder = @"password";
    self.password.secureTextEntry= YES;
    error=false;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dismissKeyboard{
    [self.view endEditing:YES];
}


#pragma mark -buttons
-(IBAction)cancelButtonTouched{
    [self dismissViewControllerAnimated:YES completion:nil];

}

-(IBAction)saveButtonTouched{
    if ([self.name.text isEqualToString:@""] || [self.mail.text isEqualToString:@""] || [self.password.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Fill all the blanks"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        error = true;
    }else{
        bool ok = [self validateEmail:self.mail.text];
        BOOL containsLetter = NSNotFound != [self.password.text rangeOfCharacterFromSet:NSCharacterSet.letterCharacterSet].location;
        BOOL containsNumber = NSNotFound != [self.password.text rangeOfCharacterFromSet:NSCharacterSet.decimalDigitCharacterSet].location;
        if (!ok){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Invalid mail format"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            error = true;

        }
        if ([self.password.text length] < 8 || !containsLetter || !containsNumber){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Password must be 8 characters long and must contain letters and numbers"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            error = true;

        }
        if (error){
            self.name.text = @"";
            self.mail.text = @"";
            self.password.text =@"";
        }else{
            User *user = [[User alloc]initWithName:self.name.text andMail:self.mail.text andPassword:self.password.text andId:nil];
            Manager *manager = [Manager sharedInstance];
            manager.delegate = self;
            [manager registerUser:user];
        }
  
    }
}

#pragma mark - manager delegate
-(void)didFinishRegister:(Manager *)manager withResponse:(id)information{
    if ([[information objectForKey:@"res"]integerValue] == -1){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"This user already exists"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        error = true;
    }else{
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:self.mail.text forKey:@"username"];
        [defaults setObject:self.password.text forKey:@"password"];
        [defaults synchronize];
        [self performSegueWithIdentifier:@"toTravelTableViewController" sender:nil] ;

    }
}

#pragma mark- validations
- (BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:candidate];
}

#pragma mark -segue
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"toTravelTableViewController"]){
        TravelTableViewController *c =(TravelTableViewController *)segue.destinationViewController;
    }
}

@end
