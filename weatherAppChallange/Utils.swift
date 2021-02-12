//
//  Utils.swift
//
//  Created by Goncalo Alves on 12/02/2021.
//  Copyright © 2021 Goncalo Alves. All rights reserved.
//

import Foundation

import UIKit



class Utils{
    
    func webCall(url:String, stringpost:String, callbackerror: @escaping () -> Void, callbackok: @escaping (String) -> Void){
        let url:NSURL = NSURL(string: url)!
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData
        request.timeoutInterval = 20
        
        let data = stringpost.data(using: String.Encoding.utf8)
        
        let task = session.uploadTask(with: request as URLRequest, from: data, completionHandler:
        {(data,response,error) in
            
            guard let _:NSData = data as NSData?, let _:URLResponse = response, error == nil else {
                DispatchQueue.main.sync {
                    callbackerror()
                }
                return
            }
            let datastring = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            DispatchQueue.main.sync {
                let response = datastring as String?
                callbackok(response!)
            }
            
        });
        task.resume()
    }
 func webCall2(url:String, callbackerror: @escaping () -> Void, callbackok: @escaping (String) -> Void){
    
        let url:NSURL = NSURL(string:url)!
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "GET"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData
        request.timeoutInterval = 20
        
        let task = session.dataTask(with: request as URLRequest, completionHandler:
        {(data,response,error) in
            
            guard let _:NSData = data as NSData?, let _:URLResponse = response, error == nil else {
                DispatchQueue.main.sync {
                    callbackerror()
                }
                return
                
            }
            
            let datastring = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            
            DispatchQueue.main.sync {
                let response = datastring as String?
                callbackok(response!)
            }
            
        });
        task.resume()
    }
 
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255,
            blue: CGFloat(rgbValue & 0x0000FF) / 255,
            alpha: CGFloat(1.0)
        )
    }
    
    func calculateTime(block : (() -> Void)) {
        let start = DispatchTime.now()
        block()
        let end = DispatchTime.now()
        let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
        let timeInterval = Double(nanoTime) / 1_000_000_000
        print("Time: \(timeInterval) seconds")
    }
    func getDateFromString(timeStamp:String, language:String)->String?{
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
         let date = dateFormatter.date(from: timeStamp)
         let calendar = Calendar.current
         let components = calendar.dateComponents([Calendar.Component.day,Calendar.Component.month,Calendar.Component.year,Calendar.Component.weekday], from: date!)
         
         var diaDaSemana:String=""
         var mes:String=""
         if(language == "PT"){
            
             if(components.month==1){
                 mes="JANEIRO"
             }
             else if(components.month==2){
                 mes="FEVEREIRO"
             }
             else if(components.month==3){
                 mes="MARÇO"
             }
             else if(components.month==4){
                 mes="ABRIL"
             }
             else if(components.month==5){
                 mes="MAIO"
             }
             else if(components.month==6){
                 mes="JUNHO"
             }
             else if(components.month==7){
                 mes="JULHO"
             }
             else if(components.month==8){
                 mes="AGOSTO"
             }
             else if(components.month==9){
                 mes="SETEMBRO"
             }
             else if(components.month==10){
                 mes="OUTUBRO"
             }
             else if(components.month==11){
                 mes="NOVEMBRO"
             }
             else if(components.month==12){
                 mes="DEZEMBRO"
             }
             let aux1_1:Int = components.day ?? 0
             let aux1 = String(aux1_1)
             let aux2_2:Int = components.year ?? 0
             let aux2 = String(aux2_2)
            
             return aux1+" DE "+mes + " "+aux2
         }
         else if(language=="EN"){
             
             let date = Date()
             let dateFormatter = DateFormatter()
             dateFormatter.dateStyle = .full
             dateFormatter.timeStyle = .full
             dateFormatter.dateFormat = "MMMM d, yyyy"
             let dateString = dateFormatter.string(from: date)
             let dateStringInUpperCase = dateString.uppercased()
             return dateStringInUpperCase
         }
        return nil
    }
}

//GET STATUS
   func getStatus(){
       let defaults = UserDefaults.standard
       var stringpost = ""
       if(defaults.string(forKey: "id") != nil){
           stringpost += "id="+defaults.string(forKey: "id")!
       }
       stringpost += "&device="+GlobalClass.returnDeviceString()
       if(defaults.string(forKey: "lang") != nil){
           stringpost += "&lang="+defaults.string(forKey: "lang")!
       }
       
       self.webCall(url: Constants.server+Constants.webservices+"check_status.php", stringpost: stringpost,
                    callbackerror: {print("error status")}, callbackok: checkStatus)
   }
   func checkStatus(json: String){
       
       if let data = json.data(using: String.Encoding.utf8) {
           
           do{
               let parseJSON = try JSON(data: data)
               let response_server = parseJSON["response"].string!
               
               if(response_server == "noapp"){
                   let defaults = UserDefaults.standard
                   defaults.removeObject(forKey: "email")
                   defaults.removeObject(forKey: "id")
                   defaults.removeObject(forKey: "nome")
                   defaults.removeObject(forKey: "flag_registo")
                   defaults.removeObject(forKey: "flag_end")
                   defaults.removeObject(forKey: "beacon")
                   defaults.removeObject(forKey: "checkin")
                   variaveis_control.area = ""
                   let defaultCenter = NotificationCenter.default
                   defaultCenter.post(name: NSNotification.Name(rawValue: "reset"),
                                      object: nil)
                   
               }
               else if(response_server == "ok"){
                   let defaults = UserDefaults.standard
                   let status = parseJSON["status"]
                   defaults.setValue(status["email"].string, forKey:"email")
                   defaults.setValue(status["nome"].string, forKey:"nome")
                   
                   if(status["flag_checkin"].int == 1){
                       defaults.setValue(true, forKey: "beacon")
                       defaults.setValue(true, forKey:"checkin")
                   }
                   else{
                       defaults.setValue(false, forKey: "beacon")
                       defaults.setValue(false, forKey:"checkin")
                   }
                   defaults.synchronize()
                   let defaultCenter = NotificationCenter.default
                   defaultCenter.post(name: NSNotification.Name(rawValue: "CompleteDownloadNotification"),
                                      object: nil)
                   defaultCenter.post(name: NSNotification.Name(rawValue: "chengeMenu"),
                                      object: nil)
                   
               }
           }
           catch {
               print("Something went wrong with get status")
               print(error)
           }
           
       }
   }


let UtilsClass = Utils()

