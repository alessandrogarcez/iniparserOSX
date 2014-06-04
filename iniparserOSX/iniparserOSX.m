//
//  iniparserOSX.m
//  iniparserOSX
//
//  Created by Alessandro Garcez on 5/30/14.
//  Copyright (c) 2014 Alessandro Garcez. All rights reserved.
//

#import "iniparserOSX.h"

@implementation iniparserOSX

- (id)initWithFile:(NSString *)file{
    
	self = [super init];
	
	if(self){
    
		@try {
			
			int numberOfSections, i;
			dictionary *dictFile;
			NSFileManager *file_manager;
			NSMutableDictionary *dictConfs;
			BOOL fileExists, isDir;
			
			file_manager = [[NSFileManager alloc] init];
			
			fileExists = [file_manager fileExistsAtPath:file isDirectory:&isDir];
			
			if(!fileExists || isDir){
				
				[NSException raise:@"FileNotFoundException" format:@"File does not exists."];
				
			}
			
			dictFile = iniparser_load([file cStringUsingEncoding:[NSString defaultCStringEncoding]]);
			
			if(!dictFile){
				
				[NSException raise:@"LoadIniFileException" format:@"Error while loading ini file."];
				
			}
			
			numberOfSections = iniparser_getnsec(dictFile);
			dictConfs = [[NSMutableDictionary alloc] init];
			
			for(i = 0; i < numberOfSections; i++ ){
				
				char *sectionName, **sectionKeys;
				int numberOfKeys, j;
				NSMutableDictionary *dictKeys;
				
				sectionName = iniparser_getsecname(dictFile, i);
				numberOfKeys = iniparser_getsecnkeys(dictFile, sectionName);
				sectionKeys = iniparser_getseckeys(dictFile, sectionName);
				dictKeys = [[NSMutableDictionary alloc] init];
				
				for(j = 0; j <numberOfKeys; j++){
					
					char *error, *valOfKey;
					NSArray *arrSectionName;
					NSString *keyName, *keyValue;
					
					arrSectionName = [[NSString stringWithFormat:@"%s", sectionKeys[j]] componentsSeparatedByString:@":"];
					keyName = arrSectionName[1];
					
					if(!(valOfKey = iniparser_getstring(dictFile, sectionKeys[j], error))){
						
						[NSException raise:@"ParsingIniFileException" format:@"%s", error];
						
					}
					
					keyValue = [NSString stringWithFormat:@"%s", valOfKey];
					[dictKeys setObject:keyValue forKey:keyName];
					
				}
				
				[dictConfs setObject:dictKeys forKey:[[NSString stringWithFormat:@"%s", sectionName] uppercaseString]];
				
			}
			
			self.data = [NSDictionary dictionaryWithDictionary:dictConfs];
			
		}@catch (NSException *exception) {
			
			[exception raise];
			
		}
		
	}
	
	return  self;
	
};

- (int)numberOfSections{
	
	@try {
		
		int count = (int)(unsigned const)[self.data count];
		return count;
		
	}@catch (NSException *exception) {
		
		[exception raise];
		
	}
	
};

- (int)numberOfKeysInSection:(NSString *)section{
	
	@try {
		
		int count;
		NSDictionary *uniqueSection;
		uniqueSection = [[NSDictionary alloc] initWithDictionary:[self.data valueForKey:section]];
		
		count = (int)(unsigned long)[uniqueSection count];
		
		return count;
		
	}@catch (NSException *exception) {
		
		[exception raise];
		
	}
	
};

- (NSArray *)getSectionsName{

	@try {
		
		NSArray *sections;
		NSMutableArray *arrSections;
		
		for (NSString *section in self.data) {
			
			[arrSections addObject:section];
			
		}
		
		sections = [[NSArray alloc] initWithArray:arrSections];
		
		return sections;
		
	}@catch (NSException *exception) {
		
		[exception raise];
		
	}
	
};

- (NSArray *)getKeysInSection:(NSString *)section{
	
	@try {
		
		NSDictionary *dictSection;
		NSArray *keys;
		NSMutableArray *arrKeys;
		
		dictSection = [[NSDictionary alloc] initWithDictionary:[self.data objectForKey:section]];
		
		for (NSString *key in dictSection) {
			
			[arrKeys addObject:key];
			
		}
		
		keys = [[NSArray alloc] initWithArray:arrKeys];
		return keys;
		
	}@catch (NSException *exception) {
		
		[exception raise];
		
	}
	
};

- (NSString *)getValueForKey:(NSString *)key inSection:(NSString *)section{
	
	@try {
		
		NSString *value;
		NSDictionary *dictSection;
		
		dictSection = [[NSDictionary alloc] initWithDictionary:[self.data valueForKey:section]];
		value = [dictSection valueForKey:key];
		
		return value;
		
	}@catch (NSException *exception) {
		
		[exception raise];
		
	}
	
};

@end
