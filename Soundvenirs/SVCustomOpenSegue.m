#import "SVCustomOpenSegue.h"
#import "SVMenuViewController.h"

@implementation SVCustomOpenSegue

-(void) perform {
    if ([self.sourceViewController isKindOfClass:[SVMenuViewController class]]) {
        [(SVMenuViewController *)self.sourceViewController presentDetailController:self.destinationViewController];
        return;
    }
    
    [(SVMenuViewController *)[[self sourceViewController] parentViewController] presentDetailController:self.destinationViewController];
}

@end