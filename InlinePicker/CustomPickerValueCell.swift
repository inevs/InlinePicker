import UIKit

class CustomPickerValueCell: UITableViewCell {

	var item: DataItem? {
		didSet {
			updateUI()
		}
	}
	
	var currentSelection: Int {
		didSet {
			updateUI()
		}
	}

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		currentSelection = 0
		super.init(style: .Value1, reuseIdentifier: reuseIdentifier)
	}
	
	required init(coder aDecoder: NSCoder) {
		currentSelection = 0
		super.init(coder: aDecoder)
	}
	
	func updateUI() {
		if let item = item {
			self.textLabel?.text = item.displayName
			if let items = item.dataObject as? [AnyObject] {
				if let selected = items[currentSelection] as? String {
					self.detailTextLabel?.text = selected
				}
			}
		}
	}

}
