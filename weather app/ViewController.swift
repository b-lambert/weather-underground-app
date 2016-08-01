import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet var numDaysLabel: UILabel!
    @IBOutlet var numDaysSlider: UISlider!
    @IBOutlet var cityTextField: UITextField!
    @IBOutlet var getDataButton: UIButton!
    @IBOutlet var stateCodeTextField: UITextField!
    @IBOutlet var errorMessageLabel: UILabel!

    var forecastData:[[String: String]] = []

    @IBAction func stateCodeEditingDidEnd(sender: AnyObject) {
        getDataButton.enabled = cityTextField.text! != "" && stateCodeTextField.text! != ""
    }

    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        errorMessageLabel.text = ""
        errorMessageLabel.hidden = true
        getDataButton.enabled = false
    }

    @IBAction func endOnExit(sender: AnyObject) {

    }

    @IBAction func editingChanged(sender: AnyObject) {
        getDataButton.enabled = cityTextField.text! != "" && stateCodeTextField.text! != ""
    }
    
    @IBAction func daySliderChanged(sender: AnyObject) {
        numDaysLabel.text = "Days to forecast: \(Int(numDaysSlider.value))"
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func getDataButtonPressed(sender: AnyObject) {
        errorMessageLabel.text = ""
        errorMessageLabel.hidden = true
        // Note: Hard-coding this for simplicity but for real projects, API keys would be obscured in a config file not stored in revision control.
        let apiKey:String = "b2d73d60ea4b959a"
        let stateCode:String = stateCodeTextField.text!
        let cityName:String = cityTextField.text!.stringByReplacingOccurrencesOfString(" ", withString: "_")
        let url:String = "https://api.wunderground.com/api/\(apiKey)/forecast10day/q/\(stateCode)/\(cityName).json"
        //let url:String = "https://api.wunderground.com/api/b2d73d60ea4b959a/forecast10day/q/IL/Chicago.json"

        Alamofire.request(.GET, url)
            .response { request, response, data, error in
                let json:JSON = JSON(data: data!)
                let error:JSON = json["response"]["error"]
                if(error.error != nil) {
                    let days:JSON = json["forecast"]["simpleforecast"]["forecastday"]
                    var currentDayIndex:Int = 0
                    for (_, subJson):(String, JSON) in days{
                        var todaysData = [String: String]()
                        todaysData["high"] = subJson["high"]["fahrenheit"].string
                        todaysData["low"] = subJson["low"]["fahrenheit"].string
                        todaysData["conditions"] = subJson["conditions"].string
                        todaysData["icon_url"] = subJson["icon_url"].string
                        self.forecastData.append(todaysData)
                        currentDayIndex += 1
                        if currentDayIndex >= Int(self.numDaysSlider.value) {
                            break
                        }
                    }
                    
                    self.performSegueWithIdentifier("displayWeatherSegue", sender: sender)
                }
                else {
                    self.errorMessageLabel.text = json["response"]["error"]["description"].string
                    self.errorMessageLabel.hidden = false
                    self.getDataButton.enabled = false
                }
            }
        }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        let destinationVC = segue.destinationViewController as! DisplayWeatherViewController
        destinationVC.cityName = self.cityTextField.text!
        destinationVC.numDays = Int(numDaysSlider.value)
        destinationVC.forecastData = self.forecastData
    }
}
