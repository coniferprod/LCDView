import UIKit
import LCDView

class ViewController: UIViewController {

    var timer: Timer!
    
    @IBOutlet weak var display: LCDView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        display.caption = "\u{00B0}"
        
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(updateDisplay), userInfo: nil, repeats: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func updateDisplay() {
        let uuid = UUID().uuidString.lowercased()
        debugPrint("\(uuid)")
        display.caption = uuid
        
    }

}

