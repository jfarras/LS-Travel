#import "ViewActivityViewController.h"

@interface ViewActivityViewController ()

@end

@implementation ViewActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name.text = self.nameToShow;
    self.place.text = self.placeToShow;
    self.phone.text = self.phoneToShow;
    self.mail.text = self.mailToShow;
    self.dateInici.text = self.inicialDateToShow;
    self.dateFinal.text = self.finalDateToShow;
    self.descr.text = self.descrToShow;
    self.descr.layer.borderColor = [[UIColor blackColor]CGColor];
    self.descr.layer.borderWidth = 1.0f;
    
    //MAP LOCATION
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:self.placeToShow completionHandler:^(NSArray *placemarks, NSError *error) {
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

#pragma mark Buttons

-(IBAction)backButtonTouched{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)callButtonTouched{
    
    NSString *num = [NSString stringWithFormat:@"tel://%@", self.phone.text];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]];
}

-(IBAction)contactButtonTouched{
    NSLog(@"CONTACT");
    NSString *recipients = @"mailto:?subject=subjecthere";
    NSString *body = @"&body=bodyHere";
    
    NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
    email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
