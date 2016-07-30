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
    var forecastData: [[String: String]] = []

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
        let numDays = Int(numDaysSlider.value)
        numDaysLabel.text = String(numDays)
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func getDataButtonPressed(sender: AnyObject) {
        errorMessageLabel.text = ""
        errorMessageLabel.hidden = true
        let apiKey:String = "b2d73d60ea4b959a"
        let stateCode = stateCodeTextField.text!
        let cityName = cityTextField.text!.stringByReplacingOccurrencesOfString(" ", withString: "_")
        let url:String = "https://api.wunderground.com/api/\(apiKey)/forecast10day/q/\(stateCode)/\(cityName).json"
        //let url:String = "https://api.wunderground.com/api/b2d73d60ea4b959a/forecast10day/q/IL/Chicago.json"

        Alamofire.request(.GET, url)
            .response { request, response, data, error in
                var json = JSON(data: data!)
                //print(json["response"]["error"])
                let error = json["response"]["error"]
                print(error.error)
                if(error.error != nil) {
                    print("entered valid data")
                    let days = json["forecast"]["simpleforecast"]["forecastday"]
                    var currentDayIndex:Int = 0
                    for (key, subJson):(String, JSON) in days{
                        var todaysData = [String: String]()
                        todaysData["high"] = subJson["high"]["fahrenheit"].string
                        todaysData["low"] = subJson["low"]["fahrenheit"].string
                        todaysData["conditions"] = subJson["conditions"].string
                        todaysData["icon_url"] = subJson["icon_url"].string
                        self.forecastData.append(todaysData)
                        currentDayIndex += 1
                        if currentDayIndex >= Int(self.numDaysLabel.text!) {
                            break
                        }
                    }
                    
                    self.performSegueWithIdentifier("displayWeatherSegue", sender: sender)
                }
                else {
                    self.errorMessageLabel.text = json["response"]["error"]["description"].string
                    self.errorMessageLabel.hidden = false
                    print("entered bad data")
                }
    }

    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        // TODO show spinner
        let destinationVC = segue.destinationViewController as! DisplayWeatherViewController
        destinationVC.cityName = self.cityTextField.text!
        destinationVC.numDays = Int(self.numDaysLabel.text!)!
        

        destinationVC.forecastData = self.forecastData
        }
    }
}
