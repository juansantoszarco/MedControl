//
//  JSZVisitCollectionViewCell.h
//  MedControl
//
//  Created by Juan Antonio de los Santos Zarco on 2/3/15.
//  Copyright (c) 2015 Juan Antonio de los Santos Zarco. All rights reserved.
//

@import UIKit;

#import "JSZTableViewCellController.h"

@interface JSZVisitCollectionViewCell : UICollectionViewCell

@property JSZTableViewCellController * tableViewCell;

@property (weak, nonatomic) IBOutlet UILabel *inform;

@property (weak, nonatomic) IBOutlet UILabel *diagnostic;

@property (weak, nonatomic) IBOutlet UITableView *tableProofs;

@property (weak, nonatomic) IBOutlet UITextView *treatment;

#pragma mark - Utils

-(void) change:(NSString*)text;

@end
