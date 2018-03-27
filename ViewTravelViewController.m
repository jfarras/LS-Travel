#import "ViewTravelViewController.h"
#import <CoreLocation/CLGeocoder.h>
#import <CoreLocation/CLPlacemark.h>
#import <MapKit/MapKit.h>
#import "Travel.h"
#import "ShareTravelTableViewController.h"
#import "TravelTableViewController.h"

@interface ViewTravelViewController ()

@end

@implementation ViewTravelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name.text = self.nameToShow;
    self.place.text = self.placeToShow;
    self.dateInici.text = self.inicialDateToShow;
    self.dateFinal.text = self.finalDateToShow;
    if (self.tipusVista){
        self.name.userInteractionEnabled = NO;
        self.place.userInteractionEnabled = NO;
        self.dateFinal.userInteractionEnabled = NO;
        self.dateInici.userInteractionEnabled = NO;
        self.save.hidden = YES;
        self.share.hidden = YES;
        
        
    }
    //MAP location
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:self.placeToShow completionHandler:^(NSArray *placemarks, NSError *error) {
        //Error checking
        
        CLPlacemark *placemark = [placemarks objectAtIndex:0];
        MKCoordinateRegion region;
        
        region.center.latitude = placemark.region.center.latitude;
        region.center.longitude = placemark.region.center.longitude;
        MKCoordinateSpan span;
        double radius = placemark.region.radius / 1000; // convert to km
        span.latitudeDelta = radius / 112.0;
        
        region.span = span;
        
        [self.map setRegion:region animated:YES];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - buttons

-(void) shareButtonTouched{
    [self performSegueWithIdentifier:@"toShareTravelViewController" sender:nil] ;

}

-(void) saveChangesButtonTouched{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-DD"];
    NSArray *inicial = [self.dateInici.text componentsSeparatedByString:@" "];
    NSArray *a = [self.dateFinal.text componentsSeparatedByString:@" "];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];

    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *arr = [dateFormat dateFromString:[inicial objectAtIndex:0]];
    NSDate *dep = [dateFormat dateFromString:[a objectAtIndex:0]];

    
    
    
    
    Travel *travel = [[Travel alloc]initWithType:@"private" andName:self.name.text andPlace:self.place.text andInicialData:arr andFinalData:dep andId:self.identifier andActivities:nil];
    [self.delegate didSaveChanges:self withData:travel];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



#pragma mark - segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"toShareTravelViewController"]){
        ShareTravelTableViewController *control = (ShareTravelTableViewController *)segue.destinationViewController;
        if (control == nil) NSLog(@"**********");
        control.delegate=self;
        control.num = 983;
        //
    }
}

#pragma mark - ShareTravel delegate


-(void) didShareTravel:(ShareTravelTableViewController *)controller withData:(NSMutableArray *)data{
    NSLog(@"NO ARRIBA!");
    Manager *manager = [Manager sharedInstance];
    NSUserDefaults *credentials = [NSUserDefaults standardUserDefaults];
   // manager.delegate = self;
    
    NSString *mail = [credentials stringForKey:@"username"];
    NSString *pass = [credentials stringForKey:@"password"];
    User *userAux = [[User alloc]initWithName:nil andMail:mail andPassword:pass andId:nil];
    
    Travel *travel = [[Travel alloc]initWithType:@"private" andName:self.name.text andPlace:self.place.text andInicialData:0 andFinalData:0 andId:self.identifier  andActivities:nil];
    NSLog( @"COUNT: %lu",(unsigned long)[data count]);
    for (NSInteger i=0;i<data.count;i++){
        NSInteger *idCorrec= [[data objectAtIndex:i]identifier2] ;
        //NSLog( [data objectAtIndex:i]);
        [manager shareTrip:userAux aTravel:(travel ) andIndex:idCorrec];
    }
     [self dismissViewControllerAnimated:YES completion:nil];
    //TODO:
      //    - CRIDA AL MANAGER PER FER EL SHARE!
      //    - OJO, S'HA DE CAPTURAR EL USUARI A COMPARTIR PER A PILLAR EL ID
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
