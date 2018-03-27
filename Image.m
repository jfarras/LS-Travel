
#import "Image.h"

@implementation Image

-(id)initWithName:(NSString *)aName andPath:(NSString *)aPath andId:(int)aId andImg:(UIImage *)aImg{
    if(self = [super init]){
        _name = aName;
        _path = aPath;
        _identifierImg = aId;
        _img = aImg;
        
    }
    return self;
    
}



@end
