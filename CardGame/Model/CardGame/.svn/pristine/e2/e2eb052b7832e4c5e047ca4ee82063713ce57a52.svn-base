//
//  CardMatchingGame.h
//  CardGame
//
//  Created by Jonathan Wong on 3/30/14.
//  Copyright (c) 2014 Jonathan Wong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

-(instancetype)initWithCardCount:(NSUInteger)count
                       usingDeck: (Deck *)deck;

- (void) chooseCardAtIndex: (NSUInteger) index;

- (Card *) cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic) BOOL mode;
@end
