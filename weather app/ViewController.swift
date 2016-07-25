import UIKit
import Alamofire
import SwiftyJSON
import Keys

class ViewController: UIViewController {
    
    @IBOutlet var numDaysLabel: UILabel!
    @IBOutlet var numDaysSlider: UISlider!
    @IBOutlet var cityTextField: UITextField!
    @IBOutlet var getDataButton: UIButton!
    @IBOutlet var stateCodeTextField: UITextField!

    @IBAction func stateCodeEditingDidEnd(sender: AnyObject) {
        getDataButton.enabled = cityTextField.text! != "" && stateCodeTextField.text! != ""
    }
    //var apiKey = WeatherappKeys()//.WUKey

    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()

        activityIndicator.stopAnimating()
        getDataButton.enabled = false
    }

    @IBAction func endOnExit(sender: AnyObject) {

    }

    @IBAction func editingChanged(sender: AnyObject) {
        getDataButton.enabled = cityTextField.text! != "" && stateCodeTextField.text! != ""
    }
    
    @IBAction func daySliderChanged(sender: AnyObject) {
        let numDays = Int(numDaysSlider.value)
        numDaysLabel.text = String(numDays)
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func getDataButtonPressed(sender: AnyObject) {
        // TODO show spinner
        activityIndicator.startAnimating()
        let apiKey:String = "b2d73d60ea4b959a"
        let stateCode = stateCodeTextField.text!
        let cityName = cityTextField.text!.stringByReplacingOccurrencesOfString(" ", withString: "_")
        let url:String = "https://api.wunderground.com/api/\(apiKey)/forecast10day/q/\(stateCode)/\(cityName).json"
        print(url)
        // TODO ERROR HANDLING
//        TODO need to implement prompting user for state name too :(
 
        Alamofire.request(.GET, url)
            .response { request, response, data, error in
                var json = JSON(data: data!)
                print(json)

        }

        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        let destinationVC = segue.destinationViewController as! DisplayWeatherViewController
        destinationVC.cityName = cityTextField.text!
        destinationVC.numDays = Int(numDaysLabel.text!)!
        activityIndicator.stopAnimating()
    }
}

