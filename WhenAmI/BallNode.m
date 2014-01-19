//
//  BallNode.m
//  WhenAmI
//
//  Created by Will Fairclough on 2014-01-17.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import "BallNode.h"
#import "LevelXmlConstants.h"


@implementation BallNode

- (id) initWithPosition:(CGPoint)position {
    if (self = [super initWithImageNamed:@"ball" position:position allowInteraction:NO]) {
        self.name = @"ball";
        self.zPosition = 1000.0f;
        [[self childNodeWithName:@"bounding"] setScale:1.6];
        self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.size.width/2];
        self.physicsBody.dynamic = NO;
        self.physicsBody.restitution = 0.75;
        self.physicsBody.categoryBitMask = ballConst;
        self.physicsBody.collisionBitMask ^= collectableConst | goalConst;
//        self.physicsBody.contactTestBitMask =  ballConst;
    }
    
    return self;
}

+ (id)ballWithPosition:(CGPoint)position {
    return [[BallNode alloc] initWithPosition:position];
}



#pragma mark - XML Writer

- (NSString *)gameNodeXml {
    return [NSString stringWithFormat:@"\t<%@ x='%f' y='%f'></%@>", kBallTag, self.position.x, self.position.y, kBallTag];
}


@end
