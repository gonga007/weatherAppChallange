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
            if(count == 0){
                var dayTI = dayTempInfo()
                dayTI.dia = UtilsClass.getDateElementFromString(dateString: dateText ?? "", element: "dia")
                dayTI.mes = UtilsClass.getDateElementFromString(dateString: dateText ?? "", element: "mes")
                list?.append(dayTI)
                list?[listIndex].horaTemp = []

                var ht = horaTemp()
                let temperature = day.main?.temp
                ht.hour = UtilsClass.getDateElementFromString(dateString: day.dt_txt ?? "", element: "hour")
                ht.temperature = String(temperature ?? 0)
                list?[listIndex].horaTemp?.append(ht)
                count += 1
            }
            else if(count != 0){
                let previousDay = UtilsClass.getDateElementFromString(dateString: dataModel.list![count - 1].dt_txt ?? "", element: "dia")
                var ht = horaTemp()
                let temperature = day.main?.temp
                ht.hour = UtilsClass.getDateElementFromString(dateString: day.dt_txt ?? "", element: "hour")
                ht.temperature = String(temperature ?? 0)
                if(previousDay != UtilsClass.getDateElementFromString(dateString: day.dt_txt ?? "", element: "dia")){
                    listIndex += 1
                    var dayTI = dayTempInfo()
                    dayTI.dia = UtilsClass.getDateElementFromString(dateString: dateText ?? "", element: "dia")
                    dayTI.mes = UtilsClass.getDateElementFromString(dateString: dateText ?? "", element: "mes")
                    list?.append(dayTI)
                    list?[listIndex].horaTemp = []
                
                }
                list?[listIndex].horaTemp!.append(ht)
                count += 1
            }
        }
        print("init is Over")
    }
    func generateDataForChart() -> LineChartData{
        var entries = [ChartDataEntry]()
        
        for item in list![0].horaTemp!{
            entries.append(ChartDataEntry(x: Double(item.hour!)!, y: Double(item.temperature!)!))
        }
        
        let set = LineChartDataSet(entries: entries)
        set.colors = ChartColorTemplates.material()
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
