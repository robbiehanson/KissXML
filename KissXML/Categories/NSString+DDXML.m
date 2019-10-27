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
- (NSString *)dd_stringByTrimming
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

@implementation NSString (DDXMLDeprecated)

/**
 * xmlChar - A basic replacement for char, a byte in a UTF-8 encoded string.
**/
- (const xmlChar *)xmlChar {
    return [self dd_xmlChar];
}

- (NSString *)stringByTrimming {
    return [self dd_stringByTrimming];
}

@end
