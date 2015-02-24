//
//  AppointmentDac.swift
//  appointment
//
//  Created by Zhengyuan Jin on 2015-02-24.
//  Copyright (c) 2015 eWorkspace Solutions Inc. All rights reserved.
//
import Foundation

protocol ApoointmentDac {
    func getAppointments(num:Int32) -> [AnyObject]!
    func getAppointmentDetails(id:Int32) -> AnyObject!
}