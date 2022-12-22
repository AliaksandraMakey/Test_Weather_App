
import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var highTempLabel: UILabel!
    @IBOutlet var lowTampLabel: UILabel!
    @IBOutlet var humidity: UILabel!
    @IBOutlet var iconImageView: UIImageView!
    
    override func prepareForReuse() {
        humidity = nil
        lowTampLabel = nil
        highTempLabel = nil
        dayLabel = nil
        iconImageView.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    static let identifier = "WeatherTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "WeatherTableViewCell", bundle: nil)
    }

    func configure(with forecastModel: Forecast){
        self.highTempLabel?.text = "\(Int(forecastModel.parts.day.tempAvg))"
        self.lowTampLabel?.text = "\(Int(forecastModel.parts.night.tempAvg))"
        self.humidity?.text = "\(Int(forecastModel.parts.day.humidity))%"
        self.dayLabel?.text = forecastModel.day
        self.iconImageView.image = iconImageFunction(forecastModel.parts.day.condition)
    }
}



