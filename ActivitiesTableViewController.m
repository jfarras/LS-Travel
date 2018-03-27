#import "ActivitiesTableViewController.h"
#import "Activity.h"
#import "Manager.h"
#import "User.h"
#import "AddActivityViewController.h"
#import "ViewActivityViewController.h"

@interface ActivitiesTableViewController (){
    NSMutableArray *activities;
    NSIndexPath *aux;
}

@end

@implementation ActivitiesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = false;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"Activities";
    activities = [[NSMutableArray alloc]init];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"ff ff %@",[defaults objectForKey:@"tripId"]);
    self.idTravel =[[defaults objectForKey:@"tripId"]integerValue ];
    self.idPath =[[defaults objectForKey:@"tripPath"]integerValue ];
    NSUserDefaults *credentials = [NSUserDefaults standardUserDefaults];
    
    NSString *mail = [credentials stringForKey:@"username"];
    NSString *pass = [credentials stringForKey:@"password"];
    User *userAux = [[User alloc]initWithName:nil andMail:mail andPassword:pass andId:0];
    Manager *manager = [Manager sharedInstance];
    manager.delegate = self;
    [manager getUserInfo:userAux ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return activities.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        UILabel *name = (UILabel *)[cell viewWithTag:1];
        UILabel *phone = (UILabel *)[cell viewWithTag:2];
        UILabel *mail = (UILabel *)[cell viewWithTag:3];
        UILabel *place = (UILabel *)[cell viewWithTag:4];
        UILabel *inicialDate = (UILabel *)[cell viewWithTag:5];
        // UILabel *finalDate = (UILabel *)[cell viewWithTag:6];
        UITextView *descr = (UITextView *)[cell viewWithTag:7];
        
        name.text = [[activities objectAtIndex:indexPath.row] activityName];
        NSLog(@"-----> %@", [[activities objectAtIndex:indexPath.row] activityName]);
        NSLog(@"----->mai %@", [[activities objectAtIndex:indexPath.row] activityMail]);
        NSLog(@"-----> ph%@", [[activities objectAtIndex:indexPath.row] activityPhone]);
        NSLog(@"-----> pla%@", [[activities objectAtIndex:indexPath.row] activityPlace]);
        
        
        phone.text = [[activities objectAtIndex:indexPath.row]activityPhone];
        mail.text = [[activities objectAtIndex:indexPath.row]activityMail];
        place.text = [[activities objectAtIndex:indexPath.row]activityPlace];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *DateInici = [formatter stringFromDate:[[activities objectAtIndex:indexPath.row]inicialData]];
        NSString *DateIfinal = [formatter stringFromDate:[[activities objectAtIndex:indexPath.row]finalData]];
        inicialDate.text = DateInici;
        //finalDate.text = DateIfinal;
        descr.text = [[activities objectAtIndex:indexPath.row]activityDescription];
        
        
        return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ( indexPath.row == activities.count){
        return 41;
    }else{
        return 300;
    }
    
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    aux = indexPath;
    [self performSegueWithIdentifier:@"toViewActivityViewController2" sender:[activities objectAtIndex:indexPath.row]];
}

#pragma mark - buttons


#pragma mark -segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"toAddActivityViewController"]){
        AddActivityViewController *c = (AddActivityViewController *)segue.destinationViewController;
        c.delegate = self;
    }else{
        if([segue.identifier isEqualToString:@"toViewActivityViewController2"]){
            ViewActivityViewController *c = (ViewActivityViewController *)segue.destinationViewController;
            c.nameToShow = [[activities objectAtIndex:aux.row]activityName];
            c.placeToShow = [[activities objectAtIndex:aux.row]activityPlace];
            c.mailToShow = [[activities objectAtIndex:aux.row]activityMail];
            c.descrToShow = [[activities objectAtIndex:aux.row]activityDescription];
            c.phoneToShow = [[activities objectAtIndex:aux.row]activityPhone];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSString *idate =[formatter stringFromDate:[[activities objectAtIndex:aux.row]inicialData]];
            NSString *fdate =[formatter stringFromDate:[[activities objectAtIndex:aux.row]finalData]];
            c.inicialDateToShow =idate;
            c.finalDateToShow =fdate;
            
            
        }
    }
}


#pragma mark - delegate functions


-(void) didAddActivity:(AddActivityViewController *)controller withData:(Activity *)data{
    [activities addObject:data];
    [self.tableView reloadData];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *mail = [defaults objectForKey:@"username"];
    NSString *password = [defaults objectForKey:@"password"];
    
    
    User *usr = [[User alloc]initWithName:nil andMail:mail andPassword:password andId:nil];
    Manager *manager = [Manager sharedInstance];
    NSString *inStr = [NSString stringWithFormat: @"%ld", (long)self.idTravel];
    [manager addActivity:data andUser:usr andId:inStr];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)didCancel:(AddActivityViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)didAddActivity:(Manager *)manager withResponse:(id)information{
    NSLog(@"Activity created");
    if ( [[information objectForKey:@"res"]integerValue] == 1){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Succes"
                                                        message:@"Activity action Done"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Error with the activity, try again!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
}


-(void) didGetUserInfo:(Manager *)manager withResponse:(id)information{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"ffffaaaa %d",self.idPath);
    
    // NSMutableArray *activitiesActu;
    
    
    
    for (int i=0; i<[[[[[information objectForKey:@"info"]valueForKey:@"trips"]objectAtIndex:self.idPath]valueForKey:@"act"]count]; i++){
        // if([[[[information objectForKey:@"info"]valueForKey:@"trips"]objectAtIndex:i]valueForKey:@"id"]== self.idTravel){
        
        NSString *nomAct=[[[[[[information objectForKey:@"info"]valueForKey:@"trips"]objectAtIndex:self.idPath]valueForKey:@"act"]objectAtIndex:i]valueForKey:@"nom"] ;
        NSString *mail=[[[[[[information objectForKey:@"info"]valueForKey:@"trips"]objectAtIndex:self.idPath]valueForKey:@"act"]objectAtIndex:i]valueForKey:@"mai"];
        NSString *tel=[[[[[[information objectForKey:@"info"]valueForKey:@"trips"]objectAtIndex:self.idPath]valueForKey:@"act"]objectAtIndex:i]valueForKey:@"pho"];
        NSString *des=[[[[[[information objectForKey:@"info"]valueForKey:@"trips"]objectAtIndex:self.idPath]valueForKey:@"act"]objectAtIndex:i]valueForKey:@"des"];
        int identifAct=[[[[[[[information objectForKey:@"info"]valueForKey:@"trips"]objectAtIndex:self.idPath]valueForKey:@"act"]objectAtIndex:i]valueForKey:@"id"]integerValue];
        NSString *dateTemp=[[[[[[information objectForKey:@"info"]valueForKey:@"trips"]objectAtIndex:self.idPath]valueForKey:@"act"]objectAtIndex:i]valueForKey:@"dat"];
        
        
        NSArray *inici = [dateTemp componentsSeparatedByString:@" "];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        NSDate *datInici = [dateFormat dateFromString:[inici objectAtIndex:0]];
        
        
        
        NSString *loc=[[[[[[information objectForKey:@"info"]valueForKey:@"trips"]objectAtIndex:self.idPath]valueForKey:@"act"]objectAtIndex:i]valueForKey:@"loc"];
        Activity *act = [[Activity alloc]initWithName:nomAct andDescription:des andPlace:loc andPhone:tel andMail:mail andInicialData:datInici andFinalData:0 andId:(int)(identifAct)];
        
        NSLog(@"@nom: %@",tel);
        
        
        //act = [[Activity alloc]initWithName:[
        
        //  [ activitiesActu addObject:[[[[information objectForKey:@"info"]valueForKey:@"trips"]valueForKey:@"act"]objectAtIndex:i]];
        // act = [[Activity alloc]initWithName:[[[[[information objectForKey:@"info"]valueForKey:@"trips"]   valueForKey:@"act"]objectAtIndex:i ] valueForKey:@"nom"] andDescription:  [[[[[information objectForKey:@"info"]valueForKey:@"trips"]  valueForKey:@"act"]objectAtIndex:i ] valueForKey:@"des"]  andPlace: [[[[[information objectForKey:@"info"]valueForKey:@"trips"]valueForKey:@"act"]objectAtIndex:i ] valueForKey:@"loc"]  andPhone: [[[[[information objectForKey:@"info"]valueForKey:@"trips"]valueForKey:@"act"]objectAtIndex:i ] valueForKey:@"pho"]  andMail:[[[[[information objectForKey:@"info"]valueForKey:@"trips"]valueForKey:@"act"]objectAtIndex:i ] valueForKey:@"mai"]    andInicialData: [[[[[information objectForKey:@"info"]valueForKey:@"trips"]valueForKey:@"act"]objectAtIndex:i ] valueForKey:@"dat"]  andFinalData:nil andId:[[[[[information objectForKey:@"info"]valueForKey:@"trips"]valueForKey:@"act"]objectAtIndex:i ] valueForKey:@"id"] ];
        
        
        
        [activities addObject:act];
    }
    
    
    [self.tableView reloadData];
    
    
}

/*
 for ( int i=0; i< [[[[information objectForKey:@"info"]objectForKey:@"trips" ]valueForKey:@"act"]count]; i++){
 
 NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
 [dateFormat setDateFormat:@"yyyy-MM-dd"];
 // NSDate *arr = [dateFormat dateFromString:[[[[[information objectForKey:@"info"]objectForKey:@"trips"]objectForKey:@"act"] valueForKey:@"arr"]objectAtIndex:i] ];
 // Activity *act = [Activity alloc]initWithName:<#(NSString *)#> andDescription:<#(NSString *)#> andPlace:<#(NSString *)#> andPhone:<#(NSString *)#> andMail:<#(NSString *)#> andInicialData:<#(NSDate *)#> andFinalData:<#(NSDate *)#>
 }
 [self.tableView reloadData];


*/

@end
 
