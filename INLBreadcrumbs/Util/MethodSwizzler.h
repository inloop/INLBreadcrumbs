//
//  MethodSwizzler.h
//
//  Created by Tomas Hakel on 02/12/2015.
//  Copyright © 2015 Inloop, s.r.o. See LICENSE.md
//

void replaceMethodImplementations(Class class, SEL originalSel, SEL swizzledSel);
void replaceClassMethodImplementations(Class class, SEL originalSel, SEL swizzledSel);

id getAssociatedProperty(id selfObject, SEL propertySelector);
void setAssociatedProperty(id selfObject, SEL propertySelector, id value);