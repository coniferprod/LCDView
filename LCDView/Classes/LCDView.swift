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
        "!": ["00100", "00100", "00100", "00100", "00100", "00000", "00100"],
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
        "A": ["01110", "10001", "10001", "10001", "11111", "10001", "10001"],
        "B": ["11110", "10001", "10001", "11110", "10001", "10001", "11110"],
        "C": ["01110", "10001", "10000", "10000", "10000", "10001", "01110"],
        "D": ["11100", "10010", "10001", "10001", "10001", "10010", "11100"],
        "E": ["11111", "10000", "10000", "11110", "10000", "10000", "11111"],
        "F": ["11111", "10000", "10000", "11110", "10000", "10000", "10000"],
        "G": ["01110", "10001", "10000", "10111", "10001", "10001", "01111"],
        "H": ["10001", "10001", "10001", "11111", "10001", "10001", "10001"],
        "I": ["01110", "00100", "00100", "00100", "00100", "00100", "01110"],
        "J": ["00111", "00010", "00010", "00010", "00010", "10010", "01100"],
        "K": ["10001", "10010", "10100", "11000", "10100", "10010", "10001"],
        "L": ["10000", "10000", "10000", "10000", "10000", "10000", "11111"],
        "M": ["10001", "11011", "10101", "10101", "10001", "10001", "10001"],
        "N": ["10001", "10001", "11001", "10101", "10011", "10001", "10001"],
        "O": ["01110", "10001", "10001", "10001", "10001", "10001", "01110"],
        "P": ["11110", "10001", "10001", "11110", "10000", "10000", "10000"],
        "Q": ["01110", "10001", "10001", "10001", "10101", "10010", "01101"],
        "R": ["11110", "10001", "10001", "11110", "10100", "10010", "10001"],
        "S": ["01111", "10000", "10000", "01110", "00001", "00001", "11110"],
        "T": ["11111", "00100", "00100", "00100", "00100", "00100", "00100"],
        "U": ["10001", "10001", "10001", "10001", "10001", "10001", "01110"],
        "V": ["10001", "10001", "10001", "10001", "10001", "01010", "00100"],
        "W": ["10001", "10001", "10001", "10101", "10101", "10101", "01010"],
        "X": ["10001", "10001", "01010", "00100", "01010", "10001", "10001"],
        "Y": ["10001", "10001", "10001", "01010", "00100", "00100", "00100"],
        "Z": ["11111", "00001", "00010", "00100", "01000", "10000", "11111"], 
        "a": ["00000", "00000", "01110", "00001", "01111", "10001", "01111"],
        "m": ["00000", "00000", "11010", "10101", "10101", "10001", "10001"]
    ]

    var dotMatrixStyle: LCDDotMatrixStyle?
    var borderStyle: LCDBorderStyle = .none
    var dotWidth: CGFloat = 4.0
    var dotHeight: CGFloat = 4.0
    var interDotSpacing: CGFloat = 4.0
    var interCharacterSpacing: CGFloat = 8.0
    var padding: CGFloat = 4.0
    var matrixWidth = 5
    var matrixHeight = 7
    
    override init(frame: CGRect) {
        self.dotMatrixStyle = .matrix5x7

        // TODO: Set matrix width and height from style constant
        
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
