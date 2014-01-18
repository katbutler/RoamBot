//
//  LevelXmlParser.h
//  WhenAmI
//
//  Created by Will Fairclough on 2014-01-17.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import <Foundation/Foundation.h>


#pragma mark - Level Delegate for Setup within the GameScene

@protocol LevelSetupDelegate <NSObject>
@optional
- (void) setupLevelNumber:(NSInteger)levelNum;
- (void) setupWorldType:(NSString*)worldType;

- (void) setupPlankWithXPosition:(float)x yPosition:(float)y allowInteraction:(BOOL)isInteractable rotationAngle:(float)rotation  powered:(BOOL)powered theme:(NSString*)theme;
- (void) setupBallWithXPosition:(float)x yPosition:(float)y allowInteraction:(BOOL)isInteractable;
- (void) setupWallWithPosition:(float)x yPosition:(float)y allowInteraction:(BOOL)isInteractable rotation:(CGFloat)degrees theme:(NSString*)theme imageSize:(NSString*)imageSize;
- (void) setupGoalWithXPosition:(float)x yPosition:(float)y rotationAngle:(float)degrees theme:(NSString *)theme;
- (void) setupCanonWithXPosition:(float)x yPosition:(float)y rotationAngle:(float)degrees;
- (void) setupCollectableWithXPosition:(float)x yPosition:(float)y type:(NSString*)type;



@end


#pragma mark - LevelXmlParser Interface

@interface LevelXmlParser : NSXMLParser <NSXMLParserDelegate>

@property (nonatomic, strong) NSString* worldTheme;

@property (nonatomic, weak) id <LevelSetupDelegate> setupDelegate;

@end
