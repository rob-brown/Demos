//
//  RBEmitterView.h
//  ParticleEffects
//
//  Created by Robert Brown on 8/4/12.
//  Copyright (c) 2012 Robert Brown. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
    RBRedParticleType = 0,
    RBBlueParticleType,
    RBGreenParticleType,
    RBMixedParticleType,
} RBParticleType;

typedef enum {
    RBContinuousEmitterMode = 0,
    RBBurstEmitterMode,
    RBSpiralEmitterMode,
} RBEmitterMode;


@interface RBEmitterView : UIView

@property (nonatomic, assign) RBParticleType type;

@property (nonatomic, assign) RBEmitterMode mode;

@property (nonatomic, assign) BOOL isEmitting;

- (void)setEmitterPosition:(CGPoint)position;

@end
