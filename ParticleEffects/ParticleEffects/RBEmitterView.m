//
//  RBEmitterView.m
//  ParticleEffects
//
//  Created by Robert Brown on 8/4/12.
//  Copyright (c) 2012 Robert Brown. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "RBEmitterView.h"
#import "UIImage+BBlock.h"


const CGFloat kBirthRate = 100.0f;
const NSTimeInterval kBurstDuration = 0.3;

NSString * const kParticleName      = @"Particle";
NSString * const kRedParticleName   = @"RedParticle";
NSString * const kBlueParticleName  = @"BlueParticle";
NSString * const kGreenParticleName = @"GreeParticle";


@interface RBEmitterView ()

@property (nonatomic, assign) CGFloat birthRate;

@property (nonatomic, assign) CGFloat longitude;

@end


@implementation RBEmitterView

@synthesize type       = _type;
@synthesize mode       = _mode;
@synthesize isEmitting = _isEmitting;
@synthesize birthRate  = _birthRate;

+ (Class)layerClass {
    
    // We need to use an emitter layer to get particle effects.
    return [CAEmitterLayer class];
}

- (void)awakeFromNib {
    
    CAEmitterLayer * emitter = (CAEmitterLayer *)self.layer;
    
    // Configures the emitter layer
    emitter.emitterPosition = CGPointMake(50.0f, 50.0f);
    emitter.emitterSize = CGSizeMake(5.0f, 5.0f);
    emitter.renderMode = kCAEmitterLayerAdditive;
    
    // Sets up the particles.
    [self setType:RBRedParticleType];
}

- (void)spiral {
    
    double delayInSeconds = 0.1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        if (self.mode == RBSpiralEmitterMode) {
            
            CAEmitterLayer * emitter = (CAEmitterLayer *)self.layer;
            self.longitude += M_PI / 20.0f;
            emitter.emitterCells = [self cellsForType:[self type]];
            [self spiral];
        }
    });
}


#pragma mark - Particle cells

- (UIImage *)particleImage {
    
    return [UIImage imageForSize:CGSizeMake(10.0f, 10.0f)
                withDrawingBlock:
            ^{
                // Star Drawing
                UIBezierPath * starPath = [UIBezierPath bezierPath];
                [starPath moveToPoint:CGPointMake(5.0f, -0.0f)];
                [starPath addLineToPoint:CGPointMake(3.85f, 2.23f)];
                [starPath addLineToPoint:CGPointMake(1.46f, 1.46f)];
                [starPath addLineToPoint:CGPointMake(2.23f, 3.85f)];
                [starPath addLineToPoint:CGPointMake(0.00f, 5.00f)];
                [starPath addLineToPoint:CGPointMake(2.23f, 6.15f)];
                [starPath addLineToPoint:CGPointMake(1.46f, 8.54f)];
                [starPath addLineToPoint:CGPointMake(3.85f, 7.77f)];
                [starPath addLineToPoint:CGPointMake(5.00f, 10.0f)];
                [starPath addLineToPoint:CGPointMake(6.15f, 7.77f)];
                [starPath addLineToPoint:CGPointMake(8.54f, 8.54f)];
                [starPath addLineToPoint:CGPointMake(7.77f, 6.15f)];
                [starPath addLineToPoint:CGPointMake(10.0f, 5.00f)];
                [starPath addLineToPoint:CGPointMake(7.77f, 3.85f)];
                [starPath addLineToPoint:CGPointMake(8.54f, 1.46f)];
                [starPath addLineToPoint:CGPointMake(6.15f, 2.23f)];
                [starPath closePath];
                
                [[UIColor whiteColor] setFill];
                [starPath fill];
                
                [[UIColor whiteColor] setStroke];
                starPath.lineWidth = 1.0f;
                [starPath stroke];
            }];
}

- (CAEmitterCell *)basicEmitterCell {
    
    // Creates a cell with the common values.
    CAEmitterCell * particle = [CAEmitterCell emitterCell];
    particle.birthRate = self.birthRate;
    particle.lifetime = 0.5f;
    particle.lifetimeRange = 0.2f;
    particle.contents = (id)[[self particleImage] CGImage];
    [particle setName:kParticleName];
    
    particle.velocity = 100.0f;
    particle.velocityRange = 20.0f;
    particle.scaleSpeed = 0.3f;
    particle.spin = 0.5f;
    
    if (self.mode == RBSpiralEmitterMode) {
        
        particle.emissionRange = -M_PI / 2;
        particle.emissionLongitude = self.longitude;
    }
    else {
        particle.emissionRange = 2.0f * M_PI;
    }
    
    return particle;
}

- (CAEmitterCell *)redParticleCell {
    
    CAEmitterCell * redParticle = [self basicEmitterCell];
    redParticle.color = [[UIColor colorWithRed:0.8f
                                         green:0.4f
                                          blue:0.2f
                                         alpha:0.1f] CGColor];
    [redParticle setName:kRedParticleName];
    
    return redParticle;
}

- (CAEmitterCell *)blueParticleCell {
    
    CAEmitterCell * blueParticle = [self basicEmitterCell];
    blueParticle.color = [[UIColor colorWithRed:0.2f
                                          green:0.4f
                                           blue:0.8f
                                          alpha:0.1f] CGColor];
    [blueParticle setName:kBlueParticleName];
    
    return blueParticle;
}

- (CAEmitterCell *)greenParticleCell {
    
    CAEmitterCell * greenParticle = [self basicEmitterCell];
    greenParticle.color = [[UIColor colorWithRed:0.2f
                                          green:0.8f
                                           blue:0.4f
                                          alpha:0.1f] CGColor];
    [greenParticle setName:kGreenParticleName];
    
    return greenParticle;
}

- (NSArray *)cellsForType:(RBParticleType)type {
    
    switch (type) {
            
        case RBRedParticleType:
            return @[[self redParticleCell]];
            
        case RBBlueParticleType:
            return @[[self blueParticleCell]];
            
        case RBGreenParticleType:
            return @[[self greenParticleCell]];
            
        case RBMixedParticleType:
            return @[[self redParticleCell], [self blueParticleCell], [self greenParticleCell]];
            
        default:
            NSAssert(NO, @"Unknown particle type.");
            return nil;
    }
}


#pragma mark - Public methods

- (void)setMode:(RBEmitterMode)mode {
    
    if (_mode != mode) {
        
        [self willChangeValueForKey:@"mode"];
        
        _mode = mode;
        
        // If burst mode, then cause the particle emitter to spin. 
        if (_mode == RBSpiralEmitterMode)
            [self spiral];
        // If burst mode, then stop emitting after the burst duration.
        else if ([self mode] == RBBurstEmitterMode) {
            
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, kBurstDuration * NSEC_PER_SEC);
            
            dispatch_after(popTime, dispatch_get_main_queue(), ^{
                
                [self setIsEmitting:NO];
            });
        }
        
        CAEmitterLayer * emitter = (CAEmitterLayer *)self.layer;
        
        // Updates the particles for the given type.
        emitter.emitterCells = [self cellsForType:self.type];
        
        [self didChangeValueForKey:@"mode"];
    }
}

- (void)setType:(RBParticleType)type {
    
    if (_type != type) {
        
        [self willChangeValueForKey:@"type"];
        
        _type = type;
        
        // Updates the particles for the given type.
        CAEmitterLayer * emitter = (CAEmitterLayer *)self.layer;
        emitter.emitterCells = [self cellsForType:type];
        
        [self didChangeValueForKey:@"type"];
    }
}

- (void)setEmitterPosition:(CGPoint)position {
    
    CAEmitterLayer * emitter = (CAEmitterLayer *)self.layer;
    
    // Changes the emitter's position
    emitter.emitterPosition = position;
    
    // Starts the emitter, if not already.
    [self setIsEmitting:YES];
    
    // If burst mode, then stop emitting after the burst duration.
    if ([self mode] == RBBurstEmitterMode) {

        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, kBurstDuration * NSEC_PER_SEC);
        
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            
            [self setIsEmitting:NO];
        });
    }
}

- (BOOL)isEmitting {
    
    CAEmitterLayer * emitter = (CAEmitterLayer *)self.layer;
    
    return ([[emitter.emitterCells lastObject] birthRate] > 0.0f);
}

- (void)setIsEmitting:(BOOL)isEmitting {
    
    [self willChangeValueForKey:@"isEmitting"];
    
    // Turns on/off the emitting of particles.
    self.birthRate = isEmitting ? kBirthRate : 0.0f;
    
    CAEmitterLayer * emitter = (CAEmitterLayer *)self.layer;
    emitter.emitterCells = [self cellsForType:[self type]];
    
    [self didChangeValueForKey:@"isEmitting"];
}

@end
