//
//  CardMatchingGame.m
//  CardGame
//
//  Created by Jonathan Wong on 3/30/14.
//  Copyright (c) 2014 Jonathan Wong. All rights reserved.
//

#import "CardMatchingGame.h"
static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOSE = 1;

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;//ofCards
@property (nonatomic, strong) NSMutableArray *compareCards;


@end

@implementation CardMatchingGame

- (NSMutableArray *) cards{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}
- (NSMutableArray *) compareCards{
    if (!_compareCards) _compareCards = [[NSMutableArray alloc] init];
    return _compareCards;
}
-(instancetype) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck{
    self.mode=YES;
    self= [super init];
    if (self){
        for (int i = 0; i<count; i++){
            Card *card = [deck drawRandomCard];
            if (card){
                [self.cards addObject:card];
            }
            else{
                self=nil;
                break;
            }
        }
    }
    return self;
}
-(Card *) cardAtIndex:(NSUInteger)index{
    return (index<[self.cards count]) ? self.cards[index] : nil;
}
- (void) chooseCardAtIndex: (NSUInteger) index{
    
    NSLog(@"%d", self.mode);
    Card *card = [self cardAtIndex: index];
    [self.compareCards addObject:card];
    
    if (!card.isMatched){
        if(card.isChosen){
            card.chosen=NO;
            [self.compareCards removeObject:(Card *)card];
        }
        else{
            if(self.mode){ //match against another card
                
                card.chosen=YES;
                if ([self.compareCards count]==2){
                    [self matchScore];
                }
            }
            else{
                //3 card mode
                card.chosen=YES;

                if ([self.compareCards count]==3){
                    [self matchScore3];
                }
            }
        }
    }

}
-(void) matchScore3{
    int matchScore1=[[self.compareCards objectAtIndex:0] match:@[[self.compareCards objectAtIndex:1]]];
    int matchScore2=[[self.compareCards objectAtIndex:0] match:@[[self.compareCards objectAtIndex:2]]];
    int matchScore3=[[self.compareCards objectAtIndex:2] match:@[[self.compareCards objectAtIndex:1]]];
    NSLog(@"Matchscore 1, %d, /nMatchScore2: %d/nMatchScore3: %d", matchScore1, matchScore2, matchScore3);
    int matchCount=0;
    if (matchScore1) matchCount++;
    if (matchScore2) matchCount++;
    if (matchScore3) matchCount++;
    
    if (matchCount>1){
        self.score += (matchScore1+matchScore2+matchScore3) * MATCH_BONUS;
        for (Card *card in self.compareCards){
            card.matched=YES;
        }
        [self.compareCards removeAllObjects];
    }
    else{
        int count = 0;
        while (count<2)
        {
            Card *card=(Card *)self.compareCards.firstObject;
            card.chosen=NO;
            [self.compareCards removeObjectAtIndex:0];
            count++;
        }
//        for (int i=0;i<[self.compareCards count];i++){
//            
//            Card *card=(Card *)[self.compareCards objectAtIndex:i];
//            card.chosen=NO;
//            [self.compareCards removeObjectAtIndex:i];
//        }
        self.score -=MISMATCH_PENALTY;
        //firstcard.chosen=NO;
    }

    
    
}
-(void) matchScore{
        int matchScore= [self.compareCards.firstObject match:@[self.compareCards.lastObject]];
        Card *firstcard=(Card *)self.compareCards.firstObject;
        Card *secondcard=(Card *)self.compareCards.lastObject;
    
    
        if (matchScore){
            self.score += matchScore * MATCH_BONUS;
            for (Card *card in self.compareCards){
                card.matched=YES;
            }
            [self.compareCards removeAllObjects];
        }
        else{
            for (int i=0;i<[self.compareCards count];i++){
                
                Card *card=(Card *)[self.compareCards objectAtIndex:i];
                card.chosen=NO;
                [self.compareCards removeObjectAtIndex:i];
            }
            self.score -=MISMATCH_PENALTY;
            //firstcard.chosen=NO;
        }
    NSLog(@" First Card %@", firstcard.contents);
    NSLog(@" Second Card %@", secondcard.contents);
        self.score -=COST_TO_CHOSE;


}
-(instancetype) init{
    return nil;
}

@end