
import UIKit

class HourlyTableViewCell: UITableViewCell {
    static let identifier = "HourlyTableViewCell"
    
    @IBOutlet var collectionViewHourly: UICollectionView!
    
    /// сделать 
    var hourModel: [Hour] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionViewHourly.delegate = self
        collectionViewHourly.dataSource = self
        collectionViewHourly.register(HourCollectionViewCell.nib(), forCellWithReuseIdentifier: HourCollectionViewCell.identifier)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    static func nib() -> UINib {
        return UINib(nibName: "HourlyTableViewCell", bundle: nil)
    }
    
    func configure(with hours: [Hour]) {
        self.hourModel = hours
        collectionViewHourly.reloadData()
    }
}

extension HourlyTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if hourModel.count == 0 {
            return 0
        } else {
            return hourModel.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionViewHourly.dequeueReusableCell(withReuseIdentifier: HourCollectionViewCell.identifier, for: indexPath) as? HourCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(with: hourModel[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
}
