#import "WebSocketClient.h"

@interface WebSocketClient() <NSURLSessionWebSocketDelegate>
@property (atomic,strong) NSURLSessionWebSocketTask *webSocketTask;
-(void)receive;
@end

@implementation WebSocketClient {
    void (^didReceived)(NSString *);
}

-(instancetype)initWithClosure:(void (^)(NSString *))receive {
    self = [super init];
    if (self) {
        didReceived = receive;
    }
    return self;
}

-(instancetype)init {
    self = [super init];
    if (self) {}
    return self;
}

-(void)didReceive: (void (^)(NSString *))receive {
    didReceived = receive;
}

-(void)setup:(NSString *)url {
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];

    NSURLSession *session = [NSURLSession sessionWithConfiguration: sessionConfig
                                                          delegate: self
                                                     delegateQueue: [[NSOperationQueue alloc] init]];

    self.webSocketTask = [session webSocketTaskWithURL:[NSURL URLWithString:url]];
}

-(void)connect {
    [self.webSocketTask resume];
    [self receive];
}

-(void)receive {
    [self.webSocketTask receiveMessageWithCompletionHandler:^(NSURLSessionWebSocketMessage *message, NSError *error) {
        if (message.string) {
            didReceived(message.string);
        }
        else if (message.data) {
            NSString *_message = [[NSString alloc] initWithData: message.data encoding: NSUTF8StringEncoding];
            didReceived(_message);
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
        [self receive];
    }];
}

-(void)send:(NSString *)message {
    NSURLSessionWebSocketMessage *_message = [[NSURLSessionWebSocketMessage alloc] initWithString:message];
    [self.webSocketTask sendMessage:_message completionHandler:^(NSError *error) {
        if (error) {
            NSLog(@"send error");
        }
    }];
}

-(void)URLSession:(NSURLSession *)session webSocketTask:(NSURLSessionWebSocketTask *)webSocketTask didOpenWithProtocol:(NSString *)protocol {
    NSLog(@"connected");
    [self receive];
}
-(void)URLSession:(NSURLSession *)session webSocketTask:(NSURLSessionWebSocketTask *)webSocketTask didCloseWithCode:(NSURLSessionWebSocketCloseCode)code reason:(NSData *)reason {
    //error
    NSLog(@"error");
}
@end
