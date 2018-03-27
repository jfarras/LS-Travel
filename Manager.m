#import "Manager.h"
#import "User.h"


@interface Manager(){
    NSMutableData *responseData;
    BOOL addingTravel;
    BOOL gettingInfo;
    BOOL erasingTravel;
    BOOL recovery;
}

@end

@implementation Manager



+(id)sharedInstance{
    static Manager *sharedManager;
    if(!sharedManager){
        sharedManager = [[Manager alloc]init];
    }
    return sharedManager;
}

#pragma mark - server functions

-(void) recovery:(NSString *)mail{
    NSLog(mail);
    NSString *postParams = [NSString stringWithFormat:@"method=recovery&mai=%@",mail];
    NSURL *url = [NSURL URLWithString:@"http://so.housing.salle.url.edu/ms/lstravel.php"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[postParams dataUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection connectionWithRequest:request delegate:self];
    recovery=true;
    
}

-(void)loginWithUser:(User*)aUser{
    recovery=false;
    //Crear una conexió amb webService i invocar el mètode "login"
    NSString *postParams = [NSString stringWithFormat:@"method=login&mai=%@&pwd=%@", aUser.userName, aUser.password, nil];
    NSURL *url = [NSURL URLWithString:@"http://so.housing.salle.url.edu/ms/lstravel.php"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[postParams dataUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection connectionWithRequest:request delegate:self];
    
}

-(void) updateTrip:(User *)aUser andTravel: (Travel *)aTravel{
    
    NSString *identifier = [NSString stringWithFormat:@"%ld", (long)aTravel.Id];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *DateInici = [formatter stringFromDate:aTravel.inicialData];
    NSString *DateIfinal = [formatter stringFromDate:aTravel.finalData];
    
    NSString * postParams = [NSString stringWithFormat:@"method=update-trip&mai=%@&pwd=%@&tripID=%@&name=%@&pla=%@&arr=%@&dep=%@", aUser.userName,aUser.password,identifier, aTravel.Travelname, aTravel.TravelPlace, DateInici,DateIfinal, nil];
    NSURL *url = [NSURL URLWithString:@"http://so.housing.salle.url.edu/ms/lstravel.php"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[postParams dataUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection connectionWithRequest:request delegate:self];
    
}

-(void) shareTrip:(User *)aUser aTravel: (Travel *)aTravel andIndex : (int)index {
    
    NSString *identifier = [NSString stringWithFormat:@"%ld", (long)aTravel.Id];
    NSString *usrIndex = [NSString stringWithFormat:@"%ld", (long)index];
    NSLog(identifier);
    
    NSString * postParams = [NSString stringWithFormat:@"method=share&mai=%@&pwd=%@&tripID=%@&userID=%@", aUser.userName,aUser.password,identifier, usrIndex];
    NSURL *url = [NSURL URLWithString:@"http://so.housing.salle.url.edu/ms/lstravel.php"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[postParams dataUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection connectionWithRequest:request delegate:self];
    
}

//-(void) shareTrip:(User *)aUser and

-(void)registerUser:(User *)aUser{
    NSString *postParams = [NSString stringWithFormat:@"method=signup&usr=%@&mai=%@&pwd=%@", aUser.name, aUser.userName,aUser.password, nil];
    NSURL *url = [NSURL URLWithString:@"http://so.housing.salle.url.edu/ms/lstravel.php"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[postParams dataUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection connectionWithRequest:request delegate:self];
    recovery=true;
}

-(void) getUsers{
    NSString *postParams = [NSString stringWithFormat:@"method=get-all-users", nil];
    NSURL *url = [NSURL URLWithString:@"http://so.housing.salle.url.edu/ms/lstravel.php"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[postParams dataUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

-(void) addTravel:(Travel *)aTravel andUser:(User *)aUser{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *DateInici = [formatter stringFromDate:aTravel.inicialData];
    NSString *DateIfinal = [formatter stringFromDate:aTravel.finalData];
    
    NSString * postParams = [NSString stringWithFormat:@"method=create-trip&mai=%@&pwd=%@&nom=%@&pla=%@&arr=%@&dep=%@", aUser.userName,aUser.password, aTravel.Travelname, aTravel.TravelPlace, DateInici,DateIfinal, nil];
    NSURL *url = [NSURL URLWithString:@"http://so.housing.salle.url.edu/ms/lstravel.php"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[postParams dataUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection connectionWithRequest:request delegate:self];
    addingTravel = true;
    
}

-(void) getUserInfo:(User *)aUser{
    
    NSString *postParams = [NSString stringWithFormat:@"method=get-info&mai=%@&pwd=%@", aUser.userName, aUser.password, nil];
    NSURL *url = [NSURL URLWithString:@"http://so.housing.salle.url.edu/ms/lstravel.php"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[postParams dataUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection connectionWithRequest:request delegate:self];
    gettingInfo = true;
}
-(void) removeImage:(User *)aUser andId: (NSInteger )atravelId andImg:(int) aImg{
    NSString *imgIndex = [NSString stringWithFormat:@"%d", aImg];
    NSString *postParams = [NSString stringWithFormat:@"method=remove-image&mai=%@&pwd=%@&tripID=%ld&imageID=%@",aUser.userName, aUser.password, (long)atravelId,imgIndex];
    NSURL *url = [NSURL URLWithString:@"http://so.housing.salle.url.edu/ms/lstravel.php"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[postParams dataUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection connectionWithRequest:request delegate:self];
    
    
    
}
-(void)removeTravel:(Travel *)aTravel andUser:(User *)aUser{
    NSString *identifier = [NSString stringWithFormat:@"%ld", (long)aTravel.Id];
    NSLog(@"IDENTIFIER: %@", identifier);
    NSString *postParams = [NSString stringWithFormat:@"method=remove-trip&mai=%@&pwd=%@&tripID=%@",aUser.userName, aUser.password, identifier, nil];
    NSURL *url = [NSURL URLWithString:@"http://so.housing.salle.url.edu/ms/lstravel.php"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[postParams dataUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection connectionWithRequest:request delegate:self];
    erasingTravel = true;
    
}

-(void)addActivity:(Activity *)aActivity andUser:(User *)aUser andId:(NSString *)aId{
    
    NSString *postParams = [NSString stringWithFormat:@"method=add-activity&mai=%@&pwd=%@&tripID=%@&name=%@&date=%@&desc=%@&loca=%@&mail=%@&phon=%@",aUser.userName, aUser.password, aId,aActivity.activityName, aActivity.inicialData,aActivity.activityDescription,aActivity.activityPlace, aActivity.activityMail, aActivity.activityPhone, nil];
    NSURL *url = [NSURL URLWithString:@"http://so.housing.salle.url.edu/ms/lstravel.php"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[postParams dataUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

-(void)getUserActivities:(User *)aUser{
    NSString *postParams = [NSString stringWithFormat:@"method=get-info&mai=%@&pwd=%@", aUser.userName, aUser.password, nil];
    NSURL *url = [NSURL URLWithString:@"http://so.housing.salle.url.edu/ms/lstravel.php"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[postParams dataUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection connectionWithRequest:request delegate:self];
    
}
-(void)removeActivity:(Activity *)aActivity andUser:(User *)aUser andId:(NSString *)aId{
    
    NSString *inStr = [NSString stringWithFormat: @"%d", (int)aActivity.identifier];
    
    
    NSString *postParams = [NSString stringWithFormat:@"method=remove-activity&mai=%@&pwd=%@&tripID=%@&activityID=%@" ,aUser.userName, aUser.password, aId,inStr] ;
    NSURL *url = [NSURL URLWithString:@"http://so.housing.salle.url.edu/ms/lstravel.php"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[postParams dataUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection connectionWithRequest:request delegate:self];
}
-(void)addImage:(User *)aUser andId:(NSInteger )atravelId andName:(NSString *)aName andImg:(NSString *)aImg{
    NSString *postParams = [NSString stringWithFormat:@"method=add-image&mai=%@&pwd=%@&tripID=%ld&name=%@&img=%@",aUser.userName, aUser.password, (long)atravelId,aName, aImg, nil];
    NSURL *url = [NSURL URLWithString:@"http://so.housing.salle.url.edu/ms/lstravel.php"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[postParams dataUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection connectionWithRequest:request delegate:self];
    
}

-(void) removeImage:(User *) aUser andId:(NSInteger)atravelId andImageId:(int) aImgId{
     NSString *inStr = [NSString stringWithFormat: @"%d", (int)aImgId];
    NSString *postParams = [NSString stringWithFormat:@"method=remove-image&mai=%@&pwd=%@&tripID=%ld&imageID=%@", aUser.userName, aUser.password,(long)atravelId, inStr];
    NSURL *url = [NSURL URLWithString:@"http://so.housing.salle.url.edu/ms/lstravel.php"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[postParams dataUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection connectionWithRequest:request delegate:self];
}



#pragma mark - connections

-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{}
-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [responseData appendData:data];
}
-(void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    responseData = [[NSMutableData alloc]init];
    
}

-(void) connectionDidFinishLoading:(NSURLConnection *)connection{
    NSError *error;
    id responseObject;
    NSDictionary * serverResponse = [[NSDictionary alloc]init];
    serverResponse =[NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
    responseObject = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
    
    if ([self.delegate respondsToSelector:@selector(didFinishLogin:withResponse:)]&&!recovery) {
        
        [self.delegate didFinishLogin:self withResponse:responseObject];
        
    }else{
        if ([self.delegate respondsToSelector:@selector(didFinishRegister:withResponse:)]){
            [self.delegate didFinishRegister:self withResponse:responseObject];
            
        }else{
            if ([self.delegate respondsToSelector:@selector(didGetUsers:withResponse:)]){
                [self.delegate didGetUsers:self withResponse:serverResponse];
            }else{
                if ([self.delegate respondsToSelector:@selector(didAddTravel:withResponse:)] && addingTravel){
                    [self.delegate didAddTravel:self withResponse:responseObject];
                    addingTravel = false;
                }else{
                    if ([self.delegate respondsToSelector:@selector(didGetUserInfo:withResponse:)]&& gettingInfo){
                        [self.delegate didGetUserInfo:self withResponse:responseObject];
                        gettingInfo = false;
                        
                    }else{
                        if ([self.delegate respondsToSelector:@selector(didRemoveTravel:withResponse:)] && erasingTravel){
                            [self.delegate didRemoveTravel:self withResponse:responseObject];
                            erasingTravel = false;
                        }else{
                            if ([self.delegate respondsToSelector:@selector(didAddActivity:withResponse:)]){
                                [self.delegate didAddActivity:self withResponse:responseObject];
                                
                            }else{
                                if ([self.delegate respondsToSelector:@selector(didGetUserActivities:withResponse:)]){
                                    
                                    [self.delegate didGetUserActivities:self withResponse:responseObject];
                                    
                                }else{
                                    
                                    
                                        if ([self.delegate respondsToSelector:@selector(didAddImage:withResponse:)]){
                                            recovery=false;
                                            [self.delegate didAddImage:self withResponse:responseObject];
                                        }
                                        else{}
                                        
                                    
                                    
                                }
                                
                            }
                            
                            
                        }
                        
                    }
                    
                }
                
            }
        }
        
    }
}


@end
