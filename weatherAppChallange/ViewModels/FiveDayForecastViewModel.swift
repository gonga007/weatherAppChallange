//
//  FiveDayForecastViewModel.swift
//  weatherAppChallange
//
//  Created by Goncalo Alves on 13/02/2021.
//

import Foundation
import Charts
class FiveDayForecastViewModel {
    
    var list: [dayTempInfo]?
    init(dataModel: fiveDayForecast) {
        list = []
        var count = 0
        var listIndex = 0
        for day in dataModel.list! {
            let dateText = day.dt_txt
            let temperature = day.main?.temp
            let temperatureRounded = Double(round(10*temperature! )/10)
            var ht = horaTemp()
            ht.hour = UtilsClass.getDateElementFromString(dateString: day.dt_txt ?? "", element: "hour")
            ht.temperature = String(temperatureRounded)
            var dayTI = dayTempInfo()
            dayTI.dia = UtilsClass.getDateElementFromString(dateString: dateText ?? "", element: "dia")
            dayTI.mes = UtilsClass.getDateElementFromString(dateString: dateText ?? "", element: "mes")
            if(count == 0){
                list?.append(dayTI)
                list?[listIndex].horaTemp = []
                list?[listIndex].horaTemp?.append(ht)
            }
            else if(count != 0){
                let previousDay = UtilsClass.getDateElementFromString(dateString: dataModel.list![count - 1].dt_txt ?? "", element: "dia")
                if(previousDay != UtilsClass.getDateElementFromString(dateString: day.dt_txt ?? "", element: "dia")){
                    listIndex += 1
                    list?.append(dayTI)
                    list?[listIndex].horaTemp = []
                }
                list?[listIndex].horaTemp!.append(ht)
            }
            count += 1
        }
    }
    func generateDataForChart() -> LineChartData{
        var entries = [ChartDataEntry]()
        for item in list![0].horaTemp!{
            entries.append(ChartDataEntry(x: Double(item.hour!)!, y: Double(item.temperature!)!))
        }
        
        let set = LineChartDataSet(entries: entries, label: "Hours / Temprature ºC")
        set.drawCirclesEnabled = false
        set.mode = .cubicBezier
        let data = LineChartData(dataSet: set)
        return data
    }
}
struct dayTempInfo {
    var horaTemp: [horaTemp]?
    var dia: String?
    var mes: String?
}
struct horaTemp {
    var hour: String?
    var temperature: String?
}
