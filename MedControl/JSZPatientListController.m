//
//  JSZPatientListController.m
//  MedControl
//
//  Created by Juan Antonio de los Santos Zarco on 2/3/15.
//  Copyright (c) 2015 Juan Antonio de los Santos Zarco. All rights reserved.
//

#import "JSZPatientListController.h"


@interface JSZPatientListController ()

@property (strong, nonatomic) NSArray* keys;

@property (nonatomic) NSUInteger contador;

@end

@implementation JSZPatientListController


#pragma mark - Designed Initializers

-(id) initWithModel : (JSZPatientListModel *) aModel
               style: (UITableViewStyle) aStyle{
    
    if(self=[super initWithStyle:UITableViewStylePlain]){
        //_wordsModel = aModel;
        _model = aModel;
        self.title = @"Patient List";
        
    }
    
    return self;
    
    
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    NSInteger sections = [self.model totalSectionsInModel];
    self.keys = [[self.model.fillLetters allKeys]sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    // NSLog(@"Did load keys: %@",self.keys);
    return  sections;
    
}

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName = nil;
    
    sectionName = [self.keys objectAtIndex:section];
    
    return sectionName;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[self.model.fillLetters objectForKey:[self.keys objectAtIndex:section]]integerValue];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* cellId = @"cellId";
    
    JSZPatient* patient = [self patientForIndexPath:indexPath];
  
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell == nil){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:@"cellId"];
    }
    
    cell.textLabel.text = patient.name;
    cell.detailTextLabel.text = patient.idUser;
    
    self.contador++;
    
    return cell;
}


#pragma mark - JSZPatientListController

-(void)patientListTableViewController:(JSZPatientListController *)sender didClickOnPatient:(JSZPatient *)patient{
    
    
}


#pragma mark - Utils

-(JSZPatient*) patientForIndexPath:(NSIndexPath*) indexPath{
    
    int contador = 0;
    
    for (int i=0;i< [self.keys count]; i++){
        if([[self.keys objectAtIndex:i] isEqualToString:[self.keys objectAtIndex:indexPath.section]]){
            break;
            
        }else{
            contador= contador + (int)[[self.model.fillLetters objectForKey:[self.keys objectAtIndex:i]]integerValue];
        }
    }
    
    contador = contador + (int)indexPath.row;
    // NSLog(@"Contador: %d Patient selected: %@",contador, [self.model patientAtIndex:contador]);
    return [self.model patientAtIndex:contador];
    
}


@end
