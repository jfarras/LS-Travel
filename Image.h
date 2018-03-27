
#import "GalleryViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "PhotoCell.h"
#import <Foundation/Foundation.h>

@interface Image : NSObject

@property (nonatomic, assign) int identifierImg;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *path;
@property (nonatomic,copy)  UIImage *img;
-(id)initWithName:(NSString *)aName andPath:(NSString *)aPath andId:(int)aId andImg:(UIImage *)aImg;

@end
