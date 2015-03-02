//
//  JSZPatientListController.h
//  MedControl
//
//  Created by Juan Antonio de los Santos Zarco on 2/3/15.
//  Copyright (c) 2015 Juan Antonio de los Santos Zarco. All rights reserved.
//

@import UIKit;
#import "JSZPatientListModel.h"

@class JSZPatientListController;

@protocol JSZPatientListControllerDelegate <NSObject>

-(void) patientListTableViewController:(JSZPatientListController*)sender
                     didClickOnPatient:(JSZPatient*)patient;

@end

@interface JSZPatientListController : UITableViewController <JSZPatientListControllerDelegate>

@property (strong, nonatomic) JSZPatientListModel *model;

@property (weak,nonatomic) id<JSZPatientListControllerDelegate> delegate;


#pragma mark - Designed Initializers

-(id) initWithModel : (JSZPatientListModel *) aModel
               style: (UITableViewStyle) aStyle;


@end
