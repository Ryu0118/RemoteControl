#ifndef TOUCH_SIMULATOR
#define TOUCH_SIMULATOR

#include "headers/IOHIDEvent.h"
#include "headers/IOHIDEventData.h"
#include "headers/IOHIDEventTypes.h"
#include "headers/IOHIDEventSystemClient.h"
#include "headers/IOHIDEventSystem.h"
#include <mach/mach_time.h>
#import <UIKit/UIApplication.h>
#import <UIKit/UIWindow.h>

#define kIOHIDEventDigitizerSenderID 0xDEFACEDBEEFFECE5

@interface UIApplication()
-(void)_enqueueHIDEvent:(IOHIDEventRef)arg1;
@end

@interface UIWindow()
-(unsigned)_contextId;
@end

typedef enum {
    TOUCH_UP,
    TOUCH_DOWN,
    TOUCH_MOVE
} TouchType;

void simulateTouch(TouchType type, float x, float y);

#endif
