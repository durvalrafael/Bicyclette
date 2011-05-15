//
//  BicycletteDataManager.m
//  
//
//  Created by Nicolas Bouilleaud on 15/05/11.
//  Copyright 2011 Visuamobile. All rights reserved.
//

#import "BicycletteDataManager.h"
#import "NSData+SHA1.h"

@interface BicycletteDataManager()
@property (nonatomic, retain) NSDate *parseDate;
@property (nonatomic, retain) NSURLConnection * updateConnection;
@property (nonatomic, retain) NSMutableData * updateData;
- (void) updateXML;

@end

@implementation BicycletteDataManager
@synthesize updateConnection, updateData, parseDate;


- (id) init
{
	self = [super init];
	if (self != nil) 
	{
		// Find if I need to update
		NSDate * createDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"DatabaseCreateDate"];
		BOOL needUpdate = (nil==createDate || [[NSDate date] timeIntervalSinceDate:createDate] > [[NSUserDefaults standardUserDefaults] doubleForKey:@"DatabaseReloadInterval"]);
		if(needUpdate)
			[self performSelector:@selector(updateXML) withObject:nil afterDelay:0];
	}
	return self;
}

- (void) dealloc
{
	self.parseDate = nil;
	[self.updateConnection cancel];
	self.updateConnection = nil;
	self.updateData = nil;
	[super dealloc];
}

/****************************************************************************/
#pragma mark URL request 

- (void) updateXML
{
	NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kVelibStationsListURL]];
	self.updateConnection = [NSURLConnection connectionWithRequest:request
														  delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSHTTPURLResponse *)response
{
	if(response.statusCode==200)
		self.updateData = [NSMutableData data];
	else
	{
		[self.updateConnection cancel];
		self.updateConnection = nil;
	}
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[self.updateData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	NSLog(@"download failed %@",error);
	[self.updateConnection cancel];
	self.updateConnection = nil;
	self.updateData = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	self.updateConnection = nil;
    NSString * oldSha1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"Database_XML_SHA1"];
    NSString * newSha1 = [self.updateData sha1DigestString];
    if([oldSha1 isEqualToString:newSha1])
    {
        NSLog(@"No need to rebuild database, the data actually hasn't changed.");
        [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"DatabaseCreateDate"];
    }
    else
    {
        self.parseDate = [NSDate date];
		[self parseXML:self.updateData];
        [[NSUserDefaults standardUserDefaults] setObject:self.parseDate forKey:@"DatabaseCreateDate"];
        [[NSUserDefaults standardUserDefaults] setObject:newSha1 forKey:@"Database_XML_SHA1"];
    }
	self.updateData = nil;
}

+ (NSSet*) keyPathsForValuesAffectingDownloadingUpdate
{
	return [NSSet setWithObject:@"updateConnection"];
}

- (BOOL) downloadingUpdate
{
	return self.updateConnection!=nil;
}

- (void) parseXML:(NSData*)xml
{
    [self doesNotRecognizeSelector:_cmd];
}


@end
