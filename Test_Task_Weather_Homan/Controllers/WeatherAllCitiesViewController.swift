
import UIKit
import CoreLocation
import Alamofire

struct City {
    var name: String
    var lon :Double
    var lat: Double
    var fact: Fact?
    var condition: String?
    var localTIme: String?
}
var cities = [City(name: "Warsaw", lon: 21.017532, lat: 52.237049),
              City(name: "Bucharest", lon: 26.096306, lat: 44.439663),
              City(name: "Martuni", lon: 45.302332 , lat: 40.1447222),
              City(name: "Budapest", lon: 19.040236, lat: 47.497913),
              City(name: "Porto Alegre", lon: -51.230000, lat: -30.033056),
              City(name: "Palermo", lon: 13.366667, lat: 38.116669),
              City(name: "Bremen", lon: 8.806422, lat: 53.073635),
              City(name: "Florence", lon: 11.255814, lat: 43.769560),
              City(name: "Utrecht", lon: 5.104480, lat: 52.092876),
              City(name: "Buenos Aires", lon: -58.381592, lat: -34.603722)
]

class WeatherAllCitiesViewController: UIViewController{
    
    var savedCities = [City]()
    
    @IBOutlet var tableViewAllCities: UITableView!
    var locationManager = CLLocationManager()
    var myLocation = City(name: "My location", lon: 0.0, lat: 0.0)
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        for city in cities {
            WeatherService().loadWeatherData(city: city.name, lon: city.lon, lat: city.lat, limit: 1, extra: false, hours: false)
            { response in
                DispatchQueue.main.async {
                    if let row = cities.firstIndex(where: {$0.name == city.name}) {
                        var cityValue: City = cities[row]
                        cityValue.fact = response.fact
                        cityValue.localTIme = response.localTime
                        cityValue.condition = response.fact.condition
                        cities[row] = cityValue
                    }
                    if let row = self.savedCities.firstIndex(where: {$0.name == city.name}) {
                        var cityValue: City = self.savedCities[row]
                        cityValue.fact = response.fact
                        cityValue.localTIme = response.localTime
                        cityValue.condition = response.fact.condition
                        self.savedCities[row] = cityValue
                    }
                    self.tableViewAllCities.reloadData()
                }
            }
        }
        
        view.backgroundColor   = #colorLiteral(red: 0.05263475329, green: 0.04278912395, blue: 0.09782955796, alpha: 1)
        tableViewAllCities.backgroundColor  = .clear
        tableViewAllCities.delegate = self
        tableViewAllCities.dataSource = self
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        let search = UISearchController(searchResultsController: nil)
        search.searchBar.backgroundColor = .clear
        self.navigationItem.searchController = search
        search.searchBar.delegate = self
        savedCities = cities
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FromAllCitiesToCity",
           let destinationVC = segue.destination as? WeatherCityViewController,
           let city = sender as? City {
            destinationVC.city = city
        }
    }
}

extension WeatherAllCitiesViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, CLLocationManagerDelegate {
    /// location
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locationValue: CLLocationCoordinate2D = manager.location?.coordinate else {return}
        myLocation.lat = locationValue.latitude
        myLocation.lon = locationValue.longitude
        savedCities.insert(myLocation, at: 0)
        self.tableViewAllCities.reloadData()
    }
    
    /// table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableViewAllCities.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as? CityCellView else { return UITableViewCell() }
        
        cell.cityLabel.text = savedCities[indexPath.row].name
        if (savedCities[indexPath.row].fact == nil) ||  (savedCities[indexPath.row].localTIme) == nil{
            cell.timeLabel.text = " "
            cell.tempCityLabel.text = " "
        } else {
            cell.tempCityLabel.text = "\(String(describing: savedCities[indexPath.row].fact!.temp!))"
            cell.timeLabel.text = savedCities[indexPath.row].localTIme!
            cell.conditionImage.image = iconImageFunction(savedCities[indexPath.row].condition ?? " ")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "FromAllCitiesToCity", sender: cities[indexPath.row])
    }
    
    /// search bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        savedCities = []
        if searchText.isEmpty {
            savedCities = cities
        } else {
            for city in cities {
                if city.name.lowercased().contains(searchText.lowercased()) {
                    savedCities.append(city)
                }
            }
            
        }
        self.tableViewAllCities.reloadData()
    }
}
