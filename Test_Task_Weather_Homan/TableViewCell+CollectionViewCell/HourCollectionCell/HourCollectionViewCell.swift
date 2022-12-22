
import UIKit

class HourCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HourCollectionViewCell"
    
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var temp: UILabel!
    @IBOutlet var hour: UILabel!
    
    static func nib() -> UINib {
        return UINib(nibName: "HourCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with hourlyModel: Hour) {
        self.temp.text = "\(hourlyModel.temp)°"
        self.hour.text = "\(hourlyModel.hour)h"
        self.iconImageView.image = iconImageFunction(hourlyModel.condition)
    }
}
