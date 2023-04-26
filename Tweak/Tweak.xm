#import "Position.h"
#import "TouchSimulator.h"
#import "WebSocketClient.h"

%ctor {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 5.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        WebSocketClient *client = [[WebSocketClient alloc] init];
        [client didReceive: ^(NSString *response) {
            Position *position = [[Position alloc] initWithString: response];
            switch (position.mode) {
                case BEGAN://began
                    simulateTouch(TOUCH_DOWN, position.x, position.y);
                    break;
                case CHANGED://changed
                    simulateTouch(TOUCH_MOVE, position.x, position.y);
                    break;
                case ENDED://ended
                    simulateTouch(TOUCH_UP, position.x, position.y);
                    break;
                case TAPPED:
                {
                    simulateTouch(TOUCH_DOWN, position.x, position.y);
                    simulateTouch(TOUCH_UP, position.x, position.y);
                    break;
                }
                default:
                    break;
            }
        }];
        [client setup:@"ws://192.168.0.33:8020"];
        [client connect];
    });
}
