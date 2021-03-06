//
//  iniparserOSXTests.m
//  iniparserOSXTests
//
//  Created by Alessandro Garcez on 5/30/14.
//  Copyright (c) 2014 Alessandro Garcez. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "iniparserOSX.h"


@interface iniparserOSXTests : XCTestCase

@property iniparserOSX *iniFile;

@end

@implementation iniparserOSXTests

- (void)setUp{
	
    [super setUp];
    self.iniFile = [[iniparserOSX alloc] initWithFile:@"/Users/alessandrogarcez/work/OSX/iniparserOSX/iniparserOSXTests/iniparserOSX.ini"];
	
}

- (void)tearDown{
	
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInitWithFile{
	
	XCTAssertThrows([[iniparserOSX alloc] initWithFile:@"/Users/alessandrogarcez/work/OSX/iniparserOSX/iniparserOSXTests/"], @"It's not throwing exception while loading a path and not a file.");
	XCTAssertThrows([[iniparserOSX alloc] initWithFile:@"/Invalid/path"], @"It's not throwing exception while loading a invalid path path.");
	XCTAssert([[iniparserOSX alloc] initWithFile:@"/Users/alessandrogarcez/work/OSX/iniparserOSX/iniparserOSXTests/iniparserOSX.ini"], @"It's not loading ini file.");
	
}

- (void)testNumberOfSections{
	
	XCTAssertEqual([self.iniFile numberOfSections], 2, @"The number of senctions is incorrect.");

}

- (void)testNumberOfKeysInSection{
	
	XCTAssertEqual([self.iniFile numberOfKeysInSection:@"CORE"], 8, @"The number of keys is incorrect.");
	XCTAssertThrows([self.iniFile numberOfKeysInSection:@"NOSECTION"], @"It's accepting non existing sections.");
	XCTAssertEqual([self.iniFile numberOfKeysInSection:@"TEST"], 0,@"It's not returning zero for empty section.");
	
}

- (void)testGetSectionsName{
	
	XCTAssertTrue([self.iniFile getSectionsName], @"It's not returning section's names.");
	XCTAssert([[self.iniFile getSectionsName] count] > 0, "The returned number of sention's name is wrong.");
	XCTAssertEqualObjects([self.iniFile getSectionsName][0], @"CORE", "The name of section is wrong.");
	XCTAssertEqualObjects([self.iniFile getSectionsName][1], @"TEST", "The name of section is wrong.");
	
}

- (void)testGetKeysInSection{
	
	XCTAssertThrows([self.iniFile getKeysInSection:@"UNAVAIABLESECTION"], @"It's not returning exception while selected a non existing section.");
	XCTAssertTrue([self.iniFile getKeysInSection:@"CORE"], @"It's not returning key's names.");
	XCTAssertEqual([[self.iniFile getKeysInSection:@"CORE"] count], 8, "It's not returning key's names correctly.");
	
}

- (void)testGetValueForKey{
	
	XCTAssertThrows([self.iniFile getValueForKey:@"root_dir" inSection:@"NONEXISTINGKEY"], @"It's not returning exception while informing a non existing section.");
	XCTAssertThrows([self.iniFile getValueForKey:@"non_existing_key" inSection:@"CORE"], @"It's not returning exception while informing a non existing key.");
	XCTAssertEqualObjects([self.iniFile getValueForKey:@"root_dir" inSection:@"CORE"], @"./", @"It's returnig wrong value.");
	XCTAssertEqualObjects([self.iniFile getValueForKey:@"sleeptime" inSection:@"CORE"], @"60", @"It's returnig wrong value.");

}

- (void)testGetSectionWithName{
	
	XCTAssertThrows([self.iniFile getSectionWithName:@"CORE_INVALID"], @"It's not returning exception while informing a non existing section.");
	XCTAssertTrue([self.iniFile getSectionWithName:@"CORE"], @"It's returning invalid section");
	XCTAssertNotEqual([[self.iniFile getSectionWithName:@"CORE"] count], (int)@8, @"It's returning wrong number of itens in section.");
	
}

@end