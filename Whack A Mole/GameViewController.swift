
import UIKit

class GameViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var timerLabel: UILabel!
    var seconds = 30
    var primaryTimer = Timer()
    var subTimer = Timer()
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var lifeLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var images = [UIImage(named: "mole_empty"), UIImage(named: "mole_healthy"), UIImage(named: "mole_ill")]
    
    var game = Game()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        game.hideAndPopRandomSlots()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        primaryTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameViewController.primaryTick), userInfo: nil, repeats: true)
        subTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(GameViewController.subTick), userInfo: nil, repeats: true)
        
    }
    
    func primaryTick() {
        seconds -= 1
        timerLabel.text  = "Timer: " + String(seconds) + " (sec)"
        if seconds == 0 {
            primaryTimer.invalidate()
            subTimer.invalidate()
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let conclusionVC = storyBoard.instantiateViewController(withIdentifier: "conclusionVC") as! ConclusionViewController
            conclusionVC.finalScore = game.getScore()
            self.present(conclusionVC, animated: true, completion: nil)
        }
    }
    
    func subTick(){
        game.hideAndPopRandomSlots()
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Board.getNumberOfCols()*Board.getNumberOfCols()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath as IndexPath) as! CollectionViewCell
        // Setting images (with animation):
        UIView.transition(with: cell.imageView,
                          duration:0.5,
                          options: .transitionCrossDissolve,
                          animations: { cell.imageView.image = self.images[self.getCreatureValueInSlot(position: indexPath.row)] },
                          completion: nil)
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        game.playSlot(positionI: indexPath.row / Board.getNumberOfCols(), positionJ: indexPath.row % Board.getNumberOfCols())
        cell.imageView.image = images[0]
        scoreLabel.text = "Score: " + String(game.getScore())
        lifeLabel.text = "Life: " + String(game.getLife())
        if(game.getLife() == 0){
            primaryTimer.invalidate()
            subTimer.invalidate()
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let conclusionVC = storyBoard.instantiateViewController(withIdentifier: "conclusionVC") as! ConclusionViewController
            conclusionVC.finalScore = game.getScore()
            self.present(conclusionVC, animated: true, completion: nil)
        }
    }
    
    func getCreatureValueInSlot(position: Int) -> Int {
        let posI: Int = position / Board.getNumberOfCols()
        let posJ: Int = position % Board.getNumberOfCols()
        return game.getBoard().getSlot(positionI: posI, positionJ: posJ).getOccupyingCreature().rawValue
    }
    
    
    
    

}
