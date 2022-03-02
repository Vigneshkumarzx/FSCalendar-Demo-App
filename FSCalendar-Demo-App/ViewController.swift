//
//  ViewController.swift
//  FSCalendar-Demo-App
//
//  Created by vignesh kumar c on 28/02/22.
//

import UIKit
import FSCalendar

class ViewController: UIViewController, UIGestureRecognizerDelegate, FSCalendarDelegate,FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    var bookingDates: [String] = []
    var isBooked: Bool = false
    
    @IBOutlet weak var dayshowLbl: UILabel!
    @IBOutlet weak var calendar: FSCalendar!
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM"
        return formatter
    }()
    fileprivate lazy var scopeGesture: UIPanGestureRecognizer = {
        [unowned self] in
        let panGesture = UIPanGestureRecognizer(target: self.calendar, action: #selector(self.calendar.handleScopeGesture(_:)))
        panGesture.delegate = self
        panGesture.minimumNumberOfTouches = 1
        panGesture.maximumNumberOfTouches = 2
        return panGesture
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        dayshowLbl.isHidden = true
        calendar.today = nil
        
        calendar.delegate = self
        calendar.dataSource = self
        if UIDevice.current.model.hasPrefix("iPad") {
        
        }
        self.view.addGestureRecognizer(self.scopeGesture)
//        self.calendar.select(Date())
        calendar.allowsMultipleSelection = true
        calendar.customizeCalenderAppearance()
        
    }

    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
       
        self.view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition)  {
       
        print("did select date \(self.dateFormatter.string(from: date))")
        var selectedDates = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
        print("selected dates is \(selectedDates)")
        
        bookingDates = selectedDates
        
        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }
    }

    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
            
        print("diddeselect date \(self.dateFormatter.string(from: date))")
        let selectedDates = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
        print("Deselected dates is \(selectedDates)")
        bookingDates = selectedDates
        
        let dateString = self.dateFormatter.string(from: date)

      
        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }
    }
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        true
    }
  
    
    func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        let dateString = self.dateFormatter.string(from: date)
        if isBooked,bookingDates.contains(dateString) {
            toast(Title: "Message", text: "These days are booked", font: .systemFont(ofSize: 12))
    
            return false
        }else {
            return true
        }
        
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleSelectionColorFor date: Date) -> UIColor? {
        let dateString : String = self.dateFormatter.string(from:date)
        
        if self.bookingDates.contains(dateString) {
            return .white
        } else {
            return nil
        }
    }
   
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        let dateString : String = self.dateFormatter.string(from:date)
        
        if self.bookingDates.contains(dateString) {
            return .red
        } else {
            return nil
        }
    }
    
//    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventSelectionColorsFor date: Date) -> [UIColor]? {
//        let dateString = self.dateFormatter.string(from: date)
//        if bookingDates.contains(dateString){
//            return [UIColor.red]
//        }else {
//            return nil
//        }
//    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderDefaultColorFor date: Date) -> UIColor? {
        let dateString = self.dateFormatter.string(from: date)
        if bookingDates.contains(dateString){
            return UIColor.systemGray2
        }
        return UIColor.black
    }
    
    
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("\(self.dateFormatter.string(from: calendar.currentPage))")
    }
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func toggleTapped(_ sender: Any) {
        
    }
    
    @IBAction func bookedBtnTapped(_ sender: Any) {
        
        dayshowLbl.isHidden = false
        isBooked = true
        calendar.reloadData()
        toast(Title: "Message", text: "Succesfully booked", font: .systemFont(ofSize: 16))
        let stingBookdates = bookingDates.joined(separator: "  ")
        dayshowLbl.text = stingBookdates
    }
    
    func toast(Title: String, text: String, font: UIFont) -> Void {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-250, width: 150, height: 50))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        
        toastLabel.textAlignment = .center;
        toastLabel.text = text
        toastLabel.font = font
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
       
    }
    
}

