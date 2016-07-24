import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var numDaysLabel: UILabel!
    @IBOutlet var numDaysSlider: UISlider!
    @IBOutlet var cityTextField: UITextField!
    @IBOutlet var getDataButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        getDataButton.enabled = false
    }

    @IBAction func endOnExit(sender: AnyObject) {

    }

    @IBAction func editingChanged(sender: AnyObject) {
        getDataButton.enabled = cityTextField.text! != ""
    }
    
    @IBAction func daySliderChanged(sender: AnyObject) {
        let numDays = Int(numDaysSlider.value)
        numDaysLabel.text = String(numDays)
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        let destinationVC = segue.destinationViewController as! DisplayWeatherViewController
        destinationVC.cityName = cityTextField.text!
        // Clean this up?
        destinationVC.numDays = Int(numDaysLabel.text!)!
    }
}

