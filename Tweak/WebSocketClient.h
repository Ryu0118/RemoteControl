#import <Foundation/Foundation.h>

@interface WebSocketClient : NSObject
-(void)setup:(NSString *)url;
-(void)connect;
-(void)send:(NSString *)message;
-(instancetype)init;
-(void)didReceive: (void (^)(NSString *))receive;
-(instancetype)initWithClosure:(void (^)(NSString *))receive;
@end
