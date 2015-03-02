//
//  JSZTableViewCellController.h
//  MedControl
//
//  Created by Juan Antonio de los Santos Zarco on 2/3/15.
//  Copyright (c) 2015 Juan Antonio de los Santos Zarco. All rights reserved.
//

@import UIKit;
@import Foundation;
#import "JSZTableViewCellController.h"

@class JSZTableViewCellController;

@protocol JSZTableViewCellControllerDelegate <NSObject>

-(void) proobCellController:(JSZTableViewCellController*) sender
            didClickOnProof:(NSString*)proof;

@end


@interface JSZTableViewCellController : UITableViewController

@property NSArray *model;


@property (weak,nonatomic) id<JSZTableViewCellControllerDelegate> delegate;

-(id) initWithModel : (NSArray *) aModel
               style: (UITableViewStyle) aStyle;


@end