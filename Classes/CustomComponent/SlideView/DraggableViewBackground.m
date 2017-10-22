//
//  DraggableViewBackground.m
//  RKSwipeCards
//
//  Created by Richard Kim on 8/23/14.
//  Copyright (c) 2014 Richard Kim. All rights reserved.
//

#import "DraggableViewBackground.h"
#import "UIImageView+AFNetworking.h"

@implementation DraggableViewBackground{
    NSInteger cardsLoadedIndex; //%%% the index of the card you have loaded into the loadedCards array last
    NSMutableArray *loadedCards; //%%% the array of card loaded (change max_buffer_size to increase or decrease the number of cards this holds)
    
    UIButton* checkButton;
    UIButton* xButton;
    UIButton* btnInfo;
}
//this makes it so only two cards are loaded at a time to
//avoid performance and memory costs
static const int MAX_BUFFER_SIZE = 4; //%%% max number of cards loaded at any given time, must be greater than 1
static const float CARD_HEIGHT = 380; //%%% height of the draggable card
static const float CARD_WIDTH = 290; //%%% width of the draggable card

@synthesize pets; //%%% all the labels I'm using as example data at the moment
@synthesize allCards;//%%% all the cards

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [super layoutSubviews];
        [self setupView];
    }
    return self;
}


-(void) setCard:(NSMutableArray*)arrCards {
    
    if( pets == nil )
        pets = [[NSMutableArray alloc] init];
    else
        [pets removeAllObjects];
    for( Pet* pet in arrCards ) {
        [pets addObject:pet];
    }
    loadedCards = [[NSMutableArray alloc] init];
    allCards = [[NSMutableArray alloc] init];
    cardsLoadedIndex = 0;
    [self loadCards];
}

//%%% sets up the extra buttons on the screen
-(void)setupView
{

//    self.backgroundColor = [UIColor colorWithRed:.92 green:.93 blue:.95 alpha:1]; //the gray background colors
    UIImageView* imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg.jpg"]];
    [self addSubview:imgView];
    
    CGFloat y1 = self.frame.size.height - 60;
    
    btnInfo = [[UIButton alloc] initWithFrame:CGRectMake( (self.frame.size.width-50)/2,  y1, 50, 50)];
    [btnInfo setImage:[UIImage imageNamed:@"btn_info.png"] forState:UIControlStateNormal];
    [btnInfo addTarget:self action:@selector(clickedInfo) forControlEvents:UIControlEventTouchUpInside];
    
    xButton = [[UIButton alloc]initWithFrame:CGRectMake( self.frame.size.width/2-100, y1-50, 70, 70)];
    [xButton setImage:[UIImage imageNamed:@"btn_unlike.png"] forState:UIControlStateNormal];
    [xButton addTarget:self action:@selector(swipeLeft) forControlEvents:UIControlEventTouchUpInside];
    
    checkButton = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width/2+30, y1-50, 70, 70)];
    [checkButton setImage:[UIImage imageNamed:@"btn_like.png"] forState:UIControlStateNormal];
    [checkButton addTarget:self action:@selector(swipeRight) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:xButton];
    [self addSubview:checkButton];
    [self addSubview:btnInfo];
}

-(void) clickedInfo {
    
    DraggableView* view = [loadedCards firstObject];
    [_delegate clickInfo:view.pet];
}


//%%% creates a card and returns it.  This should be customized to fit your needs.
// use "index" to indicate where the information should be pulled.  If this doesn't apply to you, feel free
// to get rid of it (eg: if you are building cards from data from the internet)
-(DraggableView *)createDraggableViewWithDataAtIndex:(NSInteger)index
{
    DraggableView *draggableView = [[DraggableView alloc]initWithFrame:CGRectMake((self.frame.size.width - CARD_WIDTH)/2, 10, CARD_WIDTH, CARD_HEIGHT)];
        
    draggableView.pet = [pets objectAtIndex:index];
    [draggableView drawPet];
    draggableView.delegate = self;
    return draggableView;
}

//%%% loads all the cards and puts the first x in the "loaded cards" array
-(void)loadCards
{
    if([pets count] > 0) {
        NSInteger numLoadedCardsCap =(([pets count] > MAX_BUFFER_SIZE)?MAX_BUFFER_SIZE:[pets count]);
        //%%% if the buffer size is greater than the data size, there will be an array error, so this makes sure that doesn't happen
        
        //%%% loops through the exampleCardsLabels array to create a card for each label.  This should be customized by removing "exampleCardLabels" with your own array of data
        for (int i = 0; i<[pets count]; i++) {
            DraggableView* newCard = [self createDraggableViewWithDataAtIndex:i];
            [allCards addObject:newCard];
            
            if (i<numLoadedCardsCap) {
                //%%% adds a small number of cards to be loaded
                [loadedCards addObject:newCard];
            }
        }
        
        //%%% displays the small number of loaded cards dictated by MAX_BUFFER_SIZE so that not all the cards
        // are showing at once and clogging a ton of data
        for (int i = 0; i<[loadedCards count]; i++) {
            if (i>0) {
                [self insertSubview:[loadedCards objectAtIndex:i] belowSubview:[loadedCards objectAtIndex:i-1]];
            } else {
                [self addSubview:[loadedCards objectAtIndex:i]];
            }
            cardsLoadedIndex++; //%%% we loaded a card into loaded cards, so we have to increment
        }
    }
}

//%%% action called when the card goes to the left.
// This should be customized with your own action
-(void)cardSwipedLeft:(UIView *)card;
{
    //do whatever you want with the card that was swiped
    DraggableView *c = (DraggableView *)card;
    Pet* pet = c.pet;
    [Service API_setFlag:pet.animal_id :0]; // like
    
    [loadedCards removeObjectAtIndex:0]; //%%% card was swiped, so it's no longer a "loaded card"
    
    if (cardsLoadedIndex < [allCards count]) { //%%% if we haven't reached the end of all cards, put another into the loaded cards
        [loadedCards addObject:[allCards objectAtIndex:cardsLoadedIndex]];
        cardsLoadedIndex++;//%%% loaded a card, so have to increment count
        [self insertSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-1)] belowSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-2)]];
    }
    
    if( loadedCards.count == 0 ) {
        [_delegate emptyList];
    }

}

//%%% action called when the card goes to the right.
// This should be customized with your own action
-(void)cardSwipedRight:(UIView *)card
{
    //do whatever you want with the card that was swiped
    DraggableView *c = (DraggableView *)card;
    Pet* pet = c.pet;
    [Service API_setFlag:pet.animal_id :1]; // like
    
    [loadedCards removeObjectAtIndex:0]; //%%% card was swiped, so it's no longer a "loaded card"
    
    if (cardsLoadedIndex < [allCards count]) { //%%% if we haven't reached the end of all cards, put another into the loaded cards
        [loadedCards addObject:[allCards objectAtIndex:cardsLoadedIndex]];
        cardsLoadedIndex++;//%%% loaded a card, so have to increment count
        [self insertSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-1)] belowSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-2)]];
    }
    
    if( loadedCards.count == 0 ) {
        [_delegate emptyList];
    }
}

//%%% when you hit the right button, this is called and substitutes the swipe
-(void)swipeRight
{
    DraggableView *dragView = [loadedCards firstObject];
    dragView.overlayView.mode = GGOverlayViewModeRight;
    [UIView animateWithDuration:0.2 animations:^{
        dragView.overlayView.alpha = 1;
    }];
    [dragView rightClickAction];
}

//%%% when you hit the left button, this is called and substitutes the swipe
-(void)swipeLeft
{
    DraggableView *dragView = [loadedCards firstObject];
    dragView.overlayView.mode = GGOverlayViewModeLeft;
    [UIView animateWithDuration:0.2 animations:^{
        dragView.overlayView.alpha = 1;
    }];
    [dragView leftClickAction];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
