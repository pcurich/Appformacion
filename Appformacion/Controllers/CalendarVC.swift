//
//  CalendarVC.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 7/05/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalendarVC: BaseVC {
    
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var month: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnNow: UIBarButtonItem!
    @IBOutlet weak var separatorViewTopConstraint: NSLayoutConstraint!
    
    
    let outsideMonthColor = UIColor(colorWithHexValue: 0x584a66)
    let monthColor = UIColor.white
    let selectedMonthColor = UIColor.BBVAMEDIUMBLUE()
    let currentDateSelectedViewColor = UIColor.BBVADARKMEDIUMBLUE()
    
    //MARK: DataSource
    var scheduleGroup: [String:[FechaValue]]?{
        didSet {
            calendarView.reloadData()
            tableView.reloadData()
        }
    }
    
    var schedules: [FechaValue]{
        get {
            guard let selectedDate = calendarView.selectedDates.first else { return [] }
            guard let data = scheduleGroup?[formatter.string(from: selectedDate)] else { return [] }
            return data.sorted(by:{ $0.fecha < $1.fecha })
        }
    }
    
    // MARK: Helpers
    let calendarCellIdentifier = "calendarCell"
    let scheduleCellIdentifier = "detailCell"
    
    var now = Date()
    let numOfRowsInCalendar = 6
    var registro : String = ""
    var numOfRowIsSix: Bool {get {return calendarView.visibleDates().outdates.count < 7}}
    
    let formatter : DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = Calendar.current.timeZone
        dateFormatter.locale = Locale(identifier: "es_PE")
        dateFormatter.dateFormat = "yyyyMMdd"
        return dateFormatter
    }()
    
    var currentMonthSymbol: String {
        get {
            let startDate = (calendarView.visibleDates().monthDates.first?.date)!
            let month = Calendar.current.dateComponents([.month], from: startDate).month!
            let monthString = formatter.monthSymbols[month-1].uppercased()
            return monthString
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registro = getRegistro()
        setupViewNibs()
        btnNow.target = self
        btnNow.action = #selector(showTodayWithAnimate)
        showToday(animate: false)
        
        tableView.dataSource = self
        
        let gesturer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gesture:)))
        calendarView.addGestureRecognizer(gesturer)
    }
    
    @objc func handleLongPress(gesture: UILongPressGestureRecognizer){
        let point = gesture.location(in: calendarView)
        guard let cellStatus = calendarView.cellStatus(at: point) else {return}
        
        if calendarView.selectedDates.first != cellStatus.date {
            calendarView.deselectAllDates()
            calendarView.selectDates([cellStatus.date])
        }
    }
    
    func setupViewNibs() {
        let myNib = UINib(nibName: "DetailCalendarTVC", bundle: Bundle.main)
        tableView.register(myNib, forCellReuseIdentifier: scheduleCellIdentifier)
    }
    
    func setupViewsOfCalendar(from visibleDates : DateSegmentInfo) {
        guard let startDate = visibleDates.monthDates.first?.date else { return }
        
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        
        self.year.text = String(Calendar.current.component(.year, from: startDate))
        self.month.text = self.currentMonthSymbol
    }
    
}

//MARK Helpers
extension CalendarVC {
    func select(onVisibleDates visibleDates: DateSegmentInfo ){
        guard let firstDateInMonth = visibleDates.monthDates.first?.date else { return }
        
        if firstDateInMonth.isThisMonth(){
            calendarView.selectDates([Date()])
        }else {
            calendarView.selectDates([firstDateInMonth])
        }
    }
}

// MARK: Button events
extension CalendarVC {
    @objc func showTodayWithAnimate() {
        showToday(animate: true)
    }
    
    func showToday(animate:Bool) {
        calendarView.scrollToDate(Date(), triggerScrollToDateDelegate: true, animateScroll: animate, preferredScrollPosition: nil, extraAddedOffset: 0) { [unowned self] in
            self.getSchedule()
            self.calendarView.visibleDates{[unowned self]  (visibleDates: DateSegmentInfo) in
                self.setupViewsOfCalendar(from: visibleDates)
            }
            self.calendarView.selectDates([Date()])
        }
    }
}



// MARK: Prepere dataSource
extension CalendarVC {
    func getSchedule() {
        CalendarService.getEventCalendarOnBackground(year: "\(self.now.getCurrentYear())", month: String(format: "%02d", self.now.getCurrentMonth()), register: self.registro, completionHandler:  { (response) in
            self.scheduleGroup = response
        })
    }
}

// MARK: CalendarCell's ui  config
extension CalendarVC {
    func configureCell(view: JTAppleCell?, cellState: CellState) {
        guard let myCustomCell = view as? CalendarCellJTA else { return }
        
        myCustomCell.dateLabel.text = cellState.text
        let cellHidden = cellState.dateBelongsTo != .thisMonth
        
        myCustomCell.isHidden = cellHidden
        myCustomCell.selectedView.backgroundColor = UIColor.black
        
        if Calendar.current.isDateInToday(cellState.date) {
            myCustomCell.selectedView.backgroundColor = UIColor.red
        }
        
        handleCellTextColor(view: myCustomCell, cellState: cellState)
        handleCellSelection(view: myCustomCell, cellState: cellState)
        
        if scheduleGroup?[formatter.string(from: cellState.date)] != nil {
            myCustomCell.eventDotView.isHidden = false
        }
        else {
            myCustomCell.eventDotView.isHidden = true
        }
    }
    
    func handleCellSelection(view: CalendarCellJTA, cellState: CellState){
        view.selectedView.isHidden = !cellState.isSelected
    }
    
    func handleCellTextColor(view: CalendarCellJTA?, cellState: CellState){
        
        if (cellState.isSelected){
            view?.dateLabel.textColor = UIColor.white
        }
        else {
            view?.dateLabel.textColor = UIColor.black
            if cellState.day == .sunday || cellState.day == .saturday {
                view?.dateLabel.textColor = UIColor.gray
            }
        }
        
        if Calendar.current.isDateInToday(cellState.date) {
            if cellState.isSelected {
                view?.dateLabel.textColor = UIColor.white
            }else {
                view?.dateLabel.textColor = UIColor.red
            }
        }
    }
}

// MARK: JTAppleCalendarViewDataSource
extension CalendarVC : JTAppleCalendarViewDataSource {
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        
        let year  = Calendar.current.component(.year, from: Date())
        let month  = Calendar.current.component(.month, from: Date())
        
        let startDate = now.from(year: year, month: month, day: 1)
        let endDate = Calendar.current.date(byAdding: .year, value: 1, to: Date())
        
        let parameters = ConfigurationParameters(startDate: startDate,
                                                 endDate: endDate!,
                                                 numberOfRows: numOfRowsInCalendar,
                                                 calendar: Calendar.current,
                                                 generateInDates: .forAllMonths,
                                                 generateOutDates: .tillEndOfGrid,
                                                 firstDayOfWeek: .sunday,
                                                 hasStrictBoundaries: true)
        return parameters
    }
}

//MARK JTAppleCalendarViewDelegate

extension CalendarVC : JTAppleCalendarViewDelegate {
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: calendarCellIdentifier, for: indexPath) as! CalendarCellJTA
        configureCell(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: calendarCellIdentifier, for: indexPath) as! CalendarCellJTA
        configureCell(view: cell, cellState: cellState)
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        setupViewsOfCalendar(from: visibleDates)
        
        if visibleDates.monthDates.first?.date == now {
            return
        }
        
        self.now = (visibleDates.monthDates.first?.date)!
        
        getSchedule()
        select(onVisibleDates: visibleDates)
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.5) {
            [unowned self] in
            self.view.layoutIfNeeded()
        }
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        self.configureCell(view: cell, cellState: cellState)
        cell?.bounce()
        tableView.reloadData()
        tableView.contentOffset = CGPoint()
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        self.configureCell(view: cell, cellState: cellState)
    }
    
    
}

extension UIView {
    func bounce(){
        self.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(
            withDuration: 0.5,
            delay: 0, usingSpringWithDamping:0.3,
            initialSpringVelocity: 0.1,
            options: UIViewAnimationOptions.beginFromCurrentState,
            animations: {
                self.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
    }
}


// MARK: UITableViewDataSource
extension CalendarVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: scheduleCellIdentifier, for: indexPath) as! DetailCalendarTVC
        cell.selectionStyle = .none
        cell.fechaValue = schedules[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schedules.count
    }
}




