import UIKit

class myCell: UITableViewCell {

    @IBOutlet weak var nameL: UILabel!
    @IBOutlet weak var phoneL: UILabel!
    @IBOutlet weak var companyL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }    
}
