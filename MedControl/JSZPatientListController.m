//
//  JSZPatientListController.m
//  MedControl
//
//  Created by Juan Antonio de los Santos Zarco on 2/3/15.
//  Copyright (c) 2015 Juan Antonio de los Santos Zarco. All rights reserved.
//

#import "JSZPatientListController.h"
#import "JSZPatient.h"


@interface JSZPatientListController ()

@property (strong, nonatomic) NSArray* keys;

@property (nonatomic) NSUInteger contador;

@property (nonatomic) NSUInteger flagSearchStatus;

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
    self.searchedData = [[NSMutableArray alloc]init];
    self.tableData = [[NSMutableArray alloc]init];
    self.sBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0,0,320,40)];
    self.sBar.delegate = self;
    self.tableView.tableHeaderView = self.sBar;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self fillPatientsDataSearch:self.model.patients];
    [self.tableData addObjectsFromArray:self.dataSource1];
   // NSLog(@"%@",self.dataSource1);
    self.flagSearchStatus = 0;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

#pragma mark UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    // only show the status bar's cancel button while in edit mode
    self.sBar.showsCancelButton = YES;
    self.sBar.autocorrectionType = UITextAutocorrectionTypeNo;
    // flush the previous search content
    [self.tableData removeAllObjects];
    self.flagSearchStatus = 1;
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    self.flagSearchStatus = 0;
    self.sBar.showsCancelButton = NO;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self.tableData removeAllObjects];// remove all data that belongs to previous search
    if([searchText isEqualToString:@""]||searchText==nil){
        [self.tableView reloadData];
        return;
    }
    NSInteger counter = 0;
    for(NSString *name in self.dataSource1)
    {
        NSRange r = [name rangeOfString:searchText options:NSCaseInsensitiveSearch];
        if(r.location != NSNotFound)
            [self.tableData addObject:name];
        counter++;
    }
    self.flagSearchStatus = 1;
    [self.tableView reloadData];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    // if a valid search was entered but the user wanted to cancel, bring back the main list content
    self.flagSearchStatus = 0;
    [self.tableData removeAllObjects];
    [self.tableData addObjectsFromArray:self.dataSource1];
    @try{
        [self.tableView reloadData];
    }
    @catch(NSException *e){
    }
    [self.sBar resignFirstResponder];
    self.sBar.text = @"";
}
// called when Search (in our case "Done") button pressed
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if(self.flagSearchStatus == 0){
        NSInteger sections = [self.model totalSectionsInModel:self.tableData];
        self.keys = [[self.model.fillLetters allKeys]sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        // NSLog(@"Did load keys: %@",self.keys);
        
        return  sections;
    }else{
        return 1;
    }
}

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section
{
    if(self.flagSearchStatus == 0){
        NSString *sectionName = nil;
        
        sectionName = [self.keys objectAtIndex:section];
        
        return sectionName;
    }else{
        return nil;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(self.flagSearchStatus == 0){
        
        return [[self.model.fillLetters objectForKey:[self.keys objectAtIndex:section]]integerValue];
    }else{
        return [self.tableData count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* cellId = @"cellId";
    //NSLog(@"contenido tableData Index: %@",[self.tableData objectAtIndex:indexPath.row]);
    //NSLog(@"Section: %d",indexPath.section);
    JSZPatient* patient;
    
    if(self.flagSearchStatus == 1){
        patient = [self patientForName:[self.tableData objectAtIndex:indexPath.row ]];
    }else{
        
        patient = [self patientForIndexPath:indexPath];
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell == nil){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:@"cellId"];
    }
    
    cell.textLabel.text = patient.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Id number: %@",patient.idUser];
    //cell.textLabel.text = [self.tableData objectAtIndex:indexPath.row];
    self.contador++;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JSZPatient *patient;
    if(self.flagSearchStatus == 0){
        //este el normal
        patient = [self patientForIndexPath:indexPath];
    }else{
        
        patient = [self patientForName:[self.tableData objectAtIndex:indexPath.row ]];
    }
    //NSLog(@"Pulsado el paciente: %@",patient.name);
    
    //Notificar al delegado
    //Comprobar si entiende el mensaje
    if ([self.delegate respondsToSelector:@selector(patientListController:didClickOnPatient:)]) {
        //entiende el mensaje y se lo mando
        NSLog(@"Mando el mensaje");
        [self.delegate patientListController:self didClickOnPatient:patient];
    }else{
        NSLog(@"No entiende el mensaje que me quieres mandar");
    }
}

#pragma mark - JSZPatientListControllerDelegate

-(void)patientListController:(JSZPatientListController *)sender didClickOnPatient:(JSZPatient *)patient{
    NSLog(@"Pulsado paciente: %@",patient.name);
    
}

#pragma mark - Utils

-(JSZPatient*) patientForName:(NSString*) aName{
    int contador = 0;
    JSZPatient *patient;
    for(int i= 0; i <[self.model.patients count];i++ ){
        patient = [self.model.patients objectAtIndex:i];
        if( [aName isEqualToString:patient.name]){
            return [self.model.patients objectAtIndex:contador];
        }else{
            contador++;
        }
    }
    return nil;
}


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


-(void) fillPatientsDataSearch:(NSArray*) patientsList{
    self.dataSource1 = [[NSMutableArray alloc]init];
    for (JSZPatient *patient in patientsList){
        //NSLog(@"Nombre:: %@",patient.name);
        [self.dataSource1 addObject:patient.name];
        
    }
}

@end
