//
//  openWeatherDataModel.swift
//  weatherAppChallange
//
//  Created by Goncalo Alves on 12/02/2021.
//

import Foundation

class openWeatherDataModel{
    
    let apiKey = "21bb0974abf4a1418a9fd3e97ff3167f"
    var latitude = "41.15"
    var longitude = "-8.61024"
    var fiveDayfor: fiveDayForecast?
    var openWeath: openWeather?
    init() {
        
    }
    
    func fetchOpenWeatherData(){
        
        let url = "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&exclude=current,minutely,daily&appid=\(apiKey)&units=metric"
        UtilsClass.webCall2(url: url, callbackerror: {print("Error...")}, callbackok: onSucess)
    }
    func fetch5dayWeatherForecast(completionHandler : @escaping () -> Void){
        let url = "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
        UtilsClass.webCall2(url: url, callbackerror: {print("Error...")}, callbackok: { response in
            let data = Data(response.utf8)
            let json : fiveDayForecast = try! JSONDecoder().decode(fiveDayForecast.self, from: data)
            print("JSON RESPONSE 5DayForeCast\n")
            print(response)
            self.fiveDayfor = json
            completionHandler()
        })

    }
    func onSucess(response : String){
        let data = Data(response.utf8)
        let json : openWeather = try! JSONDecoder().decode(openWeather.self, from: data)
        self.openWeath = json
    }
    func onSucess5Day(response: String){
        let data = Data(response.utf8)
        let json : fiveDayForecast = try! JSONDecoder().decode(fiveDayForecast.self, from: data)
        print("JSON RESPONSE 5DayForeCast\n")
        print(response)
        self.fiveDayfor = json
    }
}


struct openWeather: Codable {
    var lat: Double?
    var lon: Double?
    var timezone : String?
    var hourly : [hourly]?
    var daily : [daily]?
}
struct hourly: Codable {
    var dt: Int?
    var temp: Double?
    var feels_like: Double?
    var pressure: Int?
    var humidity: Int?
    var dew_point: Double?
    var uvi: Double?
    var clouds: Int?
    var visibility: Int?
    var windSpeed: Double?
    var wind_deg: Int?
    var weather: [weather]?
}
struct weather: Codable {
    var id: Int?
    var main: String?
    var description: String?
    var icon:String?
}
struct daily:Codable {
    var dt: Int?
    var sunrise: Int?
    var sunset: Int?
    var temp: temp?
    var weather: [weather]?
}
struct temp: Codable {
    var day: Double?
    var min: Double?
    var max: Double?
    var night: Double?
    var eve: Double?
    var morn: Double?
}

struct fiveDayForecast:Codable{
    var cod: String?
    var list : [fiveDayList]?
}
struct fiveDayList: Codable {
    var dt: Int?
    var main: mainFiveDay?
    var dt_txt: String?
}
struct mainFiveDay: Codable{
    var temp: Double?
    var feels_like: Double?
    var temp_min: Double?
    var temp_max: Double?
}
