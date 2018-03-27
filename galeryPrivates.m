#import <Foundation/Foundation.h>
#import "galeryPrivates.h"



#import <AssetsLibrary/AssetsLibrary.h>
#import "PhotoCell.h"
#import "Image.h"



@interface galeryPrivates (){
    NSMutableArray *images;
    int idImageActu;
}
@end

@implementation galleryPrivates


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
    }
    return self;
    
}

-(void) didGetUserInfo:(Manager *)manager withResponse:(id)information{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"ffffaaaa %ld",(long)self.idPath);
    
    // NSMutableArray *activitiesActu;
    
    
    
    for (int i=0; i<[[[[[information objectForKey:@"info"]valueForKey:@"trips"]objectAtIndex:self.idPath]valueForKey:@"img"]count]; i++){
        // if([[[[information objectForKey:@"info"]valueForKey:@"trips"]objectAtIndex:i]valueForKey:@"id"]== self.idTravel){
        
        int id=[[[[[[[information objectForKey:@"info"]valueForKey:@"trips"]objectAtIndex:self.idPath]valueForKey:@"img"]objectAtIndex:i]valueForKey:@"id"]integerValue] ;
        NSString *nom=[[[[[[information objectForKey:@"info"]valueForKey:@"trips"]objectAtIndex:self.idPath]valueForKey:@"img"]objectAtIndex:i]valueForKey:@"nom"];
        NSString *path=[[[[[[information objectForKey:@"info"]valueForKey:@"trips"]objectAtIndex:self.idPath]valueForKey:@"img"]objectAtIndex:i]valueForKey:@"path"];
        UIImage * result;
        
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:path]];
        result = [UIImage imageWithData:data];
        
        
        
        Image *img = [[Image alloc]initWithName:nom andPath:path andId:id andImg:result] ;
        
        
        
        
        //act = [[Activity alloc]initWithName:[
        
        //  [ activitiesActu addObject:[[[[information objectForKey:@"info"]valueForKey:@"trips"]valueForKey:@"act"]objectAtIndex:i]];
        // act = [[Activity alloc]initWithName:[[[[[information objectForKey:@"info"]valueForKey:@"trips"]   valueForKey:@"act"]objectAtIndex:i ] valueForKey:@"nom"] andDescription:  [[[[[information objectForKey:@"info"]valueForKey:@"trips"]  valueForKey:@"act"]objectAtIndex:i ] valueForKey:@"des"]  andPlace: [[[[[information objectForKey:@"info"]valueForKey:@"trips"]valueForKey:@"act"]objectAtIndex:i ] valueForKey:@"loc"]  andPhone: [[[[[information objectForKey:@"info"]valueForKey:@"trips"]valueForKey:@"act"]objectAtIndex:i ] valueForKey:@"pho"]  andMail:[[[[[information objectForKey:@"info"]valueForKey:@"trips"]valueForKey:@"act"]objectAtIndex:i ] valueForKey:@"mai"]    andInicialData: [[[[[information objectForKey:@"info"]valueForKey:@"trips"]valueForKey:@"act"]objectAtIndex:i ] valueForKey:@"dat"]  andFinalData:nil andId:[[[[[information objectForKey:@"info"]valueForKey:@"trips"]valueForKey:@"act"]objectAtIndex:i ] valueForKey:@"id"] ];
        
        
        
        [images addObject:img];
    }
    
    
    
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"ff ff %@",[defaults objectForKey:@"tripId"]);
    self.idTravel =[[defaults objectForKey:@"tripId"]integerValue ];
    NSUserDefaults *credentials = [NSUserDefaults standardUserDefaults];
    images = [[NSMutableArray alloc]init];
    self.idPath =[[defaults objectForKey:@"tripPath"]integerValue ];
    NSString *mail = [credentials stringForKey:@"username"];
    NSString *pass = [credentials stringForKey:@"password"];
    User *userAux = [[User alloc]initWithName:nil andMail:mail andPassword:pass andId:0];
    Manager *manager = [Manager sharedInstance];
    manager.delegate = self;
    [manager getUserInfo:userAux ];
    
    _assets = [@[] mutableCopy];
    __block NSMutableArray *tmpAssets = [@[] mutableCopy];
    ALAssetsLibrary *assetsLibrary = [GalleryViewController2ViewController defaultAssetsLibrary];
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            if(result)
            {
                
                [tmpAssets addObject:result];
            }
        }];
        
        //NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO];
        //self.assets = [tmpAssets sortedArrayUsingDescriptors:@[sort]];
        self.assets = tmpAssets;
        
        [self.collectionView reloadData];
    } failureBlock:^(NSError *error) {
        NSLog(@"Error loading images %@", error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ALAlibrary functions
+ (ALAssetsLibrary *)defaultAssetsLibrary
{
    static dispatch_once_t pred;
    static ALAssetsLibrary *library = nil;
    dispatch_once(&pred, ^{
        library = [[ALAssetsLibrary alloc] init];
    });
    return library;
}

#pragma mark - collection view data source

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return images.count;
}
-(UIImage *) getImageFromURL:(NSString *)fileURL {
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    
    return result;
}

- (void)descarrega {
    for(int i=0;i<images.count;i++){
        UIImage * result;
        
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://store.storeimages.cdn-apple.com/4305/as-images.apple.com/is/image/AppleInc/aos/published/images/i/pa/ipad/air/ipad-air-specs-white-2013?wid=244&hei=258&fmt=png-alpha&qlt=95&.v=1428609247684"]];
        result = [UIImage imageWithData:data];
        
        
    }
    // Dispose of any resources that can be recreated.
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCell *cell = (PhotoCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"photoCell" forIndexPath:indexPath];
    
    UIImage *asset = [[images objectAtIndex:indexPath.row]img];
    cell.photoImageView.image = asset;
    cell.backgroundColor = [UIColor redColor];
    
    return cell;
}

- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 4;
}

- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    idImageActu = [[images objectAtIndex:indexPath.row]identifierImg];
    ALAsset *asset = self.assets[indexPath.row];
    ALAssetRepresentation *defaultRep = [asset defaultRepresentation];
    UIImage *image = [UIImage imageWithCGImage:[defaultRep fullScreenImage] scale:[defaultRep scale] orientation:UIImageOrientationUp];
    
    
    
    
    
    
    UIAlertView *alert3 = [[UIAlertView alloc]
                           initWithTitle:@"Do you want to erase theis?"
                           message:@"\n\n"
                           delegate:self
                           cancelButtonTitle:@"No"
                           otherButtonTitles:@"Save", nil];
    alert3.alertViewStyle = UIAlertViewStyleDefault;
    
    [alert3 show];
    
    
    
    
}
- (void)saveImage: (UIImage*)image
{
    if (image != nil)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString* path = [documentsDirectory stringByAppendingPathComponent:
                          [NSString stringWithString: @"test.png"] ];
        NSData* data = UIImagePNGRepresentation(image);
        [data writeToFile:path atomically:YES];
    }
}


-(void) saveImage:(UIImage *)image withFileName:(NSString *)imageName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath {
    if ([[extension lowercaseString] isEqualToString:@"png"]) {
        [UIImagePNGRepresentation(image) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"png"]] options:NSAtomicWrite error:nil];
    } else if ([[extension lowercaseString] isEqualToString:@"jpg"] || [[extension lowercaseString] isEqualToString:@"jpeg"]) {
        [UIImageJPEGRepresentation(image, 1.0) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"jpg"]] options:NSAtomicWrite error:nil];
    } else {
        NSLog(@"Image Save Failed\nExtension: (%@) is not recognized, use (PNG/JPG)", extension);
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1)
        
    {
        NSUserDefaults *credentials = [NSUserDefaults standardUserDefaults];
        
        NSString *mail = [credentials stringForKey:@"username"];
        NSString *pass = [credentials stringForKey:@"password"];
        User *userAux = [[User alloc]initWithName:nil andMail:mail andPassword:pass andId:0];
        Manager *manager = [Manager sharedInstance];
        manager.delegate = self;
        //[manager getUserActivities:userAux];
        [manager removeImage:userAux andId:(self.idTravel) andImageId:idImageActu];
        //TODO: Recuperar usuari , ID de la imatge i imatge  esborrar
        
    }
    
    else
        
    {
        NSLog(@"cancel");
    }
}


#pragma mark - Actions

- (IBAction)takePhotoButtonTapped:(id)sender
{
    
}

- (IBAction)albumsButtonTapped:(id)sender
{
    
}

@end

