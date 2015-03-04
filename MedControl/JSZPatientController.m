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

#define Rgb2UIColor(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:0.95]

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
    if(self = [super initWithNibName:nil
                              bundle:nil] ){
        _patient = patient;
        
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self registerRandomCell];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
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
}




#pragma mark - JSZWordsTableViewControllerDelegate
-(void)patientListController:(JSZPatientListController *)sender didClickOnPatient:(JSZPatient *)patient{
    _patient= patient;
    [self syncModel];
   
}




- (void)hideMasterView
{
   
        NSArray *controllers = self.splitViewController.viewControllers;
        UIViewController *rootViewController = [controllers objectAtIndex:0];
        
        UIView *rootView = rootViewController.view;
        CGRect rootFrame = rootView.frame;
        rootFrame.origin.x -= rootFrame.size.width;
        
        [UIView beginAnimations:@"hideView" context:NULL];
        rootView.frame = rootFrame;
        [UIView commitAnimations];
    
}

-(void)syncModel{
    [self.collectionView reloadData];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.font = [UIFont fontWithName:@"Avenir" size:16.0f];
    label.textColor = Rgb2UIColor(95, 22, 28);
    self.navigationItem.titleView = label;
    label.text = self.patient.name;
    [label sizeToFit];
    _userName.text = self.patient.name;
    _userGender.text = self.patient.gender;
    _userId.text = self.patient.idUser;
    _userPhone.text = [self.patient.phone description];
    _userPhoto.image = self.patient.photo;
    if(_userPhoto.image == nil){
        _userPhoto.image = [UIImage imageNamed:@"sinfoto.jpg"];
    }
}

#pragma mark - UISplitViewControllerDelegate


- (void)splitViewController:(UISplitViewController *)svc
     willHideViewController:(UIViewController *)aViewController
          withBarButtonItem:(UIBarButtonItem *)barButtonItem
       forPopoverController:(UIPopoverController *)pc
{
    self.navigationItem.rightBarButtonItem = barButtonItem;
    self.navigationItem.rightBarButtonItem.title = @"Patient List";
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
    
    cell.inform.text = [[self.patient.visits objectAtIndex:indexPath.section]objectForKey:@"informe"];
    cell.diagnostic.text = [[self.patient.visits objectAtIndex:indexPath.section]objectForKey:@"diagnostico"];
    
    NSArray* pruebas = [self.patient extractProofsFromVisit:[self.patient.visits objectAtIndex:indexPath.section]];
    
    cell.tableViewCell = [[JSZTableViewCellController alloc] initWithModel:pruebas style:UITableViewStyleGrouped];
    cell.tableProofs.dataSource = cell.tableViewCell;
    cell.tableProofs.delegate = cell.tableViewCell;
    cell.tableViewCell.delegate=self;
    cell.treatment.text = [[self.patient.visits objectAtIndex:indexPath.section]objectForKey:@"tratamiento"];
    cell.treatment.textColor = Rgb2UIColor(95, 22, 28);
    cell.treatment.font = [UIFont fontWithName:@"Avenir" size:14.0f];
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
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.itemSize = CGSizeMake(self.view.frame.size.width-40,215);
    layout.sectionInset = UIEdgeInsetsMake(5, 0, 5, 0);
    layout.headerReferenceSize = CGSizeMake(200, 0);
    self.collectionView.collectionViewLayout = layout;
    
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
