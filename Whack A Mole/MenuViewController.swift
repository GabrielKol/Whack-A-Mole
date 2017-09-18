
import UIKit

class MenuViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var imageIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    @IBAction func holePickChange(_ sender: UIButton) {
        imageIndex = 0
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source" , message: "Choose a source" , preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default , handler: { (UIAlertAction) in
            if(UIImagePickerController.isSourceTypeAvailable(.camera)){
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }else{
                print("camera not available")
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Album", style: .default , handler: { (UIAlertAction) in imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Default", style: .default , handler: { (UIAlertAction) in
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let gameVC = storyBoard.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
            gameVC.images[0] = #imageLiteral(resourceName: "mole_empty")
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .default , handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    
    
    @IBAction func healthyPicChange(_ sender: UIButton) {
        imageIndex = 1
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source" , message: "Choose a source" , preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default , handler: { (UIAlertAction) in
            if(UIImagePickerController.isSourceTypeAvailable(.camera)){
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }else{
                print("camera not available")
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Album", style: .default , handler: { (UIAlertAction) in imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Default", style: .default , handler: { (UIAlertAction) in
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let gameVC = storyBoard.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
            gameVC.images[1] = #imageLiteral(resourceName: "mole_healthy")
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .default , handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    
    @IBAction func sickPickChange(_ sender: UIButton) {
        imageIndex = 2
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source" , message: "Choose a source" , preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default , handler: { (UIAlertAction) in
            if(UIImagePickerController.isSourceTypeAvailable(.camera)){
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }else{
                print("camera not available")
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Album", style: .default , handler: { (UIAlertAction) in imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Default", style: .default , handler: { (UIAlertAction) in
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let gameVC = storyBoard.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
            gameVC.images[2] = #imageLiteral(resourceName: "mole_ill")
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .default , handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let gameVC = storyBoard.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        gameVC.images[imageIndex] = info[UIImagePickerControllerOriginalImage] as? UIImage
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

}

