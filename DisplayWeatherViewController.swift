import UIKit

class DisplayWeatherViewController: UIViewController {
    
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

    @IBAction func selectDayValueChanged(sender: AnyObject) {
        currentDayIndex = selectDaySegmentedControl.selectedSegmentIndex
    }

    override func viewDidLoad() {
        //TODO make segmentControl hidden by default
        super.viewDidLoad()
        cityNameLabel.text = cityName
        if numDays > 1 {
            // TODO make it visible
            if numDays > 2 {
                for i in 2...numDays - 1 {
                    selectDaySegmentedControl.insertSegmentWithTitle(String(i + 1), atIndex: i, animated: true)
                }
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
