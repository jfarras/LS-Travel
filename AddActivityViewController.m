#import "AddActivityViewController.h"
#import "Activity.h"


@interface AddActivityViewController ()

@end

@implementation AddActivityViewController


#pragma mark - Set Up
- (void)viewDidLoad {
    [super viewDidLoad];
    UIDatePicker *datePickerInicial = [[UIDatePicker alloc]init];
    datePickerInicial.datePickerMode = UIDatePickerModeDate;
    [datePickerInicial setDate:[NSDate date]];
    [datePickerInicial addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    [self.dateInici setInputView:datePickerInicial];
    
    UIDatePicker *datePickerFinal = [[UIDatePicker alloc]init];
    datePickerFinal.datePickerMode = UIDatePickerModeDate;
    [datePickerFinal setDate:[NSDate date]];
    [datePickerFinal addTarget:self action:@selector(updateTextFieldFinal:) forControlEvents:UIControlEventValueChanged];
    [self.dateFinal setInputView:datePickerFinal];
    self.descr.layer.borderWidth = 2.0f;
    self.descr.layer.borderColor = [[UIColor blackColor]CGColor];
    self.name.placeholder = @"Activity Name";
    self.phone.placeholder = @"Phone: Ex: +0034 611611611";
    self.mail.placeholder = @"Activity Mail";
    self.dateInici.placeholder = @"Inicial Date";
    self.dateFinal.placeholder = @"Final Date";
    self.descr.text =@"Add a description to your activity here!";
    self.descr.textColor = [UIColor lightGrayColor];
    //self.descr.delegate = self;
    
    
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Buttons
-(IBAction)saveButtonTouched{
    
    if ( [self.name.text isEqualToString:@""] || [self.phone.text isEqualToString:@""] || [self.place.text isEqualToString:@""] || [self.mail.text isEqualToString:@""] || [self.dateInici.text isEqualToString:@""] || [self.dateFinal.text isEqualToString:@""] || [self.descr.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Fill all the blanks"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    }else{
        
        bool ok = [self validateEmail:self.mail.text];
        if (ok){
            NSString *phoneRegex = @"^((\\+)|(00))[0-9]{6,14}$";
            NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
            BOOL phoneValidates = [phoneTest evaluateWithObject:self.phone.text];
            if (phoneValidates){
                NSArray *i = [self.dateInici.text componentsSeparatedByString:@" "];
                NSArray *a = [self.dateFinal.text componentsSeparatedByString:@" "];
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"yyyy-MM-dd"];
                NSDate *arr = [dateFormat dateFromString:[i objectAtIndex:0]];
                NSDate *dep = [dateFormat dateFromString:[a objectAtIndex:0]];
                Activity *act = [[Activity alloc]initWithName:self.name.text andDescription:self.descr.text andPlace:self.place.text andPhone:self.phone.text andMail:self.mail.text andInicialData:arr andFinalData:dep andId:0];
                [self.delegate didAddActivity:self withData:act];
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:@"Invalid phone format"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];

            }
            
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Invalid Mail format"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        
    }
   
    
}
-(IBAction)cancelButtonTouched{
    [self.delegate didCancel:self];
}

#pragma mark - TextFields


-(void) updateTextFieldFinal:(id)sender{
    
    UIDatePicker *picker = (UIDatePicker*)self.dateFinal.inputView;
    picker.datePickerMode = UIDatePickerModeDate;
    self.dateFinal.text = [NSString stringWithFormat:@"%@",picker.date];
}

-(void)updateTextField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.dateInici.inputView;
    picker.datePickerMode = UIDatePickerModeDate;
    self.dateInici.text = [NSString stringWithFormat:@"%@",picker.date];
}

#pragma mark - textViewDelegate

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    self.descr.text = @"";
    self.descr.textColor = [UIColor blackColor];
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    
    if(self.descr.text.length == 0){
        self.descr.textColor = [UIColor lightGrayColor];
        self.descr.text = @"Add a description to your activity here!";
        [self.descr resignFirstResponder];
    }
}

#pragma mark - Keyboard

-(void) dismissKeyboard{
    [self.view endEditing:YES];
}

#pragma mark- validations
- (BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:candidate];
}


@end
