import UIKit

class DataItem {
	var displayName: String
	var cellType: TableViewCellreuseIdentifier
	var dataObject: AnyObject?
	var currentSelection: Int
	
	init(displayName: String, cellType: TableViewCellreuseIdentifier, dataObject: AnyObject? = nil) {
		self.displayName = displayName
		self.cellType = cellType
		self.dataObject = dataObject
		self.currentSelection = 0
	}
}

class MyDataSource {
	
	var dataList: [DataItem]
	var count: Int {
		return dataList.count
	}
	
	init() {
		dataList = [
			DataItem(displayName: "Firstname", cellType: .SimpleInfoCell, dataObject: "John"),
			DataItem(displayName: "Lastname", cellType: .SimpleInfoCell, dataObject: "Appleseed"),
			DataItem(displayName: "Birthdate", cellType: .DatePickerValueCell, dataObject: NSDate()),
			DataItem(displayName: "City", cellType: .SimpleInfoCell, dataObject: "Cupertino"),
			DataItem(displayName: "State", cellType: .CustomPickerValueCell, dataObject: ["AL","AK","AZ","AR","CA","CO","CT","DE","FL","GA","HI","ID","IL"]),
			DataItem(displayName: "Street", cellType: .SimpleInfoCell, dataObject: "Infinity Loop 1"),
		]
	}
	
	func itemAtIndexPath(indexPath: NSIndexPath) -> DataItem {
		return dataList[indexPath.row]
	}
	
}
