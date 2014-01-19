//
//  CollectableNode.m
//  WhenAmI
//
//  Created by Will Fairclough on 2014-01-17.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import "CollectableNode.h"
#import "LevelXmlConstants.h"


@implementation CollectableNode


- (id)initWithPosition:(CGPoint)position type:(NSString *)type {
    if (self = [super initWithImageNamed:@"energy_collectable" position:position allowInteraction:NO]) {
        self.name = @"collectable";
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
        self.physicsBody.dynamic = NO;
        self.physicsBody.categoryBitMask = collectableConst;
        self.physicsBody.contactTestBitMask = collectableConst | ballConst;
        
        SKAction *rotation = [SKAction rotateByAngle: M_PI*2 duration:5];
        //and just run the action
        [self runAction: [SKAction repeatActionForever:rotation]];
    }
    
    return self;
}

+ (id)collectableWithPosition:(CGPoint)position type:(NSString *)type {
    return [[CollectableNode alloc] initWithPosition:position type:type];
}

- (void)contactWithBall {
    NSLog(@"CONTACT WITH BALL");
    
    SKAction *collectedNoise = [SKAction playSoundFileNamed:@"Clip1.wav" waitForCompletion:NO];
    [self runAction:collectedNoise];
    
    self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:0.1f];
    self.physicsBody.dynamic = NO;
    self.physicsBody.contactTestBitMask ^= ballConst;
    [self setHidden:TRUE];
    
    
//    
//    SKAction *cannonNoise = [SKAction playSoundFileNamed:@"Level Complete.mp3" waitForCompletion:NO];
//    [self runAction:cannonNoise];
}

#pragma mark - XML Writer

- (NSString *)gameNodeXml {
    return [NSString stringWithFormat:@"\t<%@ x='%f' y='%f'/>", kCollectableTag, self.position.x, self.position.y];
}


@end
