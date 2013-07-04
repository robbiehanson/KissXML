#import "NSString+DDXML.h"

#if ! __has_feature(objc_arc)
#warning This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

@implementation NSString (DDXML)

- (const xmlChar *)dd_xmlChar
{
	return (const xmlChar *)[self UTF8String];
}

#ifdef GNUSTEP
- (NSString *)stringByTrimming
{
	return [self stringByTrimmingSpaces];
}
#else
- (NSString *)dd_stringByTrimming
{
	NSMutableString *mStr = [self mutableCopy];
	CFStringTrimWhitespace((__bridge CFMutableStringRef)mStr);
	
	NSString *result = [mStr copy];
	
	return result;
}
#endif

@end

#ifndef KISS_XML_EXCLUDE_DEPRECATED

@implementation NSString (DDXMLDeprecated)

- (const xmlChar *)xmlChar
{
	return [self dd_xmlChar];
}

- (NSString *)stringByTrimming
{
    return [self dd_stringByTrimming];
}

@end

#endif