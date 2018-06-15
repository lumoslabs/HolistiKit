import Foundation

func swizzle(_ forClass: AnyClass, from: Selector, to: Selector) {
    let originalMethod = class_getInstanceMethod(forClass, from)
    let swizzledMethod = class_getInstanceMethod(forClass, to)
    method_exchangeImplementations(originalMethod!, swizzledMethod!)
}
