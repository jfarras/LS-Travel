#import "GalleryViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "PhotoCell.h"
#import "Image.h"



@interface GalleryViewController (){
    NSMutableArray *images;
    int idImageActu;
}
@end

@implementation GalleryViewController

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
    
    
      [self.collectionView reloadData];
    
    
}



- (void)viewDidLoad {
    
    [super viewDidLoad];

    UICollectionViewFlowLayout *collectionViewLayout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    collectionViewLayout.sectionInset = UIEdgeInsetsMake(80, 0, 0, 0);
    
    
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
    ALAssetsLibrary *assetsLibrary = [GalleryViewController defaultAssetsLibrary];
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
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"OK"
                                                        message:@"Image removed. Refresh!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        //TODO: Recuperar usuari , ID de la imatge i imatge  esborrar
       
        /*[self.collectionView performBatchUpdates:^{
            
            NSIndexPath *indexPath =[NSIndexPath indexPathForRow:buttonIndex inSection:0];
            [self.collectionView deleteItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
            
        } completion:^(BOOL finished) {
            
        }];*/
        
        
    }
    
    else
        
    {
        NSLog(@"cancel");
    }
}
/*
 Get Image From URL
 
 
 Save Image
 
 -(void) saveImage:(UIImage *)image withFileName:(NSString *)imageName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath {
 if ([[extension lowercaseString] isEqualToString:@"png"]) {
 [UIImagePNGRepresentation(image) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"png"]] options:NSAtomicWrite error:nil];
 } else if ([[extension lowercaseString] isEqualToString:@"jpg"] || [[extension lowercaseString] isEqualToString:@"jpeg"]) {
 [UIImageJPEGRepresentation(image, 1.0) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"jpg"]] options:NSAtomicWrite error:nil];
 } else {
 NSLog(@"Image Save Failed\nExtension: (%@) is not recognized, use (PNG/JPG)", extension);
 }
 }
 Load Image
 
 -(UIImage *) loadImage:(NSString *)fileName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath {
 UIImage * result = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.%@", directoryPath, fileName, extension]];
 
 return result;
 }
 How-To
 
 //Definitions
 NSString * documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
 
 //Get Image From URL
 UIImage * imageFromURL = [self getImageFromURL:@"http://www.yourdomain.com/yourImage.png"];
 
 //Save Image to Directory
 [self saveImage:imageFromURL withFileName:@"My Image" ofType:@"png" inDirectory:documentsDirectoryPath];
 
 //Load Image From Directory
 UIImage * imageFromWeb = [self loadImage:@"My Image" ofType:@"png" inDirectory:documentsDirectoryPath];
 */

#pragma mark - Actions

- (IBAction)takePhotoButtonTapped:(id)sender
{
    
}

- (IBAction)albumsButtonTapped:(id)sender
{
    
}

@end

