import UIKit

@objc protocol CustomPickerCellDelegate {
	optional func customPickerCell(cell: CustomPickerCell, didSelectRow row: Int)
}

class CustomPickerCell: UITableViewCell, UIPickerViewDataSource, UIPickerViewDelegate {

	var item: DataItem?
	weak var delegate: CustomPickerCellDelegate?
	var picker: UIPickerView?
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: .Default, reuseIdentifier: reuseIdentifier)
		postInit()
	}
	
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		postInit()
	}

	func postInit() {
		picker = UIPickerView()
		picker!.setTranslatesAutoresizingMaskIntoConstraints(false)
		picker!.dataSource = self
		picker!.delegate = self
		self.contentView.addSubview(picker!)
		self.contentView.addConstraints([
			NSLayoutConstraint(item: picker!, attribute: .Left, relatedBy: .Equal, toItem: contentView, attribute: .Left, multiplier: 1.0, constant: 0),
			NSLayoutConstraint(item: picker!, attribute: .Right, relatedBy: .Equal, toItem: contentView, attribute: .Right, multiplier: 1.0, constant: 0),
			NSLayoutConstraint(item: picker!, attribute: .Top, relatedBy: .Equal, toItem: contentView, attribute: .Top, multiplier: 1.0, constant: 0),
			NSLayoutConstraint(item: picker!, attribute: .Bottom, relatedBy: .Equal, toItem: contentView, attribute: .Bottom, multiplier: 1.0, constant: 0),
		])
	}

	func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
		return 1
	}

	func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		if let items = item?.dataObject as? [AnyObject] {
			return items.count
		}
		return 0
	}
	
	func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
		if let items = item?.dataObject as? [AnyObject] {
			if let title = items[row] as? String {
				return title
			}
		}
		return ""
	}
	
	func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		delegate?.customPickerCell?(self, didSelectRow: row)
	}

}
