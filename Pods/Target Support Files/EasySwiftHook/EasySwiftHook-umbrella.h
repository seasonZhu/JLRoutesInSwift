#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "SHFFITypeContext.h"
#import "SHMethodSignature.h"
#import "SHObjectiveCUtilities.h"

FOUNDATION_EXPORT double EasySwiftHookVersionNumber;
FOUNDATION_EXPORT const unsigned char EasySwiftHookVersionString[];

