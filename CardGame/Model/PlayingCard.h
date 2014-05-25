//
//  PlayingCard.h
//  CardGame
//
//  Created by Jonathan Wong on 3/30/14.
//  Copyright (c) 2014 Jonathan Wong. All rights reserved.
//  This is jacky testing changes
//

#import "Card.h"

@interface PlayingCard : Card

@property(strong,  nonatomic) NSString *suit;
@property(nonatomic) NSUInteger rank;

+(NSArray *) validSuits;
+(NSUInteger) maxRank;

@end
