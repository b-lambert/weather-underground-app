//
// Generated by CocoaPods-Keys
// on 25/07/2016
// For more information see https://github.com/orta/cocoapods-keys
//

#import <objc/runtime.h>
#import <Foundation/NSDictionary.h>
#import "WeatherappKeys.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"

@implementation WeatherappKeys

#pragma clang diagnostic pop

+ (BOOL)resolveInstanceMethod:(SEL)name
{
  NSString *key = NSStringFromSelector(name);
  NSString * (*implementation)(WeatherappKeys *, SEL) = NULL;

  if ([key isEqualToString:@"wUKey"]) {
    implementation = _podKeys273d6d25e3171fef8cbd815c2f2de78b;
  }

  if (!implementation) {
    return [super resolveInstanceMethod:name];
  }

  return class_addMethod([self class], name, (IMP)implementation, "@@:");
}

static NSString *_podKeys273d6d25e3171fef8cbd815c2f2de78b(WeatherappKeys *self, SEL _cmd)
{
  
    
      char cString[17] = { WeatherappKeysData[336], WeatherappKeysData[126], WeatherappKeysData[0], WeatherappKeysData[112], WeatherappKeysData[157], WeatherappKeysData[133], WeatherappKeysData[369], WeatherappKeysData[447], WeatherappKeysData[204], WeatherappKeysData[443], WeatherappKeysData[279], WeatherappKeysData[8], WeatherappKeysData[151], WeatherappKeysData[191], WeatherappKeysData[311], WeatherappKeysData[26], '\0' };
    
    return [NSString stringWithCString:cString encoding:NSUTF8StringEncoding];
  
}


static char WeatherappKeysData[450] = "ddBlhibtbZOL60dYo39ggUxgtDaT7i95VXeIbciZ6nXrEerjjn/bHT/CWpVjdSu46tsPzGKZMt79fLScVLht7lRTXmmT9awPBdcLusBbmWlPwBby760mW66kisOvnr2+laVG9dUcg3OUjUXlLDZBiQ29BVW/q3Vedu1A5O8jJCEb0LZfHShl9ZJhTdLnkDb5iiNLACJNFBJTelm8QlMRTKLw9DKY0TIU7DzCSqJg4tskjNiuyXs7cLgwoI4LN1U4psDycuh7cSWmj0SRmK1EQGW49WjTc/y1XfxGQR6iXG4Se8h1wVGKsW89Va0iDKteIWy+Wukp+MCFilH6bnL377YWS3aSWDuW7uVLWWptI9r4jcKz06im6D1GbeHaR16SyCqthOZvZsaZWATmczop31UmQcX4gvfdGHAx0buNCqW/CCFe4I0kGEcyEhRa6/B0\\\"";

- (NSString *)description
{
  return [@{
            @"wUKey": self.wUKey,
  } description];
}

- (id)debugQuickLookObject
{
  return [self description];
}

@end