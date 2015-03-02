//
//  JSZVisitCollectionViewCell.m
//  MedControl
//
//  Created by Juan Antonio de los Santos Zarco on 2/3/15.
//  Copyright (c) 2015 Juan Antonio de los Santos Zarco. All rights reserved.
//

#import "JSZVisitCollectionViewCell.h"

@implementation JSZVisitCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void) change:(NSString*)text{
    self.inform.text = text;
    
}


#pragma mark - View Lifecycle
-(void) prepareForReuse{
    [super prepareForReuse];
    
    
}
@end
