import UIKit

public class MyTableViewController: UITableViewController, CustomPickerCellDelegate {

	let dataSource = MyDataSource()
	var indexpathForPicker: NSIndexPath?
	
	var showsPicker: Bool {
		return indexpathForPicker != nil
	}
	
	override public func viewDidLoad() {
		tableView.registerClass(SimpleInfoCell.self, forCellReuseIdentifier: .SimpleInfoCell)
		tableView.registerClass(DatePickerCell.self, forCellReuseIdentifier: .DatePickerCell)
		tableView.registerClass(DatePickerValueCell.self, forCellReuseIdentifier: .DatePickerValueCell)
		tableView.registerClass(CustomPickerCell.self, forCellReuseIdentifier: .CustomPickerCell)
		tableView.registerClass(CustomPickerValueCell.self, forCellReuseIdentifier: .CustomPickerValueCell)
	}
	
	override public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		var numberOfRows = dataSource.count
		if showsPicker {
			numberOfRows++
		}
		return numberOfRows
	}
	
	override public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		if showsPicker && indexPath == indexpathForPicker! {
			let item = itemAtIndexPath(indexPath.previousRow)
			if item.cellType == .DatePickerValueCell {
				return datePickerCellWithItem(item)
			} else if item.cellType == .CustomPickerValueCell {
				return customPickerCellWithItem(item)
			}
		}
		let item = itemAtIndexPath(indexPath)
		if item.cellType == .DatePickerValueCell {
			return datePickerValueCellWithItem(item)
		}
		if item.cellType == .CustomPickerValueCell {
			return customPickerValueCellWithItem(item)
		}
		return simpleInfoCellWithItem(item)
	}
	
	func itemAtIndexPath(indexPath: NSIndexPath) -> DataItem {
		if showsPicker && indexPath > indexpathForPicker! {
			return dataSource.itemAtIndexPath( indexPath.previousRow)
		}
		return dataSource.itemAtIndexPath(indexPath)
	}

	func simpleInfoCellWithItem(item: DataItem) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier(.SimpleInfoCell) as SimpleInfoCell
		cell.info = item
		return cell
	}
	
	func customPickerCellWithItem(item: DataItem) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier(.CustomPickerCell) as CustomPickerCell
		cell.item = item
		cell.delegate = self
		return cell
	}

	func datePickerValueCellWithItem(item: DataItem) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier(.DatePickerValueCell) as DatePickerValueCell
		cell.item = item
		return cell
	}

	func customPickerValueCellWithItem(item: DataItem) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier(.CustomPickerValueCell) as CustomPickerValueCell
		cell.item = item
		return cell
	}
	
	func datePickerCellWithItem(item: DataItem) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier(.DatePickerCell) as DatePickerCell
		cell.item = item
		cell.datePicker?.addTarget(self, action: Selector("datePickerValueChanged:"), forControlEvents:.ValueChanged)
		return cell
	}
	
	override public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		tableView.deselectRowAtIndexPath(indexPath, animated: true)
		if let cell = tableView.cellForRowAtIndexPath(indexPath) {
			if didSelectAnotherPickerValueCell(cell) {
				openNewPickerAtIndexPath(indexPath)
			} else if didSelectSamePickerAtCell(cell) {
				hidePicker()
			} else if didSelectPickerValueCell(cell) {
				showPickerCellBelowIndexPath(indexPath)
			} else if didSelectAnotherCell(cell) {
				hidePicker()
			}
		}
	}
	
	func didSelectAnotherPickerValueCell(cell: UITableViewCell) -> Bool {
		if let indexPath = tableView.indexPathForCell(cell) {
			return showsPicker && isPickerValueCell(cell) && indexPath.nextRow.row != indexpathForPicker!.row
		}
		return false
	}
	
	func openNewPickerAtIndexPath(indexPath: NSIndexPath) {
		let newPickerIndexPath = indexpathForPicker! < indexPath ? indexPath.previousRow : indexPath
		hidePicker()
		showPickerCellBelowIndexPath(newPickerIndexPath)
	}
	
	func didSelectSamePickerAtCell(cell: UITableViewCell) -> Bool {
		return showsPicker && isPickerValueCell(cell)
	}
	
	func didSelectPickerValueCell(cell: UITableViewCell) -> Bool {
		return isPickerValueCell(cell)
	}

	func didSelectAnotherCell(cell: UITableViewCell) -> Bool {
		return !isPickerValueCell(cell)
	}

	func isPickerValueCell(cell: UITableViewCell) -> Bool {
		return cell.reuseIdentifier == .DatePickerValueCell || cell.reuseIdentifier == .CustomPickerValueCell
	}
	
	func isNotSamePickerIndexPath(indexPath: NSIndexPath) -> Bool {
		return indexPath.nextRow != indexpathForPicker!
	}
	
	func updatePickerCellForIndexPath(indexPath: NSIndexPath) {
		if showsPicker {
			hidePicker()
		} else {
			showPickerCellBelowIndexPath(indexPath)
		}
	}
	
	func showPickerCellBelowIndexPath(indexPath: NSIndexPath) {
		if !showsPicker {
			indexpathForPicker = indexPath.nextRow
			tableView.insertRowsAtIndexPaths([indexpathForPicker!], withRowAnimation: UITableViewRowAnimation.Fade)
		}
	}

	func hidePicker() {
		if showsPicker {
			let temp = indexpathForPicker!
			indexpathForPicker = nil
			tableView.deleteRowsAtIndexPaths([temp], withRowAnimation: UITableViewRowAnimation.Fade)
		}
	}

	func datePickerValueChanged(datePicker: UIDatePicker) {
		if showsPicker {
			let dataItem = dataSource.itemAtIndexPath(indexpathForPicker!.previousRow)
			dataItem.dataObject = datePicker.date
			let pickerValueCell = tableView.cellForRowAtIndexPath(indexpathForPicker!.previousRow) as DatePickerValueCell
			pickerValueCell.item = dataItem
		}
	}
	
	func customPickerCell(cell: CustomPickerCell, didSelectRow row: Int) {
		if showsPicker {
			let pickerValueCell = tableView.cellForRowAtIndexPath(indexpathForPicker!.previousRow) as CustomPickerValueCell
			pickerValueCell.currentSelection = row
		}
	}

}
