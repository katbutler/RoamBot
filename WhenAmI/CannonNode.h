//
//  CanonNode.h
//  WhenAmI
//
//  Created by Will Fairclough on 2014-01-18.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import "WorldItemNode.h"
#import "BallNode.h"

@interface CannonNode : WorldItemNode

@property (nonatomic, strong) BallNode* ball;
@property (nonatomic) CGFloat rotationRadians;
@property (nonatomic) BOOL isUserPlaced;

+ (id)canonWithPosition:(CGPoint)position rotation:(CGFloat)degrees;

- (void)contactWithBall:(BallNode*)ball;
- (void)fire;
- (void)startRotation;
- (void)stopRotation;

@end
