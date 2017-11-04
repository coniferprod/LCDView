import UIKit

enum LCDBorderStyle {
    case none
    case single
    case raised
    case lowered
}

enum LCDDotMatrixStyle {
    case matrix5x7
    case matrix5x8
}


@IBDesignable
class LCDView: UIView {
    @IBInspectable var caption: String = ""
    @IBInspectable var borderColor: UIColor = UIColor.white
    @IBInspectable var dotOnColor: UIColor = UIColor.init(red: 0.0, green: 0.9, blue: 0.0, alpha: 1.0)
    @IBInspectable var dotOffColor: UIColor = UIColor.init(red: 0.0, green: 0.5, blue: 0.0, alpha: 1.0)
    
    let font: [Character: [String]] = [
        "\u{00020}": ["00000", "00000", "00000", "00000", "00000", "00000", "00000"],
        "0": ["01110", "10001", "10011", "10101", "11001", "10001", "01110"],
        "1": ["00100", "01100", "00100", "00100", "00100", "00100", "01110"],
        "2": ["01110", "10001", "00001", "00010", "00100", "01000", "11111"],
        "3": ["11111", "00010", "00100", "00010", "00001", "10001", "01110"],
        "4": ["00010", "00110", "01010", "10010", "11111", "00010", "00010"],
        "5": ["11111", "10000", "11110", "00001", "00001", "10001", "01110"],
        "6": ["00110", "01000", "10000", "11110", "10001", "10001", "01110"],
        "7": ["11111", "00001", "00010", "00100", "01000", "01000", "01000"],
        "8": ["01110", "10001", "10001", "01110", "10001", "10001", "01110"],
        "9": ["01110", "10001", "10001", "01111", "00001", "00010", "01100"],
        ":": ["00000", "01100", "01100", "00000", "01100", "01100", "00000"],
        "a": ["00000", "00000", "01110", "00001", "01111", "10001", "01111"],
        "m": ["00000", "00000", "11010", "10101", "10101", "10001", "10001"]
    ]

    var dotMatrixStyle: LCDDotMatrixStyle?
    var dotWidth: CGFloat = 4.0
    var dotHeight: CGFloat = 4.0
    var interDotSpacing: CGFloat = 4.0
    var interCharacterSpacing: CGFloat = 8.0
    var padding: CGFloat = 4.0
    var matrixWidth = 5
    var matrixHeight = 7
    
    override init(frame: CGRect) {
        self.dotMatrixStyle = .matrix5x7

        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        var xpos = self.padding + 5
        let ypos = 1 + self.padding + 5
        let charWidth = (CGFloat(self.matrixWidth) * self.dotWidth) + ((CGFloat(self.matrixWidth) - 1) * self.interDotSpacing)
        
        for ch in self.caption {
            drawCharacter(ch, at: CGPoint(x: xpos, y: ypos), in: context)
            xpos = xpos + CGFloat(charWidth) + CGFloat(self.interCharacterSpacing)
        }
    }

    func drawCharacter(_ character: Character, at: CGPoint, in context: CGContext) {
        let charLines = font[character] ?? font["\u{00020}"]
        
        var tx = at.x
        var ty = at.y
        
        for i in 0..<self.matrixHeight {
            let line = charLines![i]
            var dotInfo = [Int]()
            for ch in line {
                if ch == "1" {
                    dotInfo.append(1)
                } else {
                    dotInfo.append(0)
                }
            }

            for j in 0..<self.matrixWidth {
                let charDot = dotInfo[j]
                var color: CGColor?
                if charDot == 1 {
                    color = self.dotOnColor.cgColor
                } else if charDot == 0 {
                    color = self.dotOffColor.cgColor
                } else {
                    color = self.backgroundColor?.cgColor
                }
                context.setFillColor(color!)

                context.move(to: CGPoint(x: tx, y: tx))

                let dotRect = CGRect(x: tx, y: ty, width: self.dotWidth, height: self.dotHeight)
                context.addRect(dotRect)

                context.fillPath()
                
                tx = tx + self.dotWidth + self.interDotSpacing
            }
            
            tx = at.x
            ty = ty + self.dotHeight + self.interDotSpacing
        }
    }
}
