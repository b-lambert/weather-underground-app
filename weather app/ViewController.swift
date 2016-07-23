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
    @IBAction func primaryActionTriggered(sender: AnyObject) {
        print("primary action triggered")
    }

    @IBAction func cityTextFieldEditingDidEnd(sender: AnyObject) {
        print("text field editing did end")
        getDataButton.enabled = cityTextField.text != ""
    }
    
    @IBAction func daySliderChanged(sender: AnyObject) {
        let numDays = Int(numDaysSlider.value)
        numDaysLabel.text = String(numDays)

    }
    @IBAction func valueChanged(sender: AnyObject) {
        print("val changed")
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

