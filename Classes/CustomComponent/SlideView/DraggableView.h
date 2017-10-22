

#import <UIKit/UIKit.h>
#import "OverlayView.h"
#import "Pet.h"

@protocol DraggableViewDelegate <NSObject>

-(void)cardSwipedLeft:(UIView *)card;
-(void)cardSwipedRight:(UIView *)card;

@end

@interface DraggableView : UIView

@property (weak) id <DraggableViewDelegate> delegate;

@property (nonatomic, strong)UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic)CGPoint originalPoint;
@property (nonatomic,strong)OverlayView* overlayView;

@property (nonatomic,strong) UIImageView* imgAvatar;

@property (nonatomic,strong) UILabel* lblName;
@property (nonatomic,strong) UILabel* lblGender;
@property (nonatomic,strong) UILabel* lblAge;

@property (nonatomic, retain) Pet* pet;

-(void)leftClickAction;
-(void)rightClickAction;

-(void) drawPet;

@end
