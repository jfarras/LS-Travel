#import "ShareTravelTableViewController.h"




@interface ShareTravelTableViewController (){
    NSMutableArray *users;
    NSMutableArray *sharedUsers;
    NSMutableArray *indexes;
    NSMutableArray *usersIDs;
    //NSIndexPath *aux;
    BOOL selected;
    
}

@end

@implementation ShareTravelTableViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    NSLog(@"-----> %d", self.num);
    if (self.delegate == nil) NSLog(@"ola");
    Manager *manager =[[Manager alloc]init];
    manager.delegate = self;
    [manager getUsers];
    indexes = [[NSMutableArray alloc]init];
    users = [[NSMutableArray alloc]init];
    sharedUsers = [[NSMutableArray alloc]init];
    selected = false;
    
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
    return users.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    UILabel *user = (UILabel *)[cell viewWithTag:1];
    user.text = [NSString stringWithFormat:@"User: %@",[[users objectAtIndex:indexPath.row]name],nil];
    return cell;
}

#pragma mark - Table functions

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)path {
    
    //[indexes addObject:[users objectAtIndex:(int)path]] ;
    NSLog(@"premut!");
    selected =  true;
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:path];
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        //cell.backgroundColor = [UIColor blueColor];
    }
    User *usr = [users objectAtIndex:path.row];
    [ sharedUsers addObject:usr];
}

#pragma mark - buttons

-(IBAction)backButtonTouched{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)doneButtonTouched{
    if (selected ){
        NSLog(@"SELECTED!");
        
        
        //TODO: Bucle que passi els indexes a un array d'usuaris. Passar aquest array al delegate (ViewTravel..) amb la funció didShareTravel. Des d'allà cridar webService per cada usuari de l'array
        
       /* for (int i=0; i< idexes.count; i++){
            User *userAux = [[User alloc] initWithName:nil andMail:self.login.text andPassword:self.password.text andId:nil];
            [sharedUsers addObject:(userAux);
//        User * userToShare = ;
        //*/
        if (self.delegate == nil) NSLog(@"ola");
        [self.delegate didShareTravel:self withData:sharedUsers ];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"No users selected"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
}

#pragma mark - Manager delegate

-(void)didGetUsers:(Manager *)manager withResponse:(NSDictionary *)information{

    for (int i=0; i< [[information objectForKey:@"info"]count]; i++){
        User *usr = [[User alloc] initWithName:[[[information objectForKey:@"info"]valueForKey:@"nom"]objectAtIndex:i] andMail:nil andPassword:nil andId:[[[[information objectForKey:@"info"]objectAtIndex:i ]valueForKey:@"id"]integerValue]];
        
        [users addObject:usr];
        [self.tableView reloadData];
    }
    
}





@end
