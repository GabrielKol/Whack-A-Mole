
import UIKit
import CoreData
import CoreLocation

class ConclusionViewController: UIViewController, CLLocationManagerDelegate {

    var locationManager: CLLocationManager?
    var currentLocation: CLLocation?
    
    var results: [TopGame] = []
    var isRecordTableReachedTen: Bool = false
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    
    var finalScore = 0
    @IBOutlet weak var finalScoreLabel: UILabel!
    
    @IBAction func submit(_ sender: UIButton) {
        let nickName = nameText.text
        if(!isRecordTableReachedTen){
            if let topGame:TopGame = NSEntityDescription.insertNewObject(forEntityName: "TopGame", into: DatabaseHelper.getContext()) as? TopGame{
                topGame.name = nickName
                topGame.score = Int16 (finalScore)
                if(currentLocation != nil){
                    topGame.latitude = (currentLocation?.coordinate.latitude)!
                    topGame.longtude = (currentLocation?.coordinate.longitude)!
                }
                else{
                    topGame.latitude = 0
                    topGame.longtude = 0
                }
            }
        }
        else{
            results[0].setValue(nickName, forKey: "name")
            results[0].setValue(Int16(finalScore), forKey: "score")
            
            if(currentLocation != nil){
                results[0].setValue((currentLocation?.coordinate.latitude)!, forKey: "latitude")
                results[0].setValue((currentLocation?.coordinate.longitude)!, forKey: "longtude")
            }
            else{
                results[0].setValue(0, forKey: "latitude")
                results[0].setValue(0, forKey: "longtude")
            }
        }
        locationManager?.stopUpdatingLocation()
        DatabaseHelper.saveContext()
        nameText.isHidden = true;
        nameLabel.isHidden = true;
        submitButton.isHidden = true;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchRequest: NSFetchRequest<TopGame> = TopGame.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "score", ascending: true)]
        do{
            results = try DatabaseHelper.getContext().fetch(fetchRequest)
            if(results.count > 10){
                isRecordTableReachedTen = true
                if(results[0].score < Int16(finalScore)){
                    nameText.isHidden = false;
                    nameLabel.isHidden = false;
                    submitButton.isHidden = false;
                }
                else{
                    nameText.isHidden = true;
                    nameLabel.isHidden = true;
                    submitButton.isHidden = true;
                }
            }
            else{
                nameText.isHidden = false;
                nameLabel.isHidden = false;
                submitButton.isHidden = false;
            }
        }
        catch{
            print("Error \(error)")
        }
        
        finalScoreLabel.text = "Final Score: " + String(finalScore)
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.startUpdatingLocation()
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestWhenInUseAuthorization()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.currentLocation = locations[0]
    }

}
