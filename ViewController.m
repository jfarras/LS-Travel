#import "ViewController.h"
#import "User.h"
#import "Manager.h"
#import "RegisterViewController.h"

@interface ViewController ()

@end

@implementation ViewController 

#pragma mark - setUp
- (void)viewDidLoad {
    [super viewDidLoad];
    self.login.placeholder = @"login";
    self.password.placeholder = @"password";
    self.password.secureTextEntry= YES;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dismissKeyboard{
    [self.view endEditing:YES];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
-(void) viewDidAppear:(BOOL)animated{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // check if user is alraidy Login
    if([defaults objectForKey:@"username"]!=nil  && ![[defaults objectForKey:@"username"] isEqualToString:@""]){
        [self performSegueWithIdentifier:@"toTravelTableViewController" sender:nil] ;
    }
}

#pragma mark - Segue

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"toRegisterViewController"]){
        RegisterViewController *c = (RegisterViewController *)segue.destinationViewController;
        
    }
}


#pragma mark - Buttons

-(IBAction)signInButtonTouched{
    if ([self.login.text isEqualToString:@""] || [self.password.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Fill all the blanks"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }else{
        // creem la sessio
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:self.login.text forKey:@"username"];
        [defaults setObject:self.password.text forKey:@"password"];
        [defaults synchronize];
        
        
       User *aUser = [[User alloc] initWithName:nil andMail:self.login.text andPassword:self.password.text andId:nil];
        Manager *manager = [Manager sharedInstance];
        manager.delegate = self;
        [manager loginWithUser:aUser];
       
    }
   
  
    

}

-(IBAction)registerButtonTouched{
    [self performSegueWithIdentifier:@"toRegisterViewController" sender:nil] ;
}
-(IBAction)recoveryButtonTouched{
    Manager *manager = [Manager sharedInstance];
    manager.delegate = self;
    NSLog(self.login.text);
    [manager recovery:self.login.text];

}

-(void) didFinishLogin:(Manager *)manager withResponse:(id)information{

    if ([[information objectForKey:@"res"]integerValue] == 1){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"OK"
                                                        message:@"Login OK"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        [self performSegueWithIdentifier:@"toTravelTableViewController" sender:nil] ;
 

        
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"This user doesn't existt"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
}
-(void) didRecovery:(Manager *)manager withResponse:(id)information{
    
    if ([[information objectForKey:@"res"]integerValue] == 1){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"OK"
                                                        message:@"Message sent"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        
        
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"This user doesn't exist"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
}







@end
