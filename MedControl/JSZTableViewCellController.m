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
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.model count];;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    static NSString * cellTableViewCell = @"CellTableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellTableViewCell];
    if (cell == nil){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellTableViewCell];
    }

    NSString *dato = [self.model objectAtIndex:indexPath.row];
    
    cell.textLabel.text = dato;
    
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
