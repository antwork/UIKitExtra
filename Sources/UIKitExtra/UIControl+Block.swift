//
//  UIControl+Block.swift
//
//  Created by Xu Qiang on 10/14/20.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit

private var UIKitExtraButtonCustomActionKey: UInt8 = 1

extension UIControl {
    
    public func eAddAction(block: UIKitExtraActionBlock?) {
        objc_setAssociatedObject(self as Any, &UIKitExtraButtonCustomActionKey, block, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        
        self.removeTarget(self, action: nil, for: .touchUpInside)
        addTarget(self, action: #selector(eHandleCustomActionBlock(_:)), for: .touchUpInside)
    }
    
    private func eActionBlock() -> UIKitExtraActionBlock? {
        return objc_getAssociatedObject(self as Any, &UIKitExtraButtonCustomActionKey) as? UIKitExtraActionBlock
    }
    
    @objc private func eHandleCustomActionBlock(_ sender: UIButton) {
        eActionBlock()?(self)
    }
}
