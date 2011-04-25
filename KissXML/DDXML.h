#import "DDXMLNode.h"
#import "DDXMLElement.h"
#import "DDXMLDocument.h"


// KissXML has rather straight-forward memory management.
// However, if the rules are not followed,
// it is often difficult to track down the culprit.
// 
// Enabling this option will help you track down the orphaned subelement.
// More information can be found on the wiki page:
// http://code.google.com/p/kissxml/wiki/MemoryManagementThreadSafety
// 
// Please keep in mind that this option is for debugging only.
// It significantly slows down the library, and should NOT be enabled for production builds.
// 
#define DDXML_DEBUG_MEMORY_ISSUES 0
