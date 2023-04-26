#import "Position.h"

@implementation Position

-(CGPoint)getPoint {
    return CGPointMake(self.x, self.y);
}

-(instancetype)initWithArray:(NSArray *)arr {
    self = [super init];
    if (self) {
        self.x = [arr[0] floatValue];
        self.y = [arr[1] floatValue];
        self.mode = (TouchMode)[arr[2] integerValue];
    }
    return self;
}

-(instancetype)initWithString:(NSString *)string {
    NSArray* arr = [string componentsSeparatedByString: @","];
    return [self initWithArray: arr];
}

@end
