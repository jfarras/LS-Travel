

#import "AddTravelViewController.h"
#import "ShareTravelTableViewController.h"

@interface AddTravelViewController ()

@end

@implementation AddTravelViewController{
    NSInteger i;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIDatePicker *datePickerInicial = [[UIDatePicker alloc]init];
    datePickerInicial.datePickerMode = UIDatePickerModeDate;
    [datePickerInicial setDate:[NSDate date]];
    [datePickerInicial addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    [self.di setInputView:datePickerInicial];
    
    UIDatePicker *datePickerFinal = [[UIDatePicker alloc]init];
    datePickerFinal.datePickerMode = UIDatePickerModeDate;
    [datePickerFinal setDate:[NSDate date]];
    [datePickerFinal addTarget:self action:@selector(updateTextFieldFinal:) forControlEvents:UIControlEventValueChanged];
    [self.df setInputView:datePickerFinal];
    //self.finalDate.datePickerMode = UIDatePickerModeDate;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dismissKeyboard{
    [self.view endEditing:YES];
}

#pragma mark - selector
-(void) updateTextFieldFinal:(id)sender{
    
    UIDatePicker *picker = (UIDatePicker*)self.df.inputView;
    picker.datePickerMode = UIDatePickerModeDate;
    self.df.text = [NSString stringWithFormat:@"%@",picker.date];
}

-(void)updateTextField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.di.inputView;
    picker.datePickerMode = UIDatePickerModeDate;
    self.di.text = [NSString stringWithFormat:@"%@",picker.date];
}


#pragma mark -Buttons

-(IBAction)saveButtonTouched{
    
    if ([self.travelName.text isEqualToString:@""]|| [self.travelPlace.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Fill all blanks"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }else{
        //i = arc4random() %(100)-1;
        NSArray *inicial = [self.di.text componentsSeparatedByString:@" "];
        NSArray *a = [self.df.text componentsSeparatedByString:@" "];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        NSDate *arr = [dateFormat dateFromString:[inicial objectAtIndex:0]];
        NSDate *dep = [dateFormat dateFromString:[a objectAtIndex:0]];
       
        Travel *travel = [[Travel alloc] initWithType:@"private" andName:self.travelName.text andPlace:self.travelPlace.text andInicialData:arr andFinalData:dep andId:1 andActivities:nil ];
        
        [self.delegate didAddTravel:self withData:travel];
    }
}

-(IBAction)cancelButtonTouched{
    [self.delegate didCancelAddTravel:self];
}



@end
