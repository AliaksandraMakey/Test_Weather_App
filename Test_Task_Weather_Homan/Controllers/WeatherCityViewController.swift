

import UIKit

class WeatherCityViewController: UIViewController {
    
    @IBOutlet weak var windGustAndDirLabel: UILabel!
    @IBOutlet var tableViewSomeCity: UITableView!
    @IBOutlet weak var weatherDetailsView: UIView!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var precipitationLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var uvIndexLabel: UILabel!
    
    var dataWeather: WeatherResponse?
    var hourlyModel = [Hour]()
    var city = City(name: "", lon: 0.0, lat: 0.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.09292642027, green: 0.5254631042, blue: 0.8978190422, alpha: 1)
        tableViewSomeCity.backgroundColor  = #colorLiteral(red: 0.09292783588, green: 0.5254629254, blue: 0.8936833739, alpha: 1)
        WeatherService().loadWeatherData(city: city.name, lon: city.lon, lat: city.lat, limit: 7, extra: true, hours: true) { response in
            DispatchQueue.main.async {
                self.dataWeather = response
                self.hourlyModel = response.forecasts[0].hours
                self.configure(forecast: response.forecasts[0], fact: response.fact)
                self.tableViewSomeCity.tableHeaderView = self.createTableHeader()
                self.tableViewSomeCity.reloadData()
            }
        }
        
        tableViewSomeCity.register(HourlyTableViewCell.nib(), forCellReuseIdentifier: HourlyTableViewCell.identifier)
        tableViewSomeCity.register(WeatherTableViewCell.nib(), forCellReuseIdentifier: WeatherTableViewCell.identifier)
  
        tableViewSomeCity.delegate = self
        tableViewSomeCity.dataSource = self
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    
    func createTableHeader() -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 395, height: 250))
        headerView.backgroundColor =  #colorLiteral(red: 0.09292783588, green: 0.5254629254, blue: 0.8936833739, alpha: 1)
   
        guard let dataWeather = dataWeather else {return UIView()}
        let locationLabel = UILabel(frame: CGRect(x: 87.5, y: 0, width: 200, height: 41))
        let tempNowLabel = UILabel(frame: CGRect(x: 114.5, y: 30, width: 150, height: 120))
        let conditionLabel = UILabel(frame: CGRect(x: 87.5, y: 150, width: 190, height: 24))
        let maxTempAndminTemp = UILabel(frame: CGRect(x: 87.5, y: 170, width: 190, height: 24))
        
        headerView.addSubview(locationLabel)
        headerView.addSubview(tempNowLabel)
        headerView.addSubview(conditionLabel)
        headerView.addSubview(maxTempAndminTemp)
        
        locationLabel.textAlignment = .center
        locationLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tempNowLabel.textAlignment = .center
        tempNowLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        conditionLabel.textAlignment = .center
        conditionLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        maxTempAndminTemp.textAlignment = .center
        maxTempAndminTemp.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        locationLabel.text = city.name
        locationLabel.font = UIFont.systemFont(ofSize: 34, weight: .regular)
        
        conditionLabel.text = dataWeather.fact.condition
        conditionLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        
        tempNowLabel.text = "\(Int(dataWeather.fact.temp ?? 0))°"
        tempNowLabel.font = UIFont.systemFont(ofSize: 96, weight: .thin)
        let max = dataWeather.forecasts[0].parts.day.tempMax
        let min = dataWeather.forecasts[0].parts.night.tempMin
        maxTempAndminTemp.text = "H:\(Int(max))°  L:\(Int(min))°"
        
        return headerView
    }
    
    func configure(forecast: Forecast, fact: Fact) {
        self.sunsetLabel.text = forecast.sunset
        self.sunriseLabel.text = forecast.sunrise
        self.humidityLabel.text = "\(Int(fact.humidity))%"
        self.windLabel.text = "s \(Int((fact.windSpeed)*3.6)) km/hr" // перевести с мет/сек
        self.feelsLikeLabel.text = "\(Int(fact.feelsLike))°"
        self.pressureLabel.text = "\(Int(fact.pressurePa)) hPa"
        self.uvIndexLabel.text = "\(Int(fact.uvIndex))"
        self.precipitationLabel.text = factPrecStrengthFunction(fact.precStrength)
         let factWindGust = "Wind velocity \(fact.windGust!) mps."
        self.windGustAndDirLabel?.text = windGustAndDirFunction(fact.windDir, factWindGust)

    }

}

extension WeatherCityViewController: UITableViewDataSource, UITableViewDelegate {
    /// table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
            if dataWeather == nil {
            return 0
        } else {
            return (dataWeather?.forecasts.count)!
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dataWeather = dataWeather else {return UITableViewCell()}
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HourlyTableViewCell.identifier, for: indexPath) as? HourlyTableViewCell else { return UITableViewCell() }
            cell.configure(with: hourlyModel)
            cell.backgroundColor = .clear
            return cell
        }
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as? WeatherTableViewCell else { return UITableViewCell() }
            cell.configure(with: dataWeather.forecasts[indexPath.row])
            return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return CGFloat(120)
        }
        return CGFloat(47)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}
