import UIKit

extension UITextView {
    
    func setBottomBorderWithColor(color: UIColor, height: CGFloat) {
        
        let currWidth = self.frame.size.width
        let newHeight = self.sizeThatFits(CGSize(width: currWidth, height: CGFloat.greatestFiniteMagnitude)).height
        
        for subview in self.superview!.subviews {
            if subview.tag == 1111 {
                subview.removeFromSuperview()
            }
        }
        print(self.frame.origin.y)
        let border = UIView()
        border.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y + newHeight - height, width: currWidth, height: height)
        border.backgroundColor = color
        border.tag = 1111
        self.superview!.insertSubview(border, aboveSubview: self)
        
    }
    
}
