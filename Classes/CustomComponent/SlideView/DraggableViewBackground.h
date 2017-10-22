

#import <UIKit/UIKit.h>
#import "DraggableView.h"
#import "Pet.h"

@protocol DraggableViewBackgroundDelegate <NSObject>

-(void) clickInfo:(Pet *)pet;
-(void) emptyList;

@end

@interface DraggableViewBackground : UIView <DraggableViewDelegate>

//methods called in DraggableView
-(void)cardSwipedLeft:(UIView *)card;
-(void)cardSwipedRight:(UIView *)card;

@property (weak) id <DraggableViewBackgroundDelegate> delegate;

@property (retain,nonatomic)NSMutableArray* pets; //%%% the labels the cards
@property (retain,nonatomic)NSMutableArray* allCards; //%%% the labels the cards

-(void) setCard:(NSMutableArray*)arrCards;

@end
