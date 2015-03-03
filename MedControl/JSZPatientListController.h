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

-(void) patientListController:(JSZPatientListController*)sender
                     didClickOnPatient:(JSZPatient*)patient;

@end

@interface JSZPatientListController : UITableViewController <UISearchBarDelegate,JSZPatientListControllerDelegate>

@property (strong, nonatomic) JSZPatientListModel *model;

@property (weak,nonatomic) id<JSZPatientListControllerDelegate> delegate;

#pragma mark - Search Bar properties
@property (strong, nonatomic) NSMutableArray *dataSource1; 
@property (strong, nonatomic) NSMutableArray *tableData;
@property (strong, nonatomic) NSMutableArray *searchedData;
@property (strong, nonatomic) UISearchBar *sBar;


#pragma mark - Designed Initializers

-(id) initWithModel : (JSZPatientListModel *) aModel
               style: (UITableViewStyle) aStyle;


@end
