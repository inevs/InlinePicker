import UIKit

extension UITableView {
	func dequeueReusableCellWithIdentifier(identifier: TableViewCellreuseIdentifier, forIndexPath indexPath: NSIndexPath) -> AnyObject {
		return dequeueReusableCellWithIdentifier(identifier.rawValue, forIndexPath: indexPath)
	}

	func dequeueReusableCellWithIdentifier(identifier: TableViewCellreuseIdentifier) -> AnyObject? {
		return dequeueReusableCellWithIdentifier(identifier.rawValue)
	}
	
	func registerNib(nib: UINib, forCellReuseIdentifier identifier: TableViewCellreuseIdentifier) {
		registerNib(nib, forCellReuseIdentifier: identifier.rawValue)
	}

	func registerClass(cellClass: AnyClass, forCellReuseIdentifier identifier: TableViewCellreuseIdentifier) {
		registerClass(cellClass, forCellReuseIdentifier: identifier.rawValue)
	}

}

extension String {
}

func ==(lhs: String?, rhs: TableViewCellreuseIdentifier) -> Bool {
	return lhs != nil && lhs! == rhs.rawValue
}

extension NSIndexPath {
	var nextRow: NSIndexPath {
		return NSIndexPath(forRow: row + 1, inSection: section)
	}
	
	var previousRow: NSIndexPath {
		return NSIndexPath(forRow: row > 0 ? row - 1 : 0, inSection: section)
	}
}

func < (lhs: NSIndexPath, rhs: NSIndexPath) -> Bool {
	return lhs.row < rhs.row
}

func <= (lhs: NSIndexPath, rhs: NSIndexPath) -> Bool {
	return lhs.row <= rhs.row
}

func > (lhs: NSIndexPath, rhs: NSIndexPath) -> Bool {
	return lhs.row > rhs.row
}

func >= (lhs: NSIndexPath, rhs: NSIndexPath) -> Bool {
	return lhs.row >= rhs.row
}
