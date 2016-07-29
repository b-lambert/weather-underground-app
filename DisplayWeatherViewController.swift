import UIKit

class DisplayWeatherViewController: UIViewController {
    
    @IBOutlet var pickForecastLabel: UILabel!
    @IBOutlet var highTempLabel: UILabel!
    @IBOutlet var lowTempLabel: UILabel!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var selectDaySegmentedControl: UISegmentedControl!
    @IBOutlet var weatherIcon: UIImageView!
    @IBOutlet var weatherStatusLabel: UILabel!

    var numDays: Int = 1
    // TODO make this private somehow
    var currentDayIndex: Int = 0
    var cityName: String = ""
    var forecastData: [[String: String]] = []

    @IBAction func selectDayValueChanged(sender: AnyObject) {
        currentDayIndex = selectDaySegmentedControl.selectedSegmentIndex
        highTempLabel.text = forecastData[currentDayIndex]["high"]
        lowTempLabel.text = forecastData[currentDayIndex]["low"]
        weatherStatusLabel.text = forecastData[currentDayIndex]["conditions"]
        requestImage(forecastData[currentDayIndex]["icon_url"]!) { (image) -> Void in
            self.weatherIcon.image = image
        }
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func requestImage(url: String, success: (UIImage?) -> Void) {
        print("called request image")
        requestURL(url, success: { (data) -> Void in
            if let d = data {
                success(UIImage(data: d))
            }
        })
    }

    func requestURL(url: String, success: (NSData?) -> Void, error: ((NSError) -> Void)? = nil) {
        print("called request URL")
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
