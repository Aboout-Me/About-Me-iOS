import UIKit

class AdditionalProfileViewController: UIViewController {

    @IBOutlet var menButton: UIButton!
    @IBOutlet var womenButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        menButton.layer.cornerRadius = 3
        womenButton.layer.cornerRadius = 3
        
        menButton.layer.borderWidth = 2
        womenButton.layer.borderWidth = 2
        
        menButton.layer.borderColor = UIColor.lightGray.cgColor
        womenButton.layer.borderColor = UIColor.lightGray.cgColor
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
