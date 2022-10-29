
import UIKit


extension UIImageView {
    
    func makeRoundedCorners(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
        //self.layer.masksToBounds = true
    }

    func makeToCircle() {
        self.makeRoundedCorners(self.frame.width / 2)
    }
}
