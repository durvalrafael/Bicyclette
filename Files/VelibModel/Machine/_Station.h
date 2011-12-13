// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Station.h instead.

#import <CoreData/CoreData.h>


extern const struct StationAttributes {
	__unsafe_unretained NSString *address;
	__unsafe_unretained NSString *bonus;
	__unsafe_unretained NSString *fullAddress;
	__unsafe_unretained NSString *latitude;
	__unsafe_unretained NSString *longitude;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *number;
	__unsafe_unretained NSString *open;
	__unsafe_unretained NSString *status_available;
	__unsafe_unretained NSString *status_date;
	__unsafe_unretained NSString *status_free;
	__unsafe_unretained NSString *status_ticket;
	__unsafe_unretained NSString *status_total;
} StationAttributes;

extern const struct StationRelationships {
	__unsafe_unretained NSString *region;
} StationRelationships;

extern const struct StationFetchedProperties {
} StationFetchedProperties;

@class Region;















@interface StationID : NSManagedObjectID {}
@end

@interface _Station : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (StationID*)objectID;




@property (nonatomic, strong) NSString *address;


//- (BOOL)validateAddress:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber *bonus;


@property BOOL bonusValue;
- (BOOL)bonusValue;
- (void)setBonusValue:(BOOL)value_;

//- (BOOL)validateBonus:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString *fullAddress;


//- (BOOL)validateFullAddress:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber *latitude;


@property double latitudeValue;
- (double)latitudeValue;
- (void)setLatitudeValue:(double)value_;

//- (BOOL)validateLatitude:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber *longitude;


@property double longitudeValue;
- (double)longitudeValue;
- (void)setLongitudeValue:(double)value_;

//- (BOOL)validateLongitude:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString *name;


//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString *number;


//- (BOOL)validateNumber:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber *open;


@property BOOL openValue;
- (BOOL)openValue;
- (void)setOpenValue:(BOOL)value_;

//- (BOOL)validateOpen:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber *status_available;


@property short status_availableValue;
- (short)status_availableValue;
- (void)setStatus_availableValue:(short)value_;

//- (BOOL)validateStatus_available:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate *status_date;


//- (BOOL)validateStatus_date:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber *status_free;


@property short status_freeValue;
- (short)status_freeValue;
- (void)setStatus_freeValue:(short)value_;

//- (BOOL)validateStatus_free:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber *status_ticket;


@property BOOL status_ticketValue;
- (BOOL)status_ticketValue;
- (void)setStatus_ticketValue:(BOOL)value_;

//- (BOOL)validateStatus_ticket:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber *status_total;


@property short status_totalValue;
- (short)status_totalValue;
- (void)setStatus_totalValue:(short)value_;

//- (BOOL)validateStatus_total:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) Region* region;

//- (BOOL)validateRegion:(id*)value_ error:(NSError**)error_;




@end

@interface _Station (CoreDataGeneratedAccessors)

@end

@interface _Station (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveAddress;
- (void)setPrimitiveAddress:(NSString*)value;




- (NSNumber*)primitiveBonus;
- (void)setPrimitiveBonus:(NSNumber*)value;

- (BOOL)primitiveBonusValue;
- (void)setPrimitiveBonusValue:(BOOL)value_;




- (NSString*)primitiveFullAddress;
- (void)setPrimitiveFullAddress:(NSString*)value;




- (NSNumber*)primitiveLatitude;
- (void)setPrimitiveLatitude:(NSNumber*)value;

- (double)primitiveLatitudeValue;
- (void)setPrimitiveLatitudeValue:(double)value_;




- (NSNumber*)primitiveLongitude;
- (void)setPrimitiveLongitude:(NSNumber*)value;

- (double)primitiveLongitudeValue;
- (void)setPrimitiveLongitudeValue:(double)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSString*)primitiveNumber;
- (void)setPrimitiveNumber:(NSString*)value;




- (NSNumber*)primitiveOpen;
- (void)setPrimitiveOpen:(NSNumber*)value;

- (BOOL)primitiveOpenValue;
- (void)setPrimitiveOpenValue:(BOOL)value_;




- (NSNumber*)primitiveStatus_available;
- (void)setPrimitiveStatus_available:(NSNumber*)value;

- (short)primitiveStatus_availableValue;
- (void)setPrimitiveStatus_availableValue:(short)value_;




- (NSDate*)primitiveStatus_date;
- (void)setPrimitiveStatus_date:(NSDate*)value;




- (NSNumber*)primitiveStatus_free;
- (void)setPrimitiveStatus_free:(NSNumber*)value;

- (short)primitiveStatus_freeValue;
- (void)setPrimitiveStatus_freeValue:(short)value_;




- (NSNumber*)primitiveStatus_ticket;
- (void)setPrimitiveStatus_ticket:(NSNumber*)value;

- (BOOL)primitiveStatus_ticketValue;
- (void)setPrimitiveStatus_ticketValue:(BOOL)value_;




- (NSNumber*)primitiveStatus_total;
- (void)setPrimitiveStatus_total:(NSNumber*)value;

- (short)primitiveStatus_totalValue;
- (void)setPrimitiveStatus_totalValue:(short)value_;





- (Region*)primitiveRegion;
- (void)setPrimitiveRegion:(Region*)value;


@end
