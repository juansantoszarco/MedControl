//
//  JSZPatient.h
//  MedControl
//
//  Created by Juan Antonio de los Santos Zarco on 2/3/15.
//  Copyright (c) 2015 Juan Antonio de los Santos Zarco. All rights reserved.
//

@import Foundation;

@interface JSZPatient : NSObject

#pragma mark - Properties

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *gender;
@property (copy,nonatomic) NSString *idUser;// Maybe type NSNumber to compare easiest
@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSNumber* phone;
@property (strong,nonatomic) NSArray *visits;



#pragma mark - Method Constructors

+(id) patientWithName:(NSString*) aName
               gender:(NSString*) aGender
               idUser:(NSString*) aIdUser
                 date:(NSDate*) aDate
                phone:(NSNumber*) aPhone
               visits:(NSArray*)aVisits;


#pragma mark - Designed Initializer

-(id) initWithName: (NSString*) aName
            gender:(NSString*) aGender
            idUser:(NSString*) aIdUser
              date:(NSDate*) aDate
             phone:(NSNumber*) aPhone
            visits:(NSArray*)aVisits;

// Inicializador a partir de diccionario JSON
-(id) initWithDictionary:(NSDictionary *)aDict;

#pragma mark - Utils


//Metodo para extraer visitas
-(NSArray*)extractVisitsFromJSONArray: (NSArray*)JSONArray;

//Metodo para extraer pruebas
-(NSArray*)extractProofsFromVisit: (NSDictionary*)dataFromVisit;

@end

