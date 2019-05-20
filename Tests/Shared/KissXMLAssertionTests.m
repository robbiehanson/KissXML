//
//  KissXMLAssertionTests.m
//  KissXMLTests
//
//  Created by Chris Ballinger on 5/20/19.
//

#import <XCTest/XCTest.h>
#import <KissXML/KissXML.h>

@interface DDAssertionHandler : NSAssertionHandler
{
    BOOL shouldLogAssertionFailure;
}

@property (nonatomic, readwrite, assign) BOOL shouldLogAssertionFailure;

@end

@interface KissXMLAssertionTests : XCTestCase
@end

static NSAssertionHandler *prevAssertionHandler;
static DDAssertionHandler *ddAssertionHandler;

@implementation KissXMLAssertionTests

- (void)setUp
{
    [super setUp];
    // We purposefully do bad things to ensure the library is throwing exceptions when it should.
    // In other words, DDXML uses the same assertions as NSXML, and we test they both throw the same exceptions
    // on bad input.
    //
    // But the normal assertion handler does an NSLog for every failed assertion,
    // even if that assertion is caught. This clogs up our console and makes it difficult to see test cases
    // that failed. So we install our own assertion handler, and disable logging of failed assertions immediately
    // before we enter those tests designed to trigger the assertion.
    // And of course we re-enable the assertion logging when we exit those tests.
    //
    // See the tryCatch method below.

    prevAssertionHandler = [[[NSThread currentThread] threadDictionary] objectForKey:NSAssertionHandlerKey];
    ddAssertionHandler = [[DDAssertionHandler alloc] init];

    [[[NSThread currentThread] threadDictionary] setObject:ddAssertionHandler forKey:NSAssertionHandlerKey];
}

- (void)tearDown
{
    [super tearDown];
    // Remove our custom assertion handler.

    if (prevAssertionHandler)
        [[[NSThread currentThread] threadDictionary] setObject:ddAssertionHandler forKey:NSAssertionHandlerKey];
    else
        [[[NSThread currentThread] threadDictionary] removeObjectForKey:NSAssertionHandlerKey];

    prevAssertionHandler = nil;
    ddAssertionHandler = nil;
}

- (NSException *)tryCatch:(void (^)(void))block
{
    NSException *result = nil;

    ddAssertionHandler.shouldLogAssertionFailure = NO;
    @try {
        block();
    }
    @catch (NSException *e) {
        result = e;
    }
    ddAssertionHandler.shouldLogAssertionFailure = YES;

    return result;
}

- (void)testDoubleAdd { @autoreleasepool
    {
        NSLog(@"Starting %@...", NSStringFromSelector(_cmd));

        NSXMLElement *nsRoot1 = [NSXMLElement elementWithName:@"root1"];
        NSXMLElement *nsRoot2 = [NSXMLElement elementWithName:@"root2"];

        NSXMLElement *nsNode = [NSXMLElement elementWithName:@"node"];
        NSXMLNode *nsAttr = [NSXMLNode attributeWithName:@"key" stringValue:@"value"];
        NSXMLNode *nsNs = [NSXMLNode namespaceWithName:@"a" stringValue:@"domain.com"];

        NSException *nsInvalidAddException1 = nil;
        NSException *nsInvalidAddException2 = nil;
        NSException *nsInvalidAddException3 = nil;

        NSException *nsDoubleAddException1 = nil;
        NSException *nsDoubleAddException2 = nil;
        NSException *nsDoubleAddException3 = nil;

        nsInvalidAddException1 = [self tryCatch:^{
            // Elements can only have text, elements, processing instructions, and comments as children
            [nsRoot1 addChild:nsAttr];
        }];

        nsInvalidAddException2 = [self tryCatch:^{
            // Not an attribute
            [nsRoot1 addAttribute:nsNode];
        }];

        nsInvalidAddException3 = [self tryCatch:^{
            // Not a namespace
            [nsRoot1 addNamespace:nsNode];
        }];

        [nsRoot1 addChild:nsNode];
        nsDoubleAddException1 = [self tryCatch:^{
            // Cannot add a child that has a parent; detach or copy first
            [nsRoot2 addChild:nsNode];
        }];

        [nsRoot1 addAttribute:nsAttr];
        nsDoubleAddException2 = [self tryCatch:^{
            // Cannot add an attribute with a parent; detach or copy first
            [nsRoot2 addAttribute:nsAttr];
        }];

        [nsRoot1 addNamespace:nsNs];
        nsDoubleAddException3 = [self tryCatch:^{
            // Cannot add a namespace with a parent; detach or copy first
            [nsRoot2 addNamespace:nsNs];
        }];

        XCTAssert(nsInvalidAddException1 != nil, @"Failed CHECK 1");
        XCTAssert(nsInvalidAddException2 != nil, @"Failed CHECK 2");
        XCTAssert(nsInvalidAddException3 != nil, @"Failed CHECK 3");

        XCTAssert(nsDoubleAddException1 != nil, @"Failed CHECK 4");
        XCTAssert(nsDoubleAddException2 != nil, @"Failed CHECK 5");
        XCTAssert(nsDoubleAddException3 != nil, @"Failed CHECK 6");

        DDXMLElement *ddRoot1 = [DDXMLElement elementWithName:@"root1"];
        DDXMLElement *ddRoot2 = [DDXMLElement elementWithName:@"root2"];

        DDXMLElement *ddNode = [DDXMLElement elementWithName:@"node"];
        DDXMLNode *ddAttr = [DDXMLNode attributeWithName:@"key" stringValue:@"value"];
        DDXMLNode *ddNs = [DDXMLNode namespaceWithName:@"a" stringValue:@"domain.com"];

        NSException *ddInvalidAddException1 = nil;
        NSException *ddInvalidAddException2 = nil;
        NSException *ddInvalidAddException3 = nil;

        NSException *ddDoubleAddException1 = nil;
        NSException *ddDoubleAddException2 = nil;
        NSException *ddDoubleAddException3 = nil;

        ddInvalidAddException1 = [self tryCatch:^{
            // Elements can only have text, elements, processing instructions, and comments as children
            [ddRoot1 addChild:ddAttr];
        }];

        ddInvalidAddException2 = [self tryCatch:^{
            // Not an attribute
            [ddRoot1 addAttribute:ddNode];
        }];

        ddInvalidAddException3 = [self tryCatch:^{
            // Not a namespace
            [ddRoot1 addNamespace:ddNode];
        }];

        [ddRoot1 addChild:ddNode];
        ddDoubleAddException1 = [self tryCatch:^{
            // Cannot add a child that has a parent; detach or copy first
            [ddRoot2 addChild:ddNode];
        }];

        [ddRoot1 addAttribute:ddAttr];
        ddDoubleAddException2 = [self tryCatch:^{
            // Cannot add an attribute with a parent; detach or copy first
            [ddRoot2 addAttribute:ddAttr];
        }];

        [ddRoot1 addNamespace:ddNs];
        ddDoubleAddException3 = [self tryCatch:^{
            // Cannot add a namespace with a parent; detach or copy first
            [ddRoot2 addNamespace:ddNs];
        }];

        XCTAssert(ddInvalidAddException1 != nil, @"Failed test 1");
        XCTAssert(ddInvalidAddException2 != nil, @"Failed test 2");
        XCTAssert(ddInvalidAddException3 != nil, @"Failed test 3");

        XCTAssert(ddDoubleAddException1 != nil, @"Failed test 4");
        XCTAssert(ddDoubleAddException2 != nil, @"Failed test 5");
        XCTAssert(ddDoubleAddException3 != nil, @"Failed test 6");
    }}

- (void)testInsertChild { @autoreleasepool
    {
        NSLog(@"Starting %@...", NSStringFromSelector(_cmd));

        NSXMLElement *nsParent = [NSXMLElement elementWithName:@"parent"];
        DDXMLElement *ddParent = [DDXMLElement elementWithName:@"parent"];

        NSXMLElement *nsChild2 = [NSXMLElement elementWithName:@"child2"];
        DDXMLElement *ddChild2 = [DDXMLElement elementWithName:@"child2"];

        [nsParent insertChild:nsChild2 atIndex:0];
        [ddParent insertChild:ddChild2 atIndex:0];

        XCTAssert([[nsParent XMLString] isEqualToString:[ddParent XMLString]], @"Failed test 1");

        NSXMLElement *nsChild0 = [NSXMLElement elementWithName:@"child0"];
        DDXMLElement *ddChild0 = [DDXMLElement elementWithName:@"child0"];

        [nsParent insertChild:nsChild0 atIndex:0];
        [ddParent insertChild:ddChild0 atIndex:0];

        XCTAssert([[nsParent XMLString] isEqualToString:[ddParent XMLString]], @"Failed test 2");

        NSXMLElement *nsChild1 = [NSXMLElement elementWithName:@"child1"];
        DDXMLElement *ddChild1 = [DDXMLElement elementWithName:@"child1"];

        [nsParent insertChild:nsChild1 atIndex:1];
        [ddParent insertChild:ddChild1 atIndex:1];

        XCTAssert([[nsParent XMLString] isEqualToString:[ddParent XMLString]], @"Failed test 3");

        NSXMLElement *nsChild3 = [NSXMLElement elementWithName:@"child3"];
        DDXMLElement *ddChild3 = [DDXMLElement elementWithName:@"child3"];

        [nsParent insertChild:nsChild3 atIndex:3];
        [ddParent insertChild:ddChild3 atIndex:3];

        XCTAssert([[nsParent XMLString] isEqualToString:[ddParent XMLString]], @"Failed test 4");

        NSException *nsException;
        NSException *ddException;

        NSXMLElement *nsChild5 = [NSXMLElement elementWithName:@"child5"];
        DDXMLElement *ddChild5 = [DDXMLElement elementWithName:@"child5"];

        nsException = [self tryCatch:^{
            // Exception - index (5) beyond bounds (5)
            [nsParent insertChild:nsChild5 atIndex:5];
        }];

        ddException = [self tryCatch:^{
            // Exception - index (5) beyond bounds (5)
            [ddParent insertChild:ddChild5 atIndex:5];
        }];

        XCTAssert(nsException != nil, @"Failed CHECK 1");
        XCTAssert(ddException != nil, @"Failed test 6");
    }}


- (void)testMemoryIssueDebugging { @autoreleasepool
    {
#if DDXML_DEBUG_MEMORY_ISSUES

        NSLog(@"Starting %@...", NSStringFromSelector(_cmd));

        // <starbucks>
        //   <latte/>
        // </starbucks>

        NSMutableString *xmlStr = [NSMutableString stringWithCapacity:100];
        [xmlStr appendString:@"<starbucks>"];
        [xmlStr appendString:@"  <latte/>"];
        [xmlStr appendString:@"</starbucks>"];

        DDXMLDocument *doc = [[DDXMLDocument alloc] initWithXMLString:xmlStr options:0 error:nil];
        DDXMLElement *starbucks = [doc rootElement];
        DDXMLElement *latte = [[starbucks elementsForName:@"latte"] lastObject];

        [doc release];

        NSException *exception1;
        exception1 = [self tryCatch:^{

            [starbucks name];
            [latte name];
        }];
        XCTAssert(exception1 == nil, @"Failed test 1");

        [starbucks removeChildAtIndex:0];

        NSException *exception2;
        exception2 = [self tryCatch:^{

            [latte name];
        }];
        XCTAssert(exception2 != nil, @"Failed test 2");

        // <animals>
        //   <duck/>
        // </animals>

        DDXMLElement *animals = [[DDXMLElement alloc] initWithName:@"animals"];
        DDXMLElement *duck = [DDXMLElement elementWithName:@"duck"];

        [animals addChild:duck];
        [animals release];

        NSException *exception3;
        exception3 = [self tryCatch:^{

            [duck name];
        }];
        XCTAssert(exception3 == nil, @"Failed test 3");

        // <colors>
        //   <red/>
        // </colors>

        DDXMLElement *colors = [[DDXMLElement alloc] initWithName:@"colors"];
        DDXMLElement *red = [DDXMLElement elementWithName:@"red"];

        [colors addChild:red];
        [colors setChildren:nil];

        NSException *exception4;
        exception4 = [self tryCatch:^{

            [red name];
        }];
        XCTAssert(exception4 != nil, @"Failed test 4");

#endif
    }}

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

@implementation DDAssertionHandler

@synthesize shouldLogAssertionFailure;

- (instancetype)init
{
    if ((self = [super init]))
    {
        shouldLogAssertionFailure = YES;
    }
    return self;
}

- (void)logFailureIn:(NSString *)place
                file:(NSString *)fileName
          lineNumber:(NSInteger)line
{
    // How Apple's default assertion handler does it (all on one line):
    //
    // *** Assertion failure in -[NSXMLElement insertChild:atIndex:],
    // /SourceCache/Foundation/Foundation-751.53/XML.subproj/XMLTypes.subproj/NSXMLElement.m:823

    NSLog(@"*** Assertion failure in %@, %@:%li", place, fileName, (long int)line);
}

- (void)handleFailureInFunction:(NSString *)functionName
                           file:(NSString *)fileName
                     lineNumber:(NSInteger)line
                    description:(NSString *)format, ...
{
    if (shouldLogAssertionFailure)
    {
        [self logFailureIn:functionName file:fileName lineNumber:line];
    }

    va_list args;
    va_start(args, format);

    NSString *reason = [[NSString alloc] initWithFormat:format arguments:args];

    va_end(args);

    [[NSException exceptionWithName:NSInternalInconsistencyException reason:reason userInfo:nil] raise];
}

- (void)handleFailureInMethod:(SEL)selector
                       object:(id)object
                         file:(NSString *)fileName
                   lineNumber:(NSInteger)line
                  description:(NSString *)format, ...
{
    if (shouldLogAssertionFailure)
    {
        Class objectClass = [object class];

        NSString *type;
        if (objectClass == object)
            type = @"+";
        else
            type = @"-";

        NSString *place = [NSString stringWithFormat:@"%@[%@ %@]",
                           type, NSStringFromClass(objectClass), NSStringFromSelector(selector)];

        [self logFailureIn:place file:fileName lineNumber:line];
    }

    va_list args;
    va_start(args, format);

    NSString *reason = [[NSString alloc] initWithFormat:format arguments:args];

    va_end(args);

    [[NSException exceptionWithName:NSInternalInconsistencyException reason:reason userInfo:nil] raise];
}

@end
