//
//  LevelXmlParser.m
//  WhenAmI
//
//  Created by Will Fairclough on 2014-01-17.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import "LevelXmlParser.h"
#import "LevelXmlConstants.h"

#pragma mark - Private Methods

@interface LevelXmlParser()
@property (nonatomic, strong) NSMutableString* currentStringValue;
@end


#pragma mark - Level XML Parser Implementation

@implementation LevelXmlParser


- (id)initWithData:(NSData *)data
{
    self = [super initWithData:data];
    if (self) {
        self.delegate = self;
    }
    
    return self;
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    
    if ([elementName isEqualToString:kLevelTag]){
        if ([self.setupDelegate respondsToSelector:@selector (setupLevelNumber:)]) {
            [self.setupDelegate setupLevelNumber:[[attributeDict valueForKey:kValueAttribute] integerValue]];
        }
        
        
    } else if ([elementName isEqualToString:kWorldTag]){
        if ([self.setupDelegate respondsToSelector:@selector (setupWorldType:)]) {
            [self.setupDelegate setupWorldType:[attributeDict valueForKey:kTypeAttribute]];
        }
        
    } else if ([elementName isEqualToString:kBallTag]){
        float x = [[attributeDict valueForKey:kXAttribute] floatValue];
        float y = [[attributeDict valueForKey:kYAttribute] floatValue];
        bool isInteractable = [[attributeDict valueForKey:kInteractable] boolValue];
        
        if ([self.setupDelegate respondsToSelector:@selector (setupBallWithXPosition:yPosition:allowInteraction:)]) {
            [self.setupDelegate setupBallWithXPosition:x yPosition:y allowInteraction:isInteractable];
        }
        
    } else if ([elementName isEqualToString:kPlankTag]){
        float x = [[attributeDict valueForKey:kXAttribute] floatValue];
        float y = [[attributeDict valueForKey:kYAttribute] floatValue];
        bool isInteractable = [[attributeDict valueForKey:kInteractable] boolValue];
        float rotation = [[attributeDict valueForKey:kRotationAttribute] floatValue];
        BOOL powered = [[attributeDict valueForKey:kPoweredAttribute] boolValue];
        
        if ([self.setupDelegate respondsToSelector:@selector (setupPlankWithXPosition:yPosition:allowInteraction:rotationAngle:powered:)]) {
            [self.setupDelegate setupPlankWithXPosition:x yPosition:y allowInteraction:isInteractable rotationAngle:rotation powered:powered];
        }
        
    } else if ([elementName isEqualToString:kWallTag]){
        float x = [[attributeDict valueForKey:kXAttribute] floatValue];
        float y = [[attributeDict valueForKey:kYAttribute] floatValue];
        bool isInteractable = [[attributeDict valueForKey:kInteractable] boolValue];
        float rotation = [[attributeDict valueForKey:kRotationAttribute] floatValue];
        NSString *levelTheme = [attributeDict valueForKey:kThemeAttribute];
        NSString *type = [attributeDict valueForKey:kTypeAttribute];
        
        if ([self.setupDelegate respondsToSelector:@selector (setupWallWithPosition:yPosition:allowInteraction:rotation:theme:Type:)]) {
            [self.setupDelegate setupWallWithPosition:x yPosition:y allowInteraction:isInteractable rotation:rotation theme:levelTheme Type:type];
        }
    }



    [self.currentStringValue setString:@""];
}



-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    if ([elementName isEqualToString:kLevelTag]){
        [self.currentStringValue setString:@""];
        return;
    } else if([elementName isEqualToString:kWorldTag]) {
        //        [NSString stringWithString:self.currentStringValue];
        [self.currentStringValue setString:@""];
        return;
    }
}




- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if (!self.currentStringValue){
        self.currentStringValue = [[NSMutableString alloc] initWithCapacity:200];
    }
    [self.currentStringValue appendString:string];
}

@end
