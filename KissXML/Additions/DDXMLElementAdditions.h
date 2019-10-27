#import <Foundation/Foundation.h>
#import "DDXML.h"

// These methods are not part of the standard NSXML API.
// But any developer working extensively with XML will likely appreciate them.

NS_ASSUME_NONNULL_BEGIN
@interface DDXMLElement (DDAdditions)

+ (nullable DDXMLElement *)dd_elementWithName:(NSString *)name xmlns:(NSString *)ns;

- (nullable DDXMLElement *)dd_elementForName:(NSString *)name;
- (nullable DDXMLElement *)dd_elementForName:(NSString *)name xmlns:(NSString *)xmlns;

@property (nonatomic, readwrite, nullable) NSString *dd_xmlns;

@property (nonatomic, readonly) NSString *dd_prettyXMLString;
@property (nonatomic, readonly) NSString *dd_compactXMLString;

- (void)dd_addAttributeWithName:(NSString *)name stringValue:(NSString *)string;

@property (nonatomic, readonly) NSDictionary<NSString*,NSString*> *dd_attributesAsDictionary;

@end

@interface DDXMLElement (DDAdditionsDeprecated)

+ (nullable DDXMLElement *)elementWithName:(NSString *)name xmlns:(NSString *)ns DEPRECATED_MSG_ATTRIBUTE("use dd_elementWithName:xmlns: instead.");

- (nullable DDXMLElement *)elementForName:(NSString *)name DEPRECATED_MSG_ATTRIBUTE("use dd_elementForName: instead.");
- (nullable DDXMLElement *)elementForName:(NSString *)name xmlns:(NSString *)xmlns DEPRECATED_MSG_ATTRIBUTE("use dd_elementForName:xmlns: instead.");

- (nullable NSString *)xmlns DEPRECATED_MSG_ATTRIBUTE("use dd_xmlns instead.");
- (void)setXmlns:(NSString *)ns DEPRECATED_MSG_ATTRIBUTE("use setDd_xmlns: instead.");

- (NSString *)prettyXMLString DEPRECATED_MSG_ATTRIBUTE("use dd_prettyXMLString instead.");
- (NSString *)compactXMLString DEPRECATED_MSG_ATTRIBUTE("use dd_compactXMLString instead.");

- (void)addAttributeWithName:(NSString *)name stringValue:(NSString *)string DEPRECATED_MSG_ATTRIBUTE("use dd_addAttributeWithName:stringValue: instead.");

- (NSDictionary<NSString*,NSString*> *)attributesAsDictionary DEPRECATED_MSG_ATTRIBUTE("use dd_attributesAsDictionary instead.");

@end
NS_ASSUME_NONNULL_END
