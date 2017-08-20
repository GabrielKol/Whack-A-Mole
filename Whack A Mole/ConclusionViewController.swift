
import UIKit

class ConclusionViewController: UIViewController {

    var finalScore = 0
    @IBOutlet weak var finalScoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        finalScoreLabel.text = "Final Score: " + String(finalScore)
    }

}
