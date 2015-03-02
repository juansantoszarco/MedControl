//
//  JSZProofsController.h
//  MedControl
//
//  Created by Juan Antonio de los Santos Zarco on 2/3/15.
//  Copyright (c) 2015 Juan Antonio de los Santos Zarco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSZProofsController : UIViewController

@property (weak,nonatomic) NSString *proofPDF;

@property (weak, nonatomic) IBOutlet UIWebView *webViewProof;

-(id)initWithProof:(NSString*)proof;

@end
