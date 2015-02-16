import UIKit

class DatePickerValueCell: UITableViewCell {

	var item: DataItem? {
		didSet {
			if item != nil {
				self.textLabel?.text = item!.displayName
				if let data = item!.dataObject as? NSDate {
					self.detailTextLabel?.text = dateFormatter.stringFromDate(data)
				}
			}
		}
	}
	
	lazy var dateFormatter: NSDateFormatter = {
		let formatter = NSDateFormatter()
		formatter.dateStyle = .ShortStyle
		return formatter
	}()
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: .Value1, reuseIdentifier: reuseIdentifier)
	}
	
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}


}
