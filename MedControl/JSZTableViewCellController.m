//
//  JSZTableViewCellController.m
//  MedControl
//
//  Created by Juan Antonio de los Santos Zarco on 2/3/15.
//  Copyright (c) 2015 Juan Antonio de los Santos Zarco. All rights reserved.
//

#import "JSZTableViewCellController.h"
#import "JSZProofsController.h"

@interface JSZTableViewCellController ()

@end

@implementation JSZTableViewCellController


-(id) initWithModel : (NSArray *) aModel
               style: (UITableViewStyle) aStyle{
    if (self = [super initWithStyle:aStyle]){
        
        _model = aModel;
        self.tableView.delegate = self;
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    // self.tableView.delegate = self;
    // Registramos el nib de la celda
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.model count];;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    static NSString * cellTableViewCell = @"CellTableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellTableViewCell];
    if (cell == nil){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellTableViewCell];
    }
    // Configure the cell...
    NSString *dato = [self.model objectAtIndex:indexPath.row];
    
    
    cell.textLabel.text = dato;
    
    //cell.backgroundColor = [UIColor redColor];
    
    return cell;
}




- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* archivo = [self.model objectAtIndex:indexPath.row];
    
    if ([self.delegate respondsToSelector:@selector(proobCellController:didClickOnProof:)]) {
        [self.delegate proobCellController:self didClickOnProof:archivo];
    }else{
        NSLog(@"Error didSelect row");
    }
    
}






@end
