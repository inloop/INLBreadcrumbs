//
//  MethodSwizzler.m
//
//  Created by Tomas Hakel on 02/12/2015.
//  Copyright © 2015 Inloop, s.r.o. See LICENSE.md
//

#import "MethodSwizzler.h"
#import <objc/runtime.h>

void replaceMethodImplementations(Class class, SEL originalSel, SEL swizzledSel)
{
	Method originalMethod = class_getInstanceMethod(class, originalSel);
	Method swizzledMethod = class_getInstanceMethod(class, swizzledSel);

	class_addMethod(class, originalSel, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
		? class_replaceMethod(class, swizzledSel, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
		: method_exchangeImplementations(originalMethod, swizzledMethod);
}

void replaceClassMethodImplementations(Class class, SEL originalSel, SEL swizzledSel)
{
	Method originalMethod = class_getClassMethod(class, originalSel);
	Method swizzledMethod = class_getClassMethod(class, swizzledSel);

	class = object_getClass(class);

	class_addMethod(class, originalSel, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
		? class_replaceMethod(class, swizzledSel, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
		: method_exchangeImplementations(originalMethod, swizzledMethod);
}

id getAssociatedProperty(id selfObject, SEL propertySelector)
{
	return objc_getAssociatedObject(selfObject, propertySelector);
}

void setAssociatedProperty(id selfObject, SEL propertySelector, id value)
{
	objc_setAssociatedObject(selfObject, propertySelector, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@implementation NSObject (MethodSwizzler)

+(void)replaceMethodImplementation:(SEL)originalSel with:(SEL) swizzledSel
{
	replaceMethodImplementations([self class], originalSel, swizzledSel);
}

+(void)replaceClassMethodImplementation:(SEL)originalSel with:(SEL)swizzledSel
{
	replaceClassMethodImplementations([self class], originalSel, swizzledSel);
}

-(id)associatedProperty:(SEL)propertySelector
{
	return getAssociatedProperty(self, propertySelector);
}

-(void)setAssociatedProperty:(SEL)propertySelector value:(id)value
{
	setAssociatedProperty(self, propertySelector, value);
}

@end