#import <UIKit/UIKit.h>

typedef enum {
    BEGAN = 0,
    CHANGED = 1,
    ENDED = 2,
    TAPPED = 3
}TouchMode;

@interface Position : NSObject

@property float x;
@property float y;
@property TouchMode mode;

-(instancetype)initWithString:(NSString *)string;
-(CGPoint)getPoint;
@end
