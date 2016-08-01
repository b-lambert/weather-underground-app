import UIKit

class DisplayWeatherViewController: UIViewController {
    
    @IBOutlet var pickForecastLabel: UILabel!
    @IBOutlet var highTempLabel: UILabel!
    @IBOutlet var lowTempLabel: UILabel!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var selectDaySegmentedControl: UISegmentedControl!
    @IBOutlet var weatherIcon: UIImageView!
    @IBOutlet var weatherStatusLabel: UILabel!

    var numDays:Int = 1
    var cityName:String = ""
    var forecastData:[[String:String]] = []

    @IBAction func selectDayValueChanged(sender: AnyObject) {
        displayWeatherByDay(selectDaySegmentedControl.selectedSegmentIndex)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if numDays < 2 {
            pickForecastLabel.hidden = true
            selectDaySegmentedControl.hidden = true
        }
        cityNameLabel.text = cityName
        if numDays > 2 {
            for i in 2...numDays - 1 {
                selectDaySegmentedControl.insertSegmentWithTitle(String(i + 1), atIndex: i, animated: true)
            }
        }
        displayWeatherByDay(0)
    }
    
    func displayWeatherByDay(dayIndex: Int) {
        let currentDay = forecastData[dayIndex]
        requestImage(currentDay["icon_url"]!) { (image) -> Void in
            self.weatherIcon.image = image
        }
        highTempLabel.text = "High: \(currentDay["high"]!)°F"
        lowTempLabel.text = "Low: \(currentDay["low"]!)°F"
        weatherStatusLabel.text = currentDay["conditions"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func requestImage(url: String, success: (UIImage?) -> Void) {
        requestURL(url, success: { (data) -> Void in
            if let d = data {
                success(UIImage(data: d))
            }
        })
    }

    func requestURL(url: String, success: (NSData?) -> Void, error: ((NSError) -> Void)? = nil) {
        NSURLConnection.sendAsynchronousRequest(
            NSURLRequest(URL: NSURL (string: url)!),
            queue: NSOperationQueue.mainQueue(),
            completionHandler: { response, data, err in
                if let e = err {
                    error?(e)
                } else {
                    success(data)
                }
        })
    }

}
