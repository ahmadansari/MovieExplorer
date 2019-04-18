//
//  DatePickerView.swift
//  MovieExplorer
//
//  Created by Ahmad Ansari on 18/04/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import Foundation
import UIKit

protocol DatePickerViewDelegate: class {
    func datePickerDidCancel(_ sender: DatePickerView)
    func datePicker(_ sender: DatePickerView, didSelect date: Date)
}

class DatePickerView: UIView {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    weak var delegate: DatePickerViewDelegate?
    
    @IBAction func onTapDoneButton(_ sender: Any) {        
        delegate?.datePicker(self, didSelect: datePicker.date)
    }
    
    @IBAction func onTapCancelButton(_ sender: Any) {
        delegate?.datePickerDidCancel(self)
    }
}
