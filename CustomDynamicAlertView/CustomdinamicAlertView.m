#import "CustomdinamicAlertView.h"

@interface CustomdinamicAlertView () <UICollisionBehaviorDelegate>
@property (nonatomic,weak) UIView *alertView;
@property (nonatomic, strong) UIDynamicAnimator *mainAnimator;
@property (nonatomic, strong) UISnapBehavior *snapBehavior;

@end

static CGFloat const buttonHeight = 50;
static CGFloat const alertWidth = 250;
static CGFloat const alertHeight = 150;
static NSString const *kBoundaryID = @"outsideBoundary";


@implementation CustomdinamicAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeCustomProperties];
    }
    return self;
}

- (void)initializeCustomProperties {
    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.6];
    [self createAlertView];
    [self initializeDynamics];
}

- (void)createAlertView {
    
    
    UIView *alertView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.bounds)/2 - alertWidth/2,
                                                                -400,
                                                                alertWidth,
                                                                alertHeight)];
    alertView.backgroundColor = [UIColor whiteColor];
    alertView.layer.cornerRadius = 10;
    [self addSubview:alertView];
    self.alertView = alertView;
    
    UIButton *dismissButton = [UIButton buttonWithType:UIButtonTypeSystem];
    dismissButton.frame = CGRectMake(0, alertHeight - buttonHeight, alertWidth, buttonHeight);
    [dismissButton setTitle:@"Dismiss" forState:UIControlStateNormal];
    [dismissButton addTarget:self action:@selector(dismissButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    dismissButton.tintColor = [UIColor redColor];
    [alertView addSubview:dismissButton];
    
}

- (void)initializeDynamics {
    self.mainAnimator = [[UIDynamicAnimator alloc]initWithReferenceView:self];
    self.snapBehavior = [[UISnapBehavior alloc]initWithItem:self.alertView snapToPoint:CGPointMake(CGRectGetWidth(self.bounds)/2, CGRectGetHeight(self.bounds)/2)];
    [self.mainAnimator addBehavior:self.snapBehavior];
    
}

- (void)dismissButtonPressed {
    [self.mainAnimator removeAllBehaviors];
    UIGravityBehavior *gravityB = [[UIGravityBehavior alloc]initWithItems:@[self.alertView]];
    gravityB.magnitude = 4.0;
    [self.mainAnimator addBehavior:gravityB];
    
    UIPushBehavior *pushB = [[UIPushBehavior alloc]initWithItems:@[self.alertView] mode:UIPushBehaviorModeInstantaneous];
    [pushB setAngle:-(M_PI_2 * 0.8) magnitude:25.0];
    [self.mainAnimator addBehavior:pushB];
    
    UICollisionBehavior *collisionB = [[UICollisionBehavior alloc]initWithItems:@[self.alertView]];
    
    [collisionB addBoundaryWithIdentifier:kBoundaryID
                                fromPoint:CGPointMake(0, CGRectGetHeight(self.bounds) + alertHeight)
                                  toPoint:CGPointMake(CGRectGetWidth(self.bounds) * 2, CGRectGetHeight(self.bounds) + alertHeight)];
    
    
    collisionB.collisionDelegate = self;
    [self.mainAnimator addBehavior:collisionB];
}

#pragma mark -  CollisionDelegate

- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p {
    if (identifier == kBoundaryID) {
        [self removeFromSuperview];
    }
}

@end