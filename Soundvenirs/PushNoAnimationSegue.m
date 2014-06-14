#import "PushNoAnimationSegue.h"

@implementation PushNoAnimationSegue

-(void) perform {
    [[[self sourceViewController] navigationController] pushViewController:[self destinationViewController] animated:NO];
}

@end