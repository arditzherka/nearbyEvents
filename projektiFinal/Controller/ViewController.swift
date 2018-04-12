//
//  ViewController.swift
//  projektiFinal
//
//  Created by Ardit Zherka on 4/12/18.
//  Copyright © 2018 Ardit Zherka. All rights reserved.
//

//POD INIT
//EDITIMI I POD FAJLLIT NGA GUIDA NE WEBIN COCOAPODS
//POD INSTALL


import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
import CoreLocation

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate{

    @IBOutlet weak var lblDistanca: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var tableView: UITableView!
    var eventet:[Event] = [Event]()
    var locationManager:CLLocationManager!
    var latitude:String = "42.66133"
    var longitude:String = "21.15930"
    //Te dhenat per API
    //http://45.62.254.243:3000/events?lat=42.6613303&lng=21.1593072&distance=2000&sort=venue&accessToken=FACEBOOK_ACCESS_TOKEN

    let API_URL = "http://45.62.254.243:3000/events"
    let ACCESS_TOKEN = ""
  

    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        tableView.register(UINib.init(nibName: "EventCellController", bundle: nil), forCellReuseIdentifier: "eventCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        if location.horizontalAccuracy>0{
            latitude = String(location.coordinate.latitude)
            longitude = String(location.coordinate.longitude)
merrNgaApi(latitude: latitude, longitude: longitude, distance: String(slider.value))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        merrNgaApi(latitude: "42.66133", longitude: "21.15930", distance:"2000.0")
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell") as! EventCellController
        
        cell.eventTitle.text = eventet[indexPath.row].titulli
        cell.eventTime.text = eventet[indexPath.row].dataFillimi
        let imageUrl = URL(string: eventet[indexPath.row].profilePicture)
        cell.imgFotoja.af_setImage(withURL: imageUrl!)
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventet.count
    }
    func merrNgaApi(latitude:String,longitude:String,distance:String){
        eventet.removeAll()
        tableView.reloadData()
        //Thirr API me alamofire dhe ruaj eventet ne vargun eventet
        //http://45.62.254.243:3000/events?lat=42.6613303&lng=21.1593072&distance=2000&sort=venue&accessToken=FACEBOOK_ACCESS_TOKEN
        let parametrat:[String:String] = ["lat":latitude,"lng":longitude,"distance":distance,"accessToken":ACCESS_TOKEN]
        
        Alamofire.request(API_URL,method: .get,parameters: parametrat).responseData { (data) in
            if data.result.isSuccess{
                
                let eventDataJSON = JSON(data.result.value)
                print(eventDataJSON)
                for (_, value) in JSON(eventDataJSON["events"]){
                    let titulli = value["name"].stringValue
                    let coverPicture = value["coverPicture"].stringValue
                    let pershkrimi = value["description"].stringValue
                    let dataFillimi = value["startTime"].stringValue
                    let vend = value["place"]["name"].stringValue
                    let profilePic = value["venue"]["profilePicture"].stringValue
                    let adresa = value["place"]["location"]["street"].stringValue
                
                    let eventi = Event(titulli: titulli, coverPicture: coverPicture, pershkrimi: pershkrimi, dataFillimi: dataFillimi, vendi: vend, profilePicture: profilePic, adresa: adresa)
                    
                    self.eventet.append(eventi)
                }
                self.tableView.reloadData()
            }
            else{
                print("gabim ne marrje te te dhenave")
            }
        }
    }
  
    @IBAction func sliderValueChanged(_ sender: Any) {
        lblDistanca.text = "Distanca:\(Int(slider.value)) Metra"
    }
    
    @IBAction func touchUpInside(_ sender: Any) {
        merrNgaApi(latitude: latitude, longitude: longitude, distance: String(slider.value))
    }
    
}

