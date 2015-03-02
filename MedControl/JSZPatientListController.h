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
//@property (strong, nonatomic) UITableView *myTableView;
@property (strong, nonatomic) NSMutableArray *dataSource1; //will be storing all the data
@property (strong, nonatomic) NSMutableArray *tableData;//will be storing data that will be displayed in table
@property (strong, nonatomic) NSMutableArray *searchedData;//will be storing data matching with the search string
@property (strong, nonatomic) UISearchBar *sBar;//search bar


#pragma mark - Designed Initializers

-(id) initWithModel : (JSZPatientListModel *) aModel
               style: (UITableViewStyle) aStyle;


@end
