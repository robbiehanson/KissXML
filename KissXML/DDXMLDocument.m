#import "DDXMLPrivate.h"
#import "NSString+DDXML.h"
#ifdef PAPERS_APP_IOS
    #import "CTidy.h"
#endif

#if ! __has_feature(objc_arc)
#warning This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

/**
 * Welcome to KissXML.
 * 
 * The project page has documentation if you have questions.
 * https://github.com/robbiehanson/KissXML
 * 
 * If you're new to the project you may wish to read the "Getting Started" wiki.
 * https://github.com/robbiehanson/KissXML/wiki/GettingStarted
 * 
 * KissXML provides a drop-in replacement for Apple's NSXML class cluster.
 * The goal is to get the exact same behavior as the NSXML classes.
 * 
 * For API Reference, see Apple's excellent documentation,
 * either via Xcode's Mac OS X documentation, or via the web:
 * 
 * https://github.com/robbiehanson/KissXML/wiki/Reference
**/

@implementation DDXMLDocument

/**
 * Returns a DDXML wrapper object for the given primitive node.
 * The given node MUST be non-NULL and of the proper type.
**/
+ (id)nodeWithDocPrimitive:(xmlDocPtr)doc owner:(DDXMLNode *)owner
{
        return [[DDXMLDocument alloc] initWithDocPrimitive:doc owner:owner];
}

- (id)initWithDocPrimitive:(xmlDocPtr)doc owner:(DDXMLNode *)inOwner
{
        self = [super initWithPrimitive:(xmlKindPtr)doc owner:inOwner];
        return self;
}

+ (id)nodeWithPrimitive:(xmlKindPtr)kindPtr owner:(DDXMLNode *)owner
{
        // Promote initializers which use proper parameter types to enable compiler to catch more mistakes
        NSAssert(NO, @"Use nodeWithDocPrimitive:owner:");

        return nil;
}

- (id)initWithPrimitive:(xmlKindPtr)kindPtr owner:(DDXMLNode *)inOwner
{
        // Promote initializers which use proper parameter types to enable compiler to catch more mistakes.
        NSAssert(NO, @"Use initWithDocPrimitive:owner:");

        return nil;
}

/**
 * Initializes and returns a DDXMLDocument object created from an NSData object.
 *
 * Returns an initialized DDXMLDocument object, or nil if initialization fails
 * because of parsing errors or other reasons.
**/
- (id)initWithXMLString:(NSString *)string options:(NSUInteger)mask error:(NSError **)error
{
        return [self initWithData:[string dataUsingEncoding:NSUTF8StringEncoding]
                          options:mask
                            error:error];
}

/**
 * Initializes and returns a DDXMLDocument object created from an NSData object.
 *
 * Returns an initialized DDXMLDocument object, or nil if initialization fails
 * because of parsing errors or other reasons.
**/
- (id)initWithData:(NSData *)data options:(NSUInteger)mask error:(NSError **)error
{
        if (data == nil || [data length] == 0)
        {
                if (error) *error = [NSError errorWithDomain:@"DDXMLErrorDomain" code:0 userInfo:nil];

                return nil;
        }
        #ifdef PAPERS_APP_IOS
            if (mask & DDXMLDocumentTidyHTML)
            {
                data = [[CTidy tidy] tidyData:data
                                  inputFormat:CTidyFormatHTML
                                 outputFormat:CTidyFormatXML
                                     encoding:@"UTF8"
                                  diagnostics:NULL
                                        error:error];
            }
            else if (mask & DDXMLDocumentTidyXML)
            {
                data = [[CTidy tidy] tidyData:data
                                  inputFormat:CTidyFormatXML
                                 outputFormat:CTidyFormatXML
                                     encoding:@"UTF8"
                                  diagnostics:NULL
                                        error:error];
            }
            if(!data) {
              return nil;
            }
        #endif
        // Even though xmlKeepBlanksDefault(0) is called in DDXMLNode's initialize method,
        // it has been documented that this call seem   s to get reset on the iPhone:
        // http://code.google.com/p/kissxml/issues/detail?id=8
        //
        // Therefore, we call it again here just to be safe.
        xmlKeepBlanksDefault(0);
        [DDXMLNode installErrorHandlersInThread];
        xmlDocPtr doc = xmlParseMemory([data bytes], (int)[data length]);
        if (doc == NULL)
        {
            #if DDXML_FALLBACK_ON_HTML
               htmlParserCtxtPtr ctx = htmlCreateMemoryParserCtxt([data bytes], [data length]);
               int err = htmlParseDocument(ctx);
               if(err == 0) {
                   doc = ctx->myDoc;
                }
                htmlFreeParserCtxt(ctx);
            #endif
              NSError *lastError = [DDXMLNode lastError];
              NSDictionary *userInfo = lastError ? [NSDictionary dictionaryWithObjectsAndKeys:lastError, NSUnderlyingErrorKey, nil] : nil;
              if (error) *error = [NSError errorWithDomain:@"DDXMLErrorDomain" code:1 userInfo:userInfo];
              return nil;
        }

        return [self initWithDocPrimitive:doc owner:nil];
}

/**
 * Returns the root element of the receiver.
**/
- (DDXMLElement *)rootElement
{
#if DDXML_DEBUG_MEMORY_ISSUES
	DDXMLNotZombieAssert();
#endif
	
	xmlDocPtr doc = (xmlDocPtr)genericPtr;
	
	// doc->children is a list containing possibly comments, DTDs, etc...
	
	xmlNodePtr rootNode = xmlDocGetRootElement(doc);
	
	if (rootNode != NULL)
		return [DDXMLElement nodeWithElementPrimitive:rootNode owner:self];
	else
		return nil;
}

- (NSData *)XMLData
{
	// Zombie test occurs in XMLString
	
	return [[self XMLString] dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSData *)XMLDataWithOptions:(NSUInteger)options
{
	// Zombie test occurs in XMLString
	
	return [[self XMLStringWithOptions:options] dataUsingEncoding:NSUTF8StringEncoding];
}

@end
