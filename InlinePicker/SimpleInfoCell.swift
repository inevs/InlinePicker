import UIKit

class SimpleInfoCell: UITableViewCell {

	var info: DataItem? {
		didSet {
			if info != nil {
				self.textLabel?.text = info!.displayName
				if let detail = info!.dataObject as? String {
					self.detailTextLabel?.text = detail
				}
			} else  {
				self.textLabel?.text = ""
				self.detailTextLabel?.text = ""
			}
		}
	}

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: UITableViewCellStyle.Value1, reuseIdentifier: reuseIdentifier)
	}
	
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
}
