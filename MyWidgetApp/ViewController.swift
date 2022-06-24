import UIKit
import WidgetKit

class ViewController: UIViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.

		if let userDefaults = UserDefaults(suiteName: "group.MyWidgetApp") {
			userDefaults.set(true, forKey: "myFlag")
		}
	}

	@IBAction func refreshAction(_: Any) {
		WidgetCenter.shared.reloadTimelines(ofKind: "MyWidget")
	}
}
