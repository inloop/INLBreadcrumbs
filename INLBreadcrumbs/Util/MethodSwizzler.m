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

	class = object_getClass((id)class);

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