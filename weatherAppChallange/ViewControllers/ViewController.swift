//
//  ViewController.swift
//  weatherAppChallange
//
//  Created by Goncalo Alves on 12/02/2021.
//

import UIKit
import Charts

class ViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var lineChart: LineChartView!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lineChart.delegate = self
        lineChart.rightAxis.enabled = false
        lineChart.leftAxis.labelFont = .boldSystemFont(ofSize: 12)
        lineChart.leftAxis.setLabelCount(8, force: false)
        
        lineChart.xAxis.labelFont = .boldSystemFont(ofSize: 12)
        lineChart.xAxis.setLabelCount(8, force: false)
        lineChart.xAxis.labelPosition = .bottom
        var o = openWeatherDataModel()
        o.fetch5dayWeatherForecast(completionHandler: { [self] in
            var fiveDayForecastViewModel = FiveDayForecastViewModel(dataModel: o.fiveDayfor!)
            currentWeatherLabel.text = "It is now " + fiveDayForecastViewModel.list![0].horaTemp![0].temperature! + "ºC"
//            lineChart.data = fiveDayForecastViewModel.generateDataForChart()
            generateDataForChart(ViewModel: fiveDayForecastViewModel)
        })
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func generateDataForChart(ViewModel : FiveDayForecastViewModel){
        var entries = [ChartDataEntry]()
//        let dates = ["11/01", "11/02", "11/03", "11/04"]
//        lineChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: dates)
        for item in ViewModel.list![0].horaTemp!{
            entries.append(ChartDataEntry(x: Double(item.hour!)!, y: Double(item.temperature!)!))
        }
        
        let set = LineChartDataSet(entries: entries, label: "Hours / Temprature ºC")
        set.drawCirclesEnabled = false
        set.mode = .cubicBezier
        let data = LineChartData(dataSet: set)
        lineChart.data = data
    }
    


}

