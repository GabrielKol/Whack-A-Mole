
import UIKit
import CoreData
import MapKit

class LeaderboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var results: [TopGame] = []
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchRequest: NSFetchRequest<TopGame> = TopGame.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "score", ascending: false)]
        do{
            results = try DatabaseHelper.getContext().fetch(fetchRequest)
        }
        catch{
            print("Error \(error)")
        }
        
        mapView.setRegion(MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2D(latitude: results[0].latitude,longitude: results[0].longtude), 4000, 4000), animated: true)
        for result in results as [TopGame] {
            let mapAnnotation:MapAnnotation = MapAnnotation(title: result.name!,subtitle: "\(result.score)",coordinate: CLLocationCoordinate2D(latitude: result.latitude,longitude: result.longtude))
            mapView.addAnnotation(mapAnnotation)
        }
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count+1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        if(indexPath.row == 0){
            cell.textLabel?.text = "Name     Score      Lat      Long"
            
        }
        else{
            if(results != []){
                let result = results[indexPath.row-1]
                cell.textLabel?.text = result.name!+" ,\(result.score), \(result.latitude), \(result.longtude)"
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mapView.setRegion(MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2D(latitude: results[indexPath.row].latitude, longitude: results[indexPath.row].longtude), 4000, 4000), animated: true)
    }
    
}
