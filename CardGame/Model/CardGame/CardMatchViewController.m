//
//  CardMatchViewController.m
//  CardGame
//
//  Created by Jonathan Wong on 3/30/14.
//  Copyright (c) 2014 Jonathan Wong. All rights reserved.
//

#import "CardMatchViewController.h"
#import "Deck.h"
#import "PlayingCard.h"
#import "PlayingCardDeck.h"
#import "card.h"
#import "CardMatchingGame.h"

@interface CardMatchViewController ()
//Assignment 1
//@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
//@property (nonatomic) int flipCount;
//@property (strong, nonatomic) Deck *cardDeck;
@property (nonatomic, strong) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutlet UIButton *nextGame;

@end

@implementation CardMatchViewController

-(CardMatchingGame *)game {
    if (!_game)
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    return _game;
}
- (Deck *) createDeck{
    return [[PlayingCardDeck alloc]init];
}
//Assignment 1
//-(void) setFlipCount:(int)flipCount{
//    _flipCount = flipCount;
//    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
//    NSLog(@"Flips:, %d", self.flipCount);
//}
//-(Deck *)cardDeck
//{
//    if (!_cardDeck)
//    {
//        _cardDeck=[self createDeck];
//    }
//    NSLog(@"PlayingCardDeck Created");
//    return _cardDeck;
//}
- (IBAction)touchCardButton:(UIButton *)sender
{
//    Assignment 1
//    NSLog(@"Got in Touch Card Button");
//    if ([sender.currentTitle length]){
//        [sender setBackgroundImage:[UIImage imageNamed:@"cardBack"]
//                          forState:UIControlStateNormal];
//        [sender setTitle:@"" forState:UIControlStateNormal];
//        self.flipCount++;
//    }
//    else{
//        Card *card= [self.cardDeck drawRandomCard];
//        if (card){
//        [sender setBackgroundImage:[UIImage imageNamed:@"cardFront"]
//                          forState:UIControlStateNormal];
//        [sender setTitle:card.contents forState:UIControlStateNormal];
//        self.flipCount++;
//        }
//    }
//    Assignment 2
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}
- (IBAction)segmentSwitch:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    
    if (selectedSegment == 0) {
        //toggle the correct view to be visible
        self.game.mode=YES;
    }
    else{
        //toggle the correct view to be visible
        self.game.mode=NO;
        
    }
//    NSLog(@"Selected Segment is %d",selectedSegment);
//    NSLog(@"Game Mode = %d", self.game.mode);
}
- (void) updateUI{
    for (UIButton *cardButton in self.cardButtons){
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForString:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self bgImgForCard:card ] forState:UIControlStateNormal];
        cardButton.enabled=!card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    }
}

-(IBAction)touchNextGame:(UIButton *)sender
{
    self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: 0"];
    [self updateUI];
    
}
-(NSString *) titleForString: (Card*) card{
    return card.isChosen ? card.contents : @"";
}
-(UIImage *) bgImgForCard: (Card*) card{
    return card.isChosen ? [UIImage imageNamed:@"cardFront"] : [UIImage imageNamed:@"cardBack"];
}
@end
