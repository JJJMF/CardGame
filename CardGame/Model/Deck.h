//
//  Deck.h
//  CardGame
//
//  Created by Jonathan Wong on 3/30/14.
//  Copyright (c) 2014 Jonathan Wong. All rights reserved.
//
//this is a test commit

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject
-(void)addCard:(Card *)card atTop:(BOOL)atTop;
-(void)addCard:(Card *)card;

-(Card *)drawRandomCard;

@end
