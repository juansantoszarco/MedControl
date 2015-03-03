//
//  JSZPatientListModel.m
//  MedControl
//
//  Created by Juan Antonio de los Santos Zarco on 2/3/15.
//  Copyright (c) 2015 Juan Antonio de los Santos Zarco. All rights reserved.
//

#import "JSZPatientListModel.h"

@implementation JSZPatientListModel

#pragma mark - Init

-(id) init{
    
    if (self = [super init]) {
        
        NSURL *urlToFile = [[NSBundle mainBundle] URLForResource:@"Patients"
                                                   withExtension:@"txt"];
        
        NSData *data = [NSData dataWithContentsOfURL:urlToFile];
        
        NSError *error;
        
        NSArray *JSONObjects = [NSJSONSerialization JSONObjectWithData:data
                                                               options:kNilOptions
                                                                 error:&error];
        
        for (NSDictionary* dict in JSONObjects){
            JSZPatient *patient = [[JSZPatient alloc]initWithDictionary:dict];
            
            if (!self.patients) {
                self.patients = [NSMutableArray arrayWithObject:patient];
            }else{
                [self.patients addObject:patient];
            }
        }
        
    }
    
    return self;
}


#pragma mark - Utils

- (JSZPatient *)patientAtIndex:(NSUInteger)index{
    
    return [self.patients objectAtIndex:index];
}



-(NSUInteger )totalSectionsInModel:(NSArray*)patients{
    
    NSUInteger countSections = 0;
    
    NSDictionary *letters = @{@"A":@0,@"B":@0,@"C":@0,@"D":@0,@"E":@0,@"F":@0,@"G":@0,@"H":@0,@"I":@0,@"J":@0,@"K":@0,@"L":@0,@"M":@0,@"N":@0,@"O":@0,@"P":@0,@"Q":@0,@"R":@0,@"S":@0,@"T":@0,@"U":@0,@"V":@0,@"W":@0,@"X":@0,@"Y":@0,@"Z":@0};
    
    NSMutableDictionary *mutLetters = [letters mutableCopy];
    
    for (NSString* patient in patients) {
        switch ([patient characterAtIndex:0]) {
            case 'a':
            case 'A':{
                NSInteger inte = [[mutLetters objectForKey:@"A"]integerValue];
                inte++;
                [mutLetters setValue:[NSNumber numberWithInteger:inte ] forKey:@"A"];
                break;
            }
            case 'b':
            case 'B':{
                NSInteger inte = [[mutLetters objectForKey:@"B"]integerValue];
                inte++;
                [mutLetters setValue:[NSNumber numberWithInteger:inte ] forKey:@"B"];
                break;
            }
            case 'c':
            case 'C':{
                NSInteger inte = [[mutLetters objectForKey:@"C"]integerValue];
                inte++;
                [mutLetters setValue:[NSNumber numberWithInteger:inte ] forKey:@"C"];
                break;
            }
            case 'd':
            case 'D':{
                NSInteger inte = [[mutLetters objectForKey:@"D"]integerValue];
                inte++;
                [mutLetters setValue:[NSNumber numberWithInteger:inte ] forKey:@"D"];
                break;
            }
            case 'e':
            case 'E':{
                NSInteger inte = [[mutLetters objectForKey:@"E"]integerValue];
                inte++;
                [mutLetters setValue:[NSNumber numberWithInteger:inte ] forKey:@"E"];
                break;
            }
            case 'f':
            case 'F':{
                NSInteger inte = [[mutLetters objectForKey:@"F"]integerValue];
                inte++;
                [mutLetters setValue:[NSNumber numberWithInteger:inte ] forKey:@"F"];
                break;
            }
            case 'g':
            case 'G':{
                NSInteger inte = [[mutLetters objectForKey:@"G"]integerValue];
                inte++;
                [mutLetters setValue:[NSNumber numberWithInteger:inte ] forKey:@"G"];
                break;
            }
            case 'h':
            case 'H':{
                NSInteger inte = [[mutLetters objectForKey:@"H"]integerValue];
                inte++;
                [mutLetters setValue:[NSNumber numberWithInteger:inte ] forKey:@"H"];
                break;
            }
            case 'i':
            case 'I':{
                NSInteger inte = [[mutLetters objectForKey:@"I"]integerValue];
                inte++;
                [mutLetters setValue:[NSNumber numberWithInteger:inte ] forKey:@"I"];
                break;
            }
            case 'j':
            case 'J':{
                NSInteger inte = [[mutLetters objectForKey:@"J"]integerValue];
                inte++;
                [mutLetters setValue:[NSNumber numberWithInteger:inte ] forKey:@"J"];
                break;
            }
            case 'k':
            case 'K':{
                NSInteger inte = [[mutLetters objectForKey:@"K"]integerValue];
                inte++;
                [mutLetters setValue:[NSNumber numberWithInteger:inte ] forKey:@"K"];
                break;
            }
            case 'l':
            case 'L':{
                NSInteger inte = [[mutLetters objectForKey:@"L"]integerValue];
                inte++;
                [mutLetters setValue:[NSNumber numberWithInteger:inte ] forKey:@"L"];
                break;
            }
            case 'm':
            case 'M':{
                NSInteger inte = [[mutLetters objectForKey:@"M"]integerValue];
                inte++;
                [mutLetters setValue:[NSNumber numberWithInteger:inte ] forKey:@"M"];
                break;
            }
            case 'n':
            case 'N':{
                NSInteger inte = [[mutLetters objectForKey:@"N"]integerValue];
                inte++;
                [mutLetters setValue:[NSNumber numberWithInteger:inte ] forKey:@"N"];
                break;
            }
            case 'o':
            case 'O':{
                NSInteger inte = [[mutLetters objectForKey:@"O"]integerValue];
                inte++;
                [mutLetters setValue:[NSNumber numberWithInteger:inte ] forKey:@"O"];
                break;
            }
            case 'p':
            case 'P':{
                NSInteger inte = [[mutLetters objectForKey:@"P"]integerValue];
                inte++;
                [mutLetters setValue:[NSNumber numberWithInteger:inte ] forKey:@"P"];
                break;
            }
            case 'q':
            case 'Q':{
                NSInteger inte = [[mutLetters objectForKey:@"Q"]integerValue];
                inte++;
                [mutLetters setValue:[NSNumber numberWithInteger:inte ] forKey:@"Q"];
                break;
            }
            case 'r':
            case 'R':{
                NSInteger inte = [[mutLetters objectForKey:@"R"]integerValue];
                inte++;
                [mutLetters setValue:[NSNumber numberWithInteger:inte ] forKey:@"R"];
                break;
            }
            case 's':
            case 'S':{
                NSInteger inte = [[mutLetters objectForKey:@"S"]integerValue];
                inte++;
                [mutLetters setValue:[NSNumber numberWithInteger:inte ] forKey:@"S"];
                break;
            }
            case 't':
            case 'T':{
                NSInteger inte = [[mutLetters objectForKey:@"T"]integerValue];
                inte++;
                [mutLetters setValue:[NSNumber numberWithInteger:inte ] forKey:@"T"];
                break;
            }
            case 'u':
            case 'U':{
                NSInteger inte = [[mutLetters objectForKey:@"U"]integerValue];
                inte++;
                [mutLetters setValue:[NSNumber numberWithInteger:inte ] forKey:@"U"];
                break;
            }
            case 'v':
            case 'V':{
                NSInteger inte = [[mutLetters objectForKey:@"V"]integerValue];
                inte++;
                [mutLetters setValue:[NSNumber numberWithInteger:inte ] forKey:@"V"];
                break;
            }
            case 'w':
            case 'W':{
                NSInteger inte = [[mutLetters objectForKey:@"W"]integerValue];
                inte++;
                [mutLetters setValue:[NSNumber numberWithInteger:inte ] forKey:@"W"];
                break;
            }
            case 'x':
            case 'X':{
                NSInteger inte = [[mutLetters objectForKey:@"X"]integerValue];
                inte++;
                [mutLetters setValue:[NSNumber numberWithInteger:inte ] forKey:@"X"];
                break;
            }
            case 'y':
            case 'Y':{
                NSInteger inte = [[mutLetters objectForKey:@"Y"]integerValue];
                inte++;
                [mutLetters setValue:[NSNumber numberWithInteger:inte ] forKey:@"Y"];
                break;
            }
            case 'z':
            case 'Z':{
                NSInteger inte = [[mutLetters objectForKey:@"Z"]integerValue];
                inte++;
                [mutLetters setValue:[NSNumber numberWithInteger:inte ] forKey:@"Z"];
                break;
            }
                
            default:
                break;
        }
    }
    
    for (NSDictionary* key in mutLetters) {
        
        if (![[mutLetters objectForKey:key]  isEqual: @0]) {
            countSections++;
        }
    }
    
    self.fillLetters = [mutLetters mutableCopy];
    
    for(NSDictionary* key2 in mutLetters){
        if([[mutLetters objectForKey:key2] isEqual : @0]){
            [self.fillLetters removeObjectForKey:key2];
        }
    }
    
    return countSections;
}

@end
