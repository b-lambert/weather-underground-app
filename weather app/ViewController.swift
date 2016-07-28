import UIKit
import Alamofire
import SwiftyJSON
// TODO remove
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
        //let url:String = "https://api.wunderground.com/api/\(apiKey)/forecast10day/q/\(stateCode)/\(cityName).json"
        let url:String = "https://api.wunderground.com/api/b2d73d60ea4b959a/forecast10day/q/IL/Chicago.json"
        // TODO ERROR HANDLING
 
        Alamofire.request(.GET, url)
            .response { request, response, data, error in
                var json = JSON(data: data!)
                let days = json["forecast"]["simpleforecast"]["forecastday"]//.rawValue as! NSMutableArray
                //print(days)
                // TODO: Iterate over days, store data into string:string hash
                var forecastData = [[String: String]()]
                var currentDayIndex:Int = 0
                for (key, subJson):(String, JSON) in days{
                    var todaysData = [String: String]()
                    //var _day = day as! JSON
                    print(subJson)
                    todaysData["high"] = subJson["high"]["fahrenheit"].string
                    todaysData["low"] = subJson["low"]["fahrenheit"].string
                    todaysData["conditions"] = subJson["conditions"].string
                    todaysData["icon_url"] = subJson["icon_url"].string
                    //let conditions:String = day["conditions"].string
                    //todaysData["conditions"] = conditions
                    //todaysData["low"] = day["low"]!["celsius"] as! String//["celsius"]
                    forecastData.append(todaysData)
                    currentDayIndex += 1
                    // Don't send more data than user requested
                    if currentDayIndex >= Int(self.numDaysLabel.text!) {
                        break
                    }
                }
                print(forecastData)
                //print(json)

        }

        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        let destinationVC = segue.destinationViewController as! DisplayWeatherViewController
        destinationVC.cityName = cityTextField.text!
        destinationVC.numDays = Int(numDaysLabel.text!)!
        activityIndicator.stopAnimating()
    }
}

