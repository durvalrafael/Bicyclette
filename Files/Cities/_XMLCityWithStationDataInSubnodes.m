//
//  _XMLCityWithStationDataInSubnodes
//  Bicyclette
//
//  Created by Nicolas on 04/01/13.
//  Copyright (c) 2013 Nicolas Bouilleaud. All rights reserved.
//

#import "_XMLCityWithStationDataInSubnodes.h"
#import "BicycletteCity+ServiceDescription.h"

// Allow me to call methods of subclasses
@interface _XMLCityWithStationDataInSubnodes (XMLCityWithStationDataInSubnodes) <XMLCityWithStationDataInSubnodes>
@end

#pragma mark -

@interface _XMLCityWithStationDataInSubnodes () <NSXMLParserDelegate>
@end

@implementation _XMLCityWithStationDataInSubnodes
{
    NSMutableString * _parsing_currentString;
    NSMutableDictionary * _parsing_currentValues;
}

- (void) parseData:(NSData*)data
{
    // Parse stations XML
    NSXMLParser * parser = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;
    [parser parse];
}

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    _parsing_currentString = [NSMutableString new];
    if([elementName isEqualToString:[self stationElementName]])
        _parsing_currentValues = [NSMutableDictionary new];
}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [_parsing_currentString appendString:string];
}

- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([elementName isEqualToString:[self stationElementName]]) // End of station dict
    {
        [self insertStationWithAttributes:_parsing_currentValues];
        
        // Clear values
        _parsing_currentValues = nil;
    }
    else
    {
        // Accumulate values
        NSString * value = [_parsing_currentString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if(value)
            [_parsing_currentValues setObject:value forKey:elementName];
        _parsing_currentString = nil;
    }
}

@end

@implementation _XMLCityWithStationDataInSubnodes (ServiceDescription)

- (NSMutableDictionary *)fullServiceInfo
{
    NSMutableDictionary * info = [super fullServiceInfo];
    [info setObject:[self stationElementName] forKey:@"station_element_name"];
    return info;
}

@end

