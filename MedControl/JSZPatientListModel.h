//
//  JSZPatientListModel.h
//  MedControl
//
//  Created by Juan Antonio de los Santos Zarco on 2/3/15.
//  Copyright (c) 2015 Juan Antonio de los Santos Zarco. All rights reserved.
//

@import Foundation;

#import "JSZPatient.h"


@interface JSZPatientListModel : NSObject

#pragma mark - Properties

@property (strong, nonatomic) NSMutableArray *patients;

@property (nonatomic, readonly) NSInteger sectionsCount;


@property (strong, nonatomic) NSMutableDictionary *fillLetters;


#pragma mark - Utils

- (JSZPatient *)patientAtIndex:(NSUInteger)index;

-(NSUInteger) totalSectionsInModel:(NSArray*)patients;

@end
