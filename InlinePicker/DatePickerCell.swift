import UIKit

class DatePickerCell: UITableViewCell {

	var item: DataItem?
	var datePicker: UIDatePicker?
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: .Default, reuseIdentifier: reuseIdentifier)
		postInit()
	}
	
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		postInit()
	}
	
	func postInit() {
		datePicker = UIDatePicker()
		datePicker!.setTranslatesAutoresizingMaskIntoConstraints(false)
		datePicker!.datePickerMode = .Date
		self.contentView.addSubview(datePicker!)
		self.contentView.addConstraints([
			NSLayoutConstraint(item: datePicker!, attribute: .Left, relatedBy: .Equal, toItem: contentView, attribute: .Left, multiplier: 1.0, constant: 0),
			NSLayoutConstraint(item: datePicker!, attribute: .Right, relatedBy: .Equal, toItem: contentView, attribute: .Right, multiplier: 1.0, constant: 0),
			NSLayoutConstraint(item: datePicker!, attribute: .Top, relatedBy: .Equal, toItem: contentView, attribute: .Top, multiplier: 1.0, constant: 0),
			NSLayoutConstraint(item: datePicker!, attribute: .Bottom, relatedBy: .Equal, toItem: contentView, attribute: .Bottom, multiplier: 1.0, constant: 0),
		])
	}

}
