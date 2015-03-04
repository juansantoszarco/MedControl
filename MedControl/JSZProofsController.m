//
//  JSZProofsController.m
//  MedControl
//
//  Created by Juan Antonio de los Santos Zarco on 2/3/15.
//  Copyright (c) 2015 Juan Antonio de los Santos Zarco. All rights reserved.
//

#import "JSZProofsController.h"

#define Rgb2UIColor(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:0.95]


@interface JSZProofsController ()

@end

@implementation JSZProofsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self loadPDF];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(id)initWithProof:(NSString*)proof{
    if(self=[super init]){
        _proofPDF = proof;
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
        label.font = [UIFont fontWithName:@"Avenir" size:16.0f];
        label.textColor = Rgb2UIColor(95, 22, 28);
        self.navigationItem.titleView = label;
        label.text = proof;
        [label sizeToFit];
        
    }
    
    return self;
    
}


#pragma mark - Utils

-(void)loadPDF{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:self.proofPDF ofType:@"pdf"];
    NSURL *targetURL = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    [self.webViewProof loadRequest:request];
       
}



@end

