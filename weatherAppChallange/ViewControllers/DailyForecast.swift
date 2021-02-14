//
//  DailyForecast.swift
//  weatherAppChallange
//
//  Created by Goncalo Alves on 13/02/2021.
//

import UIKit

class DailyForecast: UIView {

   
    @IBOutlet weak var hourLabel1: UILabel!
    @IBOutlet weak var hourLabel2: UILabel!
    @IBOutlet weak var hourLabel3: UILabel!
    @IBOutlet weak var hourLabel4: UILabel!
    @IBOutlet weak var hourLabel5: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var hourLabel6: UILabel!
    @IBOutlet weak var hourLabel7: UILabel!
    @IBOutlet weak var hourLabel8: UILabel!
    @IBOutlet weak var temperature1: UILabel!
    @IBOutlet weak var temperature2: UILabel!
    @IBOutlet weak var temperature3: UILabel!
    @IBOutlet weak var temperature4: UILabel!
    @IBOutlet weak var temperature5: UILabel!
    @IBOutlet weak var temperature6: UILabel!
    @IBOutlet weak var temperature7: UILabel!
    @IBOutlet weak var temperature8: UILabel!
    @IBOutlet var contentView: UIView!
    override init(frame: CGRect){
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit(){
        Bundle.main.loadNibNamed("DailyForecast", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    func populateLabels(dayInfo:dayTempInfo){
        
        dayLabel.text = "Forecast For: " + dayInfo.dia! + "/" + dayInfo.mes!
        hourLabel1.text = "00:00"
        hourLabel2.text = "03:00"
        hourLabel3.text = "06:00"
        hourLabel4.text = "09:00"
        hourLabel5.text = "12:00"
        hourLabel6.text = "15:00"
        hourLabel7.text = "18:00"
        hourLabel8.text = "21:00"
        
        temperature1.text = "-"
        temperature2.text = "-"
        temperature3.text = "-"
        temperature4.text = "-"
        temperature5.text = "-"
        temperature6.text = "-"
        temperature7.text = "-"
        temperature8.text = "-"
        
        for item in dayInfo.horaTemp! {
            let textForLabel = item.temperature! + "ºC"
            if(item.hour == "00"){
                temperature1.text = textForLabel
            }
            else if(item.hour == "03"){
                temperature2.text = textForLabel
            }
            else if(item.hour == "06"){
                temperature3.text = textForLabel
            }
            else if(item.hour == "09"){
                temperature4.text = textForLabel
            }
            
            else if(item.hour == "12"){
                temperature5.text = textForLabel
            }
            
            else if(item.hour == "15"){
                temperature6.text = textForLabel
            }
            
            else if(item.hour == "18"){
                temperature7.text = textForLabel
            }
            
            else if(item.hour == "21"){
                temperature8.text = textForLabel
            }
        }
    }

}
