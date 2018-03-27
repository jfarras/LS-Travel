#import "TravelTableViewController.h"
#import "ViewTravelViewController.h"
#import "ShareTravelTableViewController.h"
#import "ShareTravelTableViewController.h"
#import <EventKit/EventKit.h>
#import "TableActivitiesViewController.h"
#import "Manager.h"

@interface TravelTableViewController (){
    NSMutableArray *travels;
    NSString *eventName;
    NSIndexPath *aux;
    BOOL travelCreated;

}

@end

@implementation TravelTableViewController

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
- (void)viewDidLoad {
    [self.tableView reloadData];
    [super viewDidLoad];
    travels = [[NSMutableArray alloc] init];
    NSUserDefaults *credentials = [NSUserDefaults standardUserDefaults];
    NSString *mail = [credentials stringForKey:@"username"];
    NSString *pass = [credentials stringForKey:@"password"];
    User *userAux = [[User alloc]initWithName:nil andMail:mail andPassword:pass andId:0];
    Manager *manager = [Manager sharedInstance];
    manager.delegate = self;
   // [manager getUsers];
    [manager getUserInfo:userAux ];
    NSTimer *myTimer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(reloadTable) userInfo:nil repeats:YES];
    ShareTravelTableViewController *c = [[ShareTravelTableViewController alloc]init];
    c.delegate = self;
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor purpleColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    
   [self.refreshControl addTarget:self
                            action:@selector(updateData)
                  forControlEvents:UIControlEventValueChanged];

}
-(void)updateData {
    //do something with data model
    //and reload table then
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *mail = [defaults stringForKey:@"username"];
    NSString *pass = [defaults stringForKey:@"password"];
    User *userAux = [[User alloc]initWithName:nil andMail:mail andPassword:pass andId:0];
    [travels removeAllObjects];
    Manager *manager = [Manager sharedInstance];
    manager.delegate = self;
    [manager getUserInfo:userAux ];
    
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}
- (void)reloadTable
{
    // Reload table data
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *mail = [defaults stringForKey:@"username"];
    NSString *pass = [defaults stringForKey:@"password"];
    User *userAux = [[User alloc]initWithName:nil andMail:mail andPassword:pass andId:0];
    [travels removeAllObjects];
    Manager *manager = [Manager sharedInstance];
    manager.delegate = self;
    [manager getUserInfo:userAux ];
    [self.tableView reloadData];
    
    
    // End the refreshing
   /* if (self.refreshControl) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM d, h:mm a"];
        NSString *title = [NSString stringWithFormat:@"Last update: %@", [formatter stringFromDate:[NSDate date]]];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                    forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
        self.refreshControl.attributedTitle = attributedTitle;
        
        [self.refreshControl endRefreshing];
    }
    */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dismissKeyboard{
    [self.view endEditing:YES];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
// Return the number of rows in the section.
    return travels.count;
}

#pragma mark - table functions

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    UILabel *inicialDate = (UILabel *)[cell viewWithTag:1];
    UILabel *finalDate = (UILabel *)[cell viewWithTag:2];
    UILabel *name = (UILabel *)[cell viewWithTag:3];
    UILabel *place = (UILabel *)[cell viewWithTag:4];
     UILabel *type = (UILabel *)[cell viewWithTag:5];
    
    cell.accessoryType=UITableViewCellAccessoryDetailDisclosureButton;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *DateInici = [formatter stringFromDate:[[travels objectAtIndex:indexPath.row]inicialData]];
    NSString *DateIfinal = [formatter stringFromDate:[[travels objectAtIndex:indexPath.row]finalData]];
    if ([[[travels objectAtIndex:indexPath.row]travelType] isEqualToString:@"private"]){
        type.textColor = [UIColor blueColor];
    }else{
        if ([[[travels objectAtIndex:indexPath.row]travelType] isEqualToString:@"shared"]){
            type.textColor = [UIColor orangeColor];
        }else{
            type.textColor = [UIColor purpleColor];
        }
    }

    type.text =[NSString stringWithFormat:@"Type: %@",[[travels objectAtIndex:indexPath.row]travelType],nil];
    name.text =[NSString stringWithFormat:@"Name: %@",[[travels objectAtIndex:indexPath.row]Travelname],nil];
    place.text =[NSString stringWithFormat:@"Place: %@",[[travels objectAtIndex:indexPath.row]TravelPlace],nil];
    inicialDate.text =DateInici;
    finalDate.text =DateIfinal;
 
   
    
    return cell;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"IDENTIFIER--> %d", [[travels objectAtIndex:indexPath.row]Id]);
    NSString *identifier = [NSString stringWithFormat:@"%ld",(long)[[travels objectAtIndex:indexPath.row]Id],nil];
    NSLog(@"identifier-->%ld", (long)identifier.integerValue);
    [defaults setObject:identifier forKey:@"tripId"];
    //PUJO A LA SESSIO EL NOM DEL VIATGE PERQUE TAMBE EL NECESSITEM AL TAKEPHOTOVIEWCONTROLLER
    
    NSString *travelName = [[travels objectAtIndex:indexPath.row]Travelname];
    [defaults setObject:travelName forKey:@"travelName"];
    
    NSInteger num = indexPath.row;
    int i = num;
    NSString *indexCast = [NSString stringWithFormat:@"%d", i];
    NSLog(indexCast);
   
    [defaults setObject:indexCast forKey:@"tripPath"];

    [defaults synchronize];
    
    if ([[[travels objectAtIndex:indexPath.row]travelType] isEqualToString:@"follow"]){
        [self performSegueWithIdentifier:@"toViewDetail2" sender:[travels objectAtIndex:indexPath.row]] ;}
    else{
        [self performSegueWithIdentifier:@"toViewDetail3" sender:[travels objectAtIndex:indexPath.row]] ;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        EKEventStore* store = [[EKEventStore alloc] init];
        [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            if (!granted) { return; }
            EKEvent* eventToRemove = [store eventWithIdentifier:eventName];
            if (eventToRemove) {
                NSError* error = nil;
                [store removeEvent:eventToRemove span:EKSpanThisEvent commit:YES error:&error];
            }
        }];
        
        Manager *manager = [Manager sharedInstance];
        manager.delegate = self;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *mail = [defaults objectForKey:@"username"];
        NSString *password = [defaults objectForKey:@"password"];
        User *usr = [[User alloc]initWithName:nil andMail:mail andPassword:password andId:nil];
        NSLog(@"-------->ID: %ld", (long)[[travels objectAtIndex:indexPath.row]Id]);
        [manager removeTravel:[travels objectAtIndex:indexPath.row]andUser:usr];
        [travels removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        
        
        
        [self.tableView reloadData];

    }
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    aux = indexPath;
     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *identifier = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    [defaults setObject:identifier forKey:@"numPath"];
    [self performSegueWithIdentifier:@"toViewTravelViewController" sender:[travels objectAtIndex:indexPath.row]] ;
    //NSLog(@"TABLE ID: %ld",(long)[[travels objectAtIndex:indexPath.row]Id] );
    //NSLog(@"INDEX PATH 2: %ld", (long)indexPath.row);
    
}



#pragma mark - segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqual:@"toAddTravelViewController"]){
        AddTravelViewController *c = (AddTravelViewController *)segue.destinationViewController;
        c.delegate = self;
    }else{
        if ([segue.identifier isEqual:@"toViewTravelViewController"]){
           
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            ViewTravelViewController *c = (ViewTravelViewController *)segue.destinationViewController;
            int id= [[defaults objectForKey:@"numPath"]integerValue];
            if ([[[travels objectAtIndex:id]travelType] isEqualToString:@"follow"]){
                c.tipusVista = 1;
            }else c.tipusVista = 0;
            c.nameToShow = [[travels objectAtIndex:aux.row]Travelname];
            c.placeToShow = [[travels objectAtIndex:aux.row]TravelPlace];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSString *idate =[formatter stringFromDate:[[travels objectAtIndex:aux.row]inicialData]];
            NSString *fdate =[formatter stringFromDate:[[travels objectAtIndex:aux.row]finalData]];
            
            c.inicialDateToShow =idate;
            c.finalDateToShow =fdate;
            c.delegate = self;
            c.identifier = [[travels objectAtIndex:aux.row]Id];
            
            
           
        }else
            if ([segue.identifier isEqual:@"toViewDetail3"]){
                
                /*
                locationsHome* vc = [[locationsHome alloc] init];
                UITabBarController* tbc = [segue destinationViewController];
                vc = (locationsHome *)[[tbc customizableViewControllers] objectAtIndex:0];
                TableActivitiesViewController *c = (TableActivitiesViewController *)segue.destinationViewController;
                //c.t= [[Travel alloc] initWithType:@"private" andName:nil andPlace:nil andInicialData:nil andFinalData:nil andId:1 andActivities:nil];
                c.nameToShow = [[travels objectAtIndex:aux.row]Travelname];
                c.placeToShow = [[travels objectAtIndex:aux.row]TravelPlace];
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString *idate =[formatter stringFromDate:[[travels objectAtIndex:aux.row]inicialData]];
                NSString *fdate =[formatter stringFromDate:[[travels objectAtIndex:aux.row]finalData]];
                c.inicialDateToShow =idate;
                c.finalDateToShow =fdate;
                
                c.identifier = [[travels objectAtIndex:aux.row]Id];
                */
                /*
                NSInteger num = aux.row;
                int i = num;
                NSString *indexCast = [NSString stringWithFormat:@"%d", 4];
                NSLog(indexCast);
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:indexCast forKey:@"tripId"];
                [defaults synchronize];
            */
            }
                
    }
    
}


#pragma mark - buttons
-(IBAction)addButtonTouched{
    [self performSegueWithIdentifier:@"toAddTravelViewController" sender:nil] ;
}

-(IBAction)logOutButtonTouched{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"username"];
    [defaults removeObjectForKey:@"password"];
    [defaults synchronize];
    [self dismissViewControllerAnimated:YES completion:nil];

}

#pragma mark - addTravel delegate
-(void) didAddTravel:(AddTravelViewController *)controller withData:(Travel *)data{
    [travels addObject:data];
    [self.tableView reloadData];
    EKEventStore *store = [[EKEventStore alloc] init];
    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        if (!granted) { return; }
        EKEvent *event = [EKEvent eventWithEventStore:store];
        event.title = [NSString stringWithFormat:@"LST: %@", [data Travelname]];
        event.startDate = [data inicialData]; 
        event.endDate = [data finalData];
        [event setCalendar:[store defaultCalendarForNewEvents]];
        NSError *err = nil;
        [store saveEvent:event span:EKSpanThisEvent commit:YES error:&err];
        eventName = event.eventIdentifier;
    }];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *mail = [defaults stringForKey:@"username"];
    NSString *pass = [defaults stringForKey:@"password"];
    User *userAux = [[User alloc]initWithName:nil andMail:mail andPassword:pass andId:0];
    Manager *manager = [Manager sharedInstance];
    manager.delegate = self;
    [manager addTravel:data andUser:userAux];

    [self dismissViewControllerAnimated:YES completion:nil];
    travelCreated = true;
    
}
-(void)didCancelAddTravel:(AddTravelViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:nil];

}

#pragma mark - ViewTravel delegate

-(void) didSaveChanges:(ViewTravelViewController *)controller withData:(Travel *)data{
    
    NSUserDefaults *credentials = [NSUserDefaults standardUserDefaults];
    NSString *mail = [credentials stringForKey:@"username"];
    NSString *pass = [credentials stringForKey:@"password"];
    User *userToUpdate = [[User alloc]initWithName:nil andMail:mail andPassword:pass andId:nil];
    
    Manager *manager = [Manager sharedInstance];
    manager.delegate = self;
   [manager updateTrip:userToUpdate andTravel:data];
    
    [self reloadTable];


    //[travels removeObjectAtIndex:aux.row];
    //[travels insertObject:data atIndex:aux.row];
    //[self.tableView reloadData];
    // Esborrem event del calendar
    EKEventStore* store = [[EKEventStore alloc] init];
    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        if (!granted) { return; }
        EKEvent* eventToRemove = [store eventWithIdentifier:eventName];
        if (eventToRemove) {
            NSError* error = nil;
            [store removeEvent:eventToRemove span:EKSpanThisEvent commit:YES error:&error];
        }
    }];
    // creem nou event
    store = [[EKEventStore alloc] init];
    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        if (!granted) {
            return; }
        EKEvent *event = [EKEvent eventWithEventStore:store];
        event.title = [NSString stringWithFormat:@"LST: %@", [data Travelname]];
        event.startDate = [data inicialData];
        event.endDate = [data finalData];
        [event setCalendar:[store defaultCalendarForNewEvents]];
        NSError *err = nil;
        [store saveEvent:event span:EKSpanThisEvent commit:YES error:&err];
        eventName = event.eventIdentifier;
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
#pragma mark - Share travel delegate

-(void) didShareTravel:(ShareTravelTableViewController *)controller{
    Travel *travel = [travels objectAtIndex:aux.row];
    NSLog(@"SHAREED");
    travel.travelType = @"shared";
    [travels removeObjectAtIndex:aux.row];
    [travels insertObject:travel atIndex:aux.row];
    [self.tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
}
 */

#pragma mark - Manager Delegate

-(void)didAddTravel:(Manager *)manager withResponse:(id)information{
    
    if (travelCreated){
        
        if ([[information objectForKey:@"res"]integerValue] == 1){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Succes"
                                                            message:@"Travel added with exit!"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"A problem occcurred while creating the travel, try again! "
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        travelCreated = false;

    }
}

-(void) didGetUserInfo:(Manager *)manager withResponse:(id)information{
    NSLog(@"PAPUS THE GREAT!!");
    NSString *type;
    NSString *namePropi=[[information objectForKey:@"info"]valueForKey:@"name"];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:namePropi forKey:@"namePropi"];
    self.idPropi = (int)[[[information objectForKey:@"info"]valueForKey:@"id"]integerValue];
    NSLog(@"%d",self.idPropi);
    [defaults synchronize];
    
    
    int idUser=0;
    for ( int i=0; i< [[[information objectForKey:@"info"]valueForKey:@"trips" ] count]; i++){
        NSLog(@"%@",[[[[information objectForKey:@"info"] objectForKey:@"trips" ]objectAtIndex:i] valueForKey:@"sha"] );
        if ([[[[[information objectForKey:@"info"] objectForKey:@"trips" ]objectAtIndex:i] valueForKey:@"sha"]count] == 0 ){
            type= @"private";
            NSLog(@"IDUSER0 : %d",idUser);
            //idUser = [[[[[information objectForKey:@"info"]objectForKey:@"trips"]objectAtIndex:i]valueForKey:@"own"]integerValue];
             NSLog(@"IDUSER1 : %d",idUser);
        }else{
            
            if ([[[[[information objectForKey:@"info"] objectForKey:@"trips" ]objectAtIndex:i] valueForKey:@"own"]integerValue]== self.idPropi){
               type = @"shared";
            }
            else  type = @"follow";
        

        }
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        NSDate *arr = [dateFormat dateFromString:[[[[information objectForKey:@"info"] objectForKey:@"trips" ] valueForKey:@"arr"]objectAtIndex:i] ];
        NSDate *dep = [dateFormat dateFromString:[[[[information objectForKey:@"info"] objectForKey:@"trips" ] valueForKey:@"dep"]objectAtIndex:i]];
        
        



        
        Travel *travel = [[Travel alloc] initWithType:type andName:[[[[information objectForKey:@"info"] objectForKey:@"trips" ] valueForKey:@"nom"]objectAtIndex:i] andPlace:[[[[information objectForKey:@"info"] objectForKey:@"trips" ] valueForKey:@"loc"]objectAtIndex:i] andInicialData:arr andFinalData:dep  andId:[[[[[information objectForKey:@"info"] objectForKey:@"trips" ] valueForKey:@"id"]objectAtIndex:i]integerValue]andActivities:nil ] ;
                [travels addObject:travel];
        
    }
    [self.tableView reloadData];
    
}


-(void)didRemoveTravel:(Manager *)manager withResponse:(id)information{
    
    NSLog(@"RES: %ld", (long)[[information objectForKey:@"res"]integerValue]);
    if ([[information objectForKey:@"res"]integerValue] == 1){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Succes"
                                                        message:@"The travel has been erased"
                                                       delegate:nil                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Error while deleting, try again"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}
/*
-(void)didGetUsers:(Manager *)manager withResponse:(NSDictionary *)information{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    for (int i=0; i< [[information objectForKey:@"info"]count]; i++){
        if( [[[information objectForKey:@"info"]objectAtIndex:i ]valueForKey:@"nom"] == [defaults stringForKey:@"nomPropi"]){
            self.idPropi = (int)[[[[information objectForKey:@"info"]objectAtIndex:i ]valueForKey:@"id"]integerValue];
        }
    }
 
    
}*/




@end
