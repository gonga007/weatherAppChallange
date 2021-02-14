//
//  ViewController.swift
//  weatherAppChallange
//
//  Created by Goncalo Alves on 12/02/2021.
//

import UIKit
import Charts

class ViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var dailyForecastView1: DailyForecast!
    @IBOutlet weak var dailyForecastView2: DailyForecast!
    @IBOutlet weak var dailyForecastView3: DailyForecast!
    @IBOutlet weak var dailyForecastView4: DailyForecast!
    @IBOutlet weak var dailyForecastView5: DailyForecast!
    @IBOutlet weak var lineChart: LineChartView!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lineChart.delegate = self
        lineChart.rightAxis.enabled = false
        lineChart.leftAxis.labelFont = .boldSystemFont(ofSize: 12)
        lineChart.leftAxis.setLabelCount(8, force: false)
        lineChart.xAxis.labelFont = .boldSystemFont(ofSize: 12)
        lineChart.xAxis.setLabelCount(8, force: false)
        lineChart.xAxis.labelPosition = .bottom
        populateUI()
        
       
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    func populateUI(){
        let dataModel = openWeatherDataModel()
        dataModel.fetch5dayWeatherForecast(completionHandler: { [self] in
            let fiveDayForecastViewModel = FiveDayForecastViewModel(dataModel: dataModel.fiveDayfor!)
            currentWeatherLabel.text = "It is now " + fiveDayForecastViewModel.list![0].horaTemp![0].temperature! + "ºC"
            lineChart.data = fiveDayForecastViewModel.generateDataForChart()
            dailyForecastView1.populateLabels(dayInfo: fiveDayForecastViewModel.list![0])
            dailyForecastView2.populateLabels(dayInfo: fiveDayForecastViewModel.list![1])
            dailyForecastView3.populateLabels(dayInfo: fiveDayForecastViewModel.list![2])
            dailyForecastView4.populateLabels(dayInfo: fiveDayForecastViewModel.list![3])
            dailyForecastView5.populateLabels(dayInfo: fiveDayForecastViewModel.list![4])
            
        })
    }
}

