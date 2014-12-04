import Foundation
import UIKIt

class ImageTableViewModel : NSObject, UITableViewDataSource {
    
    var tableRows:Int
    init(size: Int){
        self.tableRows = size
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableRows
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 2
        let cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: nil)
        
        // 3
        let row = indexPath.row
        
        cell.textLabel?.text = "Index Row\(row)"
        cell.detailTextLabel?.text = "Detail Text Label\(indexPath.row)"
        return cell
    }
    
}