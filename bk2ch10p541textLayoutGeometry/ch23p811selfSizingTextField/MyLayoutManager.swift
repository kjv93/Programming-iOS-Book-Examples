
import UIKit

class MyLayoutManager : NSLayoutManager {
    
    var wordRange : NSRange = NSMakeRange(0,0)
    
    override func drawBackground(forGlyphRange glyphsToShow: NSRange, at origin: CGPoint) {
        super.drawBackground(forGlyphRange:glyphsToShow, at:origin)
        if self.wordRange.length == 0 {
            return
        }
        var range = self.glyphRange(forCharacterRange:self.wordRange, actualCharacterRange:nil)
        range = NSIntersectionRange(glyphsToShow, range)
        if range.length == 0 {
            return
        }
        if let tc = self.textContainerForGlyph(at:range.location, effectiveRange:nil, withoutAdditionalLayout:true) {
            var r = self.boundingRect(forGlyphRange:range, in:tc)
            r.origin.x += origin.x
            r.origin.y += origin.y
            let c = UIGraphicsGetCurrentContext()!
            c.saveGState()
            c.setStrokeColor(UIColor.black().cgColor)
            c.setLineWidth(1.0)
            c.stroke(r)
            c.restoreGState()
        }
    }
    
    
}
