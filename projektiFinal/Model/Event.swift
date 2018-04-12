//
//  Event.swift
//  projektiFinal
//
//  Created by Ardit Zherka on 4/12/18.
//  Copyright © 2018 Ardit Zherka. All rights reserved.
//
//Aplikacioni Nearby Events

//1.Behet definimi i variablave te cilat marrin vlerat nga fajlli JSON nga API

//2.
import Foundation

class Event{
    
    
    let titulli:String
    let coverPicture:String
    let pershkrimi:String
    let dataFillimi:String
    let vendi:String
    let profilePicture:String
    let adresa:String
    init (titulli:String,coverPicture:String,pershkrimi:String,
          dataFillimi:String,vendi:String,profilePicture:String,adresa:String){
        self.titulli = titulli
        self.coverPicture = coverPicture
        self.pershkrimi = pershkrimi
        self.dataFillimi = dataFillimi
        self.vendi = vendi
        self.profilePicture = profilePicture
        self.adresa = adresa
        
    }
    
    
    
    
}
