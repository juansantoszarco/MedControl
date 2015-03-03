//
//  JSZProofsController.m
//  MedControl
//
//  Created by Juan Antonio de los Santos Zarco on 2/3/15.
//  Copyright (c) 2015 Juan Antonio de los Santos Zarco. All rights reserved.
//

#import "JSZProofsController.h"

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
        self.title = proof;
        
    }
    
    return self;
    
    
}


#pragma mark - Utils

-(void)loadPrueba{
    
}

-(void)loadPDF{
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:self.proofPDF ofType:@"pdf"];
    NSURL *targetURL = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    [self.webViewProof loadRequest:request];
    
   
}



@end

