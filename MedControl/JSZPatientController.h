//
//  JSZPatientController.h
//  MedControl
//
//  Created by Juan Antonio de los Santos Zarco on 2/3/15.
//  Copyright (c) 2015 Juan Antonio de los Santos Zarco. All rights reserved.
//

@import UIKit;
#import "JSZPatient.h"
#import "JSZTableViewCellController.h"
#import "JSZPatientListController.h"

@interface JSZPatientController : UIViewController <JSZPatientListControllerDelegate,UISplitViewControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate, UITableViewDataSource,JSZTableViewCellControllerDelegate>

@property (strong,nonatomic) JSZPatient *patient;

#pragma mark - Initialiazer

-(id) initWithModel: (JSZPatient*)patient;

@end
