//
//  JSZPatientController.m
//  MedControl
//
//  Created by Juan Antonio de los Santos Zarco on 2/3/15.
//  Copyright (c) 2015 Juan Antonio de los Santos Zarco. All rights reserved.
//

#import "JSZPatientController.h"
#import "JSZPatient.h"
#import "JSZVisitCollectionViewCell.h"
#import "JSZTableViewCellController.h"
#import "JSZProofsController.h"

@interface JSZPatientController ()

@property (weak, nonatomic) IBOutlet UIImageView *userPhoto;

@property (weak, nonatomic) IBOutlet UILabel *userName;

@property (weak, nonatomic) IBOutlet UILabel *userGender;

@property (weak, nonatomic) IBOutlet UILabel *userId;

@property (weak, nonatomic) IBOutlet UILabel *userPhone;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


@end

@implementation JSZPatientController


+(NSString *) randomCellId{
    
    return @"cellVisits";
}

#pragma mark - Initialiazer

-(id) initWithModel: (JSZPatient*)patient{
    //pilla por defecto el mismo nombre que es el que tenga la calse
    if(self = [super initWithNibName:nil
                              bundle:nil] ){
        _patient = patient;
        self.title = patient.name;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self registerRandomCell];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    /*##################################
     
     Cómo hago para decir que la tabla interna en la celda tiene su delegado y datasource??
     
     ####################################*/
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(orientationChanged:)
     name:UIDeviceOrientationDidChangeNotification
     object:[UIDevice currentDevice]];
    [self syncModel];
}

- (void) orientationChanged:(NSNotification *)note
{
    UIDevice * device = note.object;
    switch(device.orientation)
    {
        case UIDeviceOrientationPortrait:
            [self initializeCollection];
            break;
            
        case UIDeviceOrientationPortraitUpsideDown:
            [self initializeCollection];
            break;
            
        case UIDeviceOrientationLandscapeLeft:
            [self initializeCollection];
            break;
        case UIDeviceOrientationLandscapeRight:
            [self initializeCollection];
            break;
        default:break;
    };
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.5
                                                                        green:0
                                                                         blue:0.13
                                                                        alpha:1];
    [self initializeCollection];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - JSZWordsTableViewControllerDelegate
-(void)patientListController:(JSZPatientListController *)sender didClickOnPatient:(JSZPatient *)patient{
    _patient= patient;
    
    [self syncModel];
    
}

-(void)syncModel{
    [self.collectionView reloadData];
    self.title = self.patient.name;
    _userName.text = self.patient.name;
    _userGender.text = self.patient.gender;
    _userId.text = self.patient.idUser;
    _userPhone.text = [self.patient.phone description];
    
    
}

#pragma mark - UISplitViewControllerDelegate


- (void)splitViewController:(UISplitViewController *)svc
     willHideViewController:(UIViewController *)aViewController
          withBarButtonItem:(UIBarButtonItem *)barButtonItem
       forPopoverController:(UIPopoverController *)pc
{
    self.navigationItem.rightBarButtonItem = barButtonItem;
}

- (void)splitViewController:(UISplitViewController *)svc
     willShowViewController:(UIViewController *)aViewController
  invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    self.navigationItem.rightBarButtonItem = nil;
}





#pragma  mark - UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return [[self.patient extractVisitsFromJSONArray:self.patient.visits]count];
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section{
    
    return 1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    JSZVisitCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[JSZPatientController randomCellId] forIndexPath:indexPath];
    
    //configure the cell
    cell.inform.text = [[self.patient.visits objectAtIndex:indexPath.section]objectForKey:@"informe"];
    cell.diagnostic.text = [[self.patient.visits objectAtIndex:indexPath.section]objectForKey:@"diagnostico"];
    
    
    
    
    
    NSArray* pruebas = [self.patient extractProofsFromVisit:[self.patient.visits objectAtIndex:indexPath.section]];
    
    cell.tableViewCell = [[JSZTableViewCellController alloc] initWithModel:pruebas style:UITableViewStyleGrouped];
    cell.tableProofs.dataSource = cell.tableViewCell;
    cell.tableProofs.delegate = cell.tableViewCell;
    cell.tableViewCell.delegate=self;
    cell.treatment.text = [[self.patient.visits objectAtIndex:indexPath.section]objectForKey:@"tratamiento"];
    [cell.tableProofs reloadData];
    
    return cell;
    
    
}



-(void)registerRandomCell{
    
    UINib *nib = [UINib nibWithNibName:@"JSZVisitCollectionViewCell"
                                bundle:nil];
    [self.collectionView registerNib:nib
          forCellWithReuseIdentifier:[JSZPatientController randomCellId]];
    
}


-(void) initializeCollection{
    // Layout
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.itemSize = CGSizeMake(self.view.frame.size.width-40,220);
    layout.sectionInset = UIEdgeInsetsMake(5, 0, 5, 0);
    layout.headerReferenceSize = CGSizeMake(200, 0);
    
    self.collectionView.collectionViewLayout= layout;
    
}


#pragma mark -  UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.patient extractProofsFromVisit:[self.patient.visits objectAtIndex:section]]count];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellId = @"cellIdTabla";
    
    NSArray* proof = [self.patient extractProofsFromVisit:[self.patient.visits objectAtIndex:indexPath.section]];
    NSString *text = [proof objectAtIndex:0];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellId];
    }
    
    // Configure the cell...
    
    cell.textLabel.text = text;
    
    return cell;
}


#pragma mark - JSZPatientListTableViewControllerDelegate

-(void) proobCellController:(JSZTableViewCellController*) sender
            didClickOnProof:(NSString*)proof{
    
    JSZProofsController *prooftVC = [[JSZProofsController alloc]initWithProof:proof];
    
    [self.navigationController pushViewController:prooftVC animated:YES];
    
    
}

@end
