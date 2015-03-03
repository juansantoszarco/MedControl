//
//  JSZPatient.m
//  MedControl
//
//  Created by Juan Antonio de los Santos Zarco on 2/3/15.
//  Copyright (c) 2015 Juan Antonio de los Santos Zarco. All rights reserved.
//


#import "JSZPatient.h"

@implementation JSZPatient


#pragma mark - Method Constructors

+(id) patientWithName:(NSString*) aName
               gender:(NSString*) aGender
               idUser:(NSString*) aIdUser
                 date:(NSDate*) aDate
                phone:(NSNumber*) aPhone
                photo:(UIImage*) aPhoto
               visits:(NSArray *)aVisits{
    
    return [[self alloc] initWithName:aName
                               gender:aGender
                               idUser:aIdUser
                                 date:aDate
                                phone:aPhone
                                photo:aPhoto
                               visits:aVisits];
    
}

#pragma mark - Designed Initializer

-(id) initWithName: (NSString*) aName
            gender:(NSString*) aGender
            idUser:(NSString*) aIdUser
              date:(NSDate*) aDate
             phone:(NSNumber*) aPhone
             photo:(UIImage*) aPhoto
            visits:(NSArray*)aVisits{
    
    if (self = [super init]) {
        _name = aName;
        _gender = aGender;
        _idUser = aIdUser;
        _date = aDate;
        _phone = aPhone;
        _photo= aPhoto;
        _visits = aVisits;
    }
    return self;
}


-(id) initWithDictionary:(NSDictionary *)aDict{
    
    return [self initWithName:[aDict objectForKey:@"name"]
                       gender:[aDict objectForKey:@"gender"]
                       idUser:[aDict objectForKey:@"idUser"]
                         date:[self extractDateFromJSONArray:[aDict objectForKey:@"lastVisit"]]
                        phone:[aDict objectForKey:@"phone"]
                        photo:[UIImage imageNamed:[aDict objectForKeyedSubscript:@"photo"]]
                       visits:[aDict objectForKey:@"visits"]];
    
}

#pragma mark - Utils



-(NSDate*)extractDateFromJSONArray: (NSString*)stringDate{
    
    NSString *aux =[NSString stringWithFormat:@"%@ %@", stringDate, @"GMT"];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy zzz"];
    NSDate *date = [dateFormat dateFromString:aux];
    
    return date;
    
}

-(NSArray*)extractVisitsFromJSONArray: (NSDictionary*)JSONArray{
    
    NSMutableArray *visits = [NSMutableArray arrayWithCapacity:[JSONArray count]];
    
    for (NSDictionary *dict in JSONArray) {
        [visits addObject:[dict objectForKey:@"informe"]];
    }
    
    
    return visits;
}

-(NSArray*)extractProofsFromVisit: (NSDictionary*)dataFromVisit{
    
    NSMutableArray *data = [NSMutableArray arrayWithCapacity:[dataFromVisit count]];
    
    [data addObject:[dataFromVisit objectForKey:@"pruebas"]];
    
    
    return [data objectAtIndex:0];
}



- (NSString *)description
{
    
    return [NSString stringWithFormat:@"Name: %@ Gender:%@ IdUser:%@  Date:%@ Phone:%@ Visits:%@",self.name,self.gender,self.idUser,self.date,self.phone,self.visits];
}


@end

