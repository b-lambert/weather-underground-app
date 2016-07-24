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
        super.viewDidLoad()
        cityNameLabel.text = cityName
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
