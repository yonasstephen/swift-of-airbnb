//
//  AirbnbDatePickerViewController.swift
//  airbnb-datepicker
//
//  Created by Yonas Stephen on 22/2/17.
//  Copyright © 2017 Yonas Stephen. All rights reserved.
//

import UIKit

public protocol AirbnbDatePickerDelegate {
    func datePickerController(_ datePickerController: AirbnbDatePickerViewController, didSaveStartDate startDate: Date?, endDate: Date?)
}

public class AirbnbDatePickerViewController: UICollectionViewController {
    
    let monthHeaderID = "monthHeaderID"
    let cellID = "cellID"
    let dateFormatter = DateFormatter()

    var delegate: AirbnbDatePickerDelegate?
    
    var selectedStartDate: Date? {
        didSet {
            headerView.selectedStartDate = selectedStartDate
            footerView.isSaveEnabled = (selectedStartDate == nil || selectedEndDate != nil)
        }
    }
    var startDateIndexPath: IndexPath?
    var selectedEndDate: Date? {
        didSet {
            headerView.selectedEndDate = selectedEndDate
            footerView.isSaveEnabled = (selectedStartDate == nil || selectedEndDate != nil)
        }
    }
    var endDateIndexPath: IndexPath?
    var today: Date!
    var calendar: Calendar {
        return Utility.calendar
    }
    
    var isLoadingMore = false
    var initialNumberOfMonths = 24
    var subsequentMonthsLoadCount = 12
    var lastNthMonthBeforeLoadMore = 12
    
    var months: [Date]!
    var days: [(days: Int, prepend: Int, append: Int)]!
    
    var itemWidth: CGFloat {
        return floor(view.frame.size.width / 7)
    }
    var collectionViewWidthConstraint: NSLayoutConstraint?

    
    // MARK: - Initialization
    
    convenience init(dateFrom: Date?, dateTo: Date?) {
        self.init(collectionViewLayout: UICollectionViewFlowLayout())
        
        today = Date()
        initDates()
        
        // put in closure to trigger didSet
        ({ selectedStartDate = dateFrom })()
        ({ selectedEndDate = dateTo })()
        
        if selectedStartDate != nil && startDateIndexPath == nil {
            startDateIndexPath = findIndexPath(forDate: selectedStartDate!)
            if let indexPath = startDateIndexPath {
                collectionView?.selectItem(at: indexPath, animated: false, scrollPosition: .left)
            }
        }
        
        if selectedEndDate != nil && endDateIndexPath == nil {
            endDateIndexPath = findIndexPath(forDate: selectedEndDate!)
            if let indexPath = endDateIndexPath {
                collectionView?.selectItem(at: indexPath, animated: false, scrollPosition: .left)
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(AirbnbDatePickerViewController.rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)

    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    func initDates() {
        let month = calendar.component(.month, from: today)
        let year = calendar.component(.year, from: today)
        let dateComp = DateComponents(year: year, month: month, day: 1)
        var curMonth = calendar.date(from: dateComp)
        
        months = [Date]()
        days = [(days: Int, prepend: Int, append: Int)]()
        
        for _ in 0..<initialNumberOfMonths {
            months.append(curMonth!)
            
            let numOfDays = calendar.range(of: .day, in: .month, for: curMonth!)!.count
            let firstWeekDay = calendar.component(.weekday, from: curMonth!.startOfMonth())
            let lastWeekDay = calendar.component(.weekday, from: curMonth!.endOfMonth())
            
            days.append((days: numOfDays, prepend: firstWeekDay - 1, append: 7 - lastWeekDay))
            
            curMonth = calendar.date(byAdding: .month, value: 1, to: curMonth!)
            
        }
    }
    
    // MARK: - View Components
    
    lazy var dismissButton: UIBarButtonItem = {
        let btn = UIButton(type: UIButtonType.custom)
        btn.setImage(UIImage(named: "Delete", in: Bundle(for: AirbnbDatePicker.self), compatibleWith: nil), for: .normal)
        btn.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        btn.addTarget(self, action: #selector(AirbnbDatePickerViewController.handleDismiss), for: .touchUpInside)
        let barBtn = UIBarButtonItem(customView: btn)
        return barBtn
    }()
    
    lazy var clearButton: UIBarButtonItem = {
        let btn = UIButton(type: UIButtonType.custom)
        btn.setTitle("Clear", for: .normal)
        btn.frame = CGRect(x: 0, y: 0, width: 100, height: 20)
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.addTarget(self, action: #selector(AirbnbDatePickerViewController.handleClearInput), for: .touchUpInside)
        let barBtn = UIBarButtonItem(customView: btn)
        return barBtn
    }()
    
    var headerView: AirbnbDatePickerHeader = {
        let view = AirbnbDatePickerHeader()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Theme.PRIMARY_COLOR
        return view
    }()
    
    var headerSeparator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Theme.SECONDARY_COLOR
        return view
    }()
    
    lazy var footerView: AirbnbDatePickerFooter = {
        let view = AirbnbDatePickerFooter()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Theme.PRIMARY_COLOR
        view.delegate = self
        return view
    }()
    
    var footerSeparator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Theme.SECONDARY_COLOR
        return view
    }()
    
    
    // MARK: - View Setups
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if #available(iOS 11, *) {
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        self.view.backgroundColor = Theme.PRIMARY_COLOR
        
        setupNavigationBar()
        setupViews()
        setupLayout()
        
    }
    
    @objc func rotated() {
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        self.navigationItem.setLeftBarButton(dismissButton, animated: true)
        self.navigationItem.setRightBarButton(clearButton, animated: true)
    }
    
    
    func setupViews() {
        setupHeaderView()
        setupFooterView()
        setupCollectionView()
    }
    
    func setupHeaderView() {
        view.addSubview(headerView)
        
        headerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: view.topAnchor, constant: self.navigationController != nil ? self.navigationController!.navigationBar.frame.size.height : 0).isActive = true
        headerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        view.addSubview(headerSeparator)
        
        headerSeparator.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        headerSeparator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        headerSeparator.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        headerSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
    }
    
    func setupCollectionView() {
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = Theme.PRIMARY_COLOR
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.allowsMultipleSelection = true
        
        collectionView?.register(AirbnbDatePickerCell.self, forCellWithReuseIdentifier: cellID)
        collectionView?.register(AirbnbDatePickerMonthHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: monthHeaderID)
        
        collectionView?.topAnchor.constraint(equalTo: headerSeparator.bottomAnchor).isActive = true
        collectionView?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        collectionView?.bottomAnchor.constraint(equalTo: footerSeparator.topAnchor).isActive = true
        
        let gap = view.frame.size.width - (itemWidth * 7)
        collectionViewWidthConstraint = collectionView?.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -gap)
        collectionViewWidthConstraint?.isActive = true
    }
    
    func setupLayout() {
        if let layout = self.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = 5
            layout.minimumInteritemSpacing = 0
            layout.sectionInset = UIEdgeInsets()
            layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        }
    }
    
    func setupFooterView() {
        view.addSubview(footerView)
        
        footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        footerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        footerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        footerView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        view.addSubview(footerSeparator)
        
        footerSeparator.bottomAnchor.constraint(equalTo: footerView.topAnchor).isActive = true
        footerSeparator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        footerSeparator.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        footerSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    // MARK: - Collection View Delegates
    
    override public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return months.count
    }
    
    override public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days[section].prepend + days[section].days + days[section].append
    }
    
    override public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        // Load more months on reaching last (n)th month
        if indexPath.section == (months.count - lastNthMonthBeforeLoadMore) && !isLoadingMore {
            let originalCount = months.count
            isLoadingMore = true
            
            DispatchQueue.global(qos: .background).async {
                self.loadMoreMonths(completion: {
                    () in
                    DispatchQueue.main.async {
                        collectionView.performBatchUpdates({
                            () in
                            let range = originalCount..<originalCount.advanced(by: self.subsequentMonthsLoadCount)
                            let indexSet = IndexSet(integersIn: range)
                            collectionView.insertSections(indexSet)
                            
                        }, completion: {
                            (res) in
                            self.isLoadingMore = false
                        })
                    }
                })
            }
        }
    }
    
    override public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! AirbnbDatePickerCell
        
        configure(cell: cell, withIndexPath: indexPath)
        
        return cell
    }
  
    override public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: monthHeaderID, for: indexPath) as! AirbnbDatePickerMonthHeader
        
        let monthData = months[indexPath.section]
        let curYear = calendar.component(.year, from: today)
        let year = calendar.component(.year, from: monthData)
        let month = calendar.component(.month, from: monthData)
        
        if (curYear == year) {
            header.monthLabel.text = dateFormatter.monthSymbols[month - 1]
        } else {
            header.monthLabel.text = "\(dateFormatter.shortMonthSymbols[month - 1]) \(year)"
        }
        
        return header
    
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 50)
    }
    
    override public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! AirbnbDatePickerCell
        cell.type.insert(.Selected)
        
        let selectedMonth = months[indexPath.section]
        
        let year = calendar.component(.year, from: selectedMonth)
        let month = calendar.component(.month, from: selectedMonth)
        
        let dateComp = DateComponents(year: year, month: month, day: Int(cell.dateLabel.text!))
        let selectedDate = calendar.date(from: dateComp)!
        
        if selectedStartDate == nil || (selectedEndDate == nil && selectedDate < selectedStartDate!) {
            if startDateIndexPath != nil, let prevStartCell = collectionView.cellForItem(at: startDateIndexPath!) as? AirbnbDatePickerCell {
                prevStartCell.type.remove(.Selected)
                prevStartCell.configureCell()
                collectionView.deselectItem(at: startDateIndexPath!, animated: false)
            }
            
            selectedStartDate = selectedDate
            startDateIndexPath = indexPath
            
        } else if selectedEndDate == nil {
            selectedEndDate = selectedDate
            endDateIndexPath = indexPath
            
            // select start date to trigger cell UI change
            if let startCell = collectionView.cellForItem(at: startDateIndexPath!) as? AirbnbDatePickerCell {
                startCell.type.insert(.SelectedStartDate)
                startCell.configureCell()
            }
            
            // select end date to trigger cell UI change
            if let endCell = collectionView.cellForItem(at: endDateIndexPath!) as? AirbnbDatePickerCell {
                endCell.type.insert(.SelectedEndDate)
                endCell.configureCell()
            }
            
            // loop through cells in between selected dates and select them
            selectInBetweenCells()
            
        } else {
            
            // deselect previously selected cells
            deselectSelectedCells()
            
            selectedStartDate = selectedDate
            selectedEndDate = nil
            
            startDateIndexPath = indexPath
            endDateIndexPath = nil
            
            if let newStartCell = collectionView.cellForItem(at: startDateIndexPath!) as? AirbnbDatePickerCell {
                newStartCell.type.insert(.Selected)
                newStartCell.configureCell()
            }
        }
        
        cell.configureCell()
        
    }
    
    override public func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let cell = collectionView.cellForItem(at: indexPath) as! AirbnbDatePickerCell
        
        return cell.type.contains(.Date)
    }
    
    override public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! AirbnbDatePickerCell

        if isInBetween(indexPath: indexPath) {
            deselectSelectedCells()
            
            let selectedMonth = months[indexPath.section]
            
            let year = calendar.component(.year, from: selectedMonth)
            let month = calendar.component(.month, from: selectedMonth)
            
            let dateComp = DateComponents(year: year, month: month, day: Int(cell.dateLabel.text!))
            let selectedDate = calendar.date(from: dateComp)!
            
            selectedStartDate = selectedDate
            selectedEndDate = nil
            
            startDateIndexPath = indexPath
            endDateIndexPath = nil
            
            if let newStartCell = collectionView.cellForItem(at: startDateIndexPath!) as? AirbnbDatePickerCell {
                newStartCell.type.insert(.Selected)
                newStartCell.configureCell()
                collectionView.selectItem(at: startDateIndexPath!, animated: false, scrollPosition: .left)
            }
        }
    }
    
    override public func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        if selectedEndDate == nil && startDateIndexPath == indexPath {
            return false
        }
        return true
    }
    
    override public func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! AirbnbDatePickerCell
        
        cell.type.insert(.Highlighted)
        cell.configureCell()
    }
    
    override public func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        let cell = collectionView.cellForItem(at: indexPath) as! AirbnbDatePickerCell

        return cell.type.contains(.Date)
    }
    
    override public func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! AirbnbDatePickerCell
        
        cell.type.remove(.Highlighted)
        cell.configureCell()
    }
    
    func configure(cell: AirbnbDatePickerCell, withIndexPath indexPath: IndexPath) {
        let dateData = days[indexPath.section]
        let month = calendar.component(.month, from: months[indexPath.section])
        let year = calendar.component(.year, from: months[indexPath.section])
        
        if indexPath.item < dateData.prepend || indexPath.item >= (dateData.prepend + dateData.days) {
            cell.dateLabel.text = ""
            cell.type = [.Empty]
        } else {
            let todayYear = calendar.component(.year, from: today)
            let todayMonth = calendar.component(.month, from: today)
            let todayDay = calendar.component(.day, from: today)
            
            let curDay = indexPath.item - dateData.prepend + 1
            let isPastDate = year == todayYear && month == todayMonth && curDay < todayDay
            
            cell.dateLabel.text = String(curDay)
            cell.dateLabel.textColor = isPastDate ? Theme.SECONDARY_COLOR : UIColor.white
            cell.type = isPastDate ? [.PastDate] : [.Date]
            
            if todayDay == curDay, todayMonth == month, todayYear == year  {
                cell.type.insert(.Today)
            }
        }
        
        if startDateIndexPath != nil && indexPath == startDateIndexPath {
            if endDateIndexPath == nil {
                cell.type.insert(.Selected)
            } else {
                cell.type.insert(.SelectedStartDate)
            }
        }
        
        if endDateIndexPath != nil {
            if indexPath == endDateIndexPath {
                cell.type.insert(.SelectedEndDate)
            } else if isInBetween(indexPath: indexPath) {
                cell.type.insert(.InBetweenDate)
            }
        }
        
        cell.configureCell()
    }
    
    
    func isInBetween(indexPath: IndexPath) -> Bool {
        if let start = startDateIndexPath, let end = endDateIndexPath {
            return (indexPath.section > start.section || (indexPath.section == start.section && indexPath.item > start.item))
                && (indexPath.section < end.section || (indexPath.section == end.section && indexPath.item < end.item))
        }
        return false
    }
    
    func selectInBetweenCells() {
        var section = startDateIndexPath!.section
        var item = startDateIndexPath!.item
        
        var indexPathArr = [IndexPath]()
        while section < months.count, section <= endDateIndexPath!.section {
            let curIndexPath = IndexPath(item: item, section: section)
            if let cell = collectionView?.cellForItem(at: curIndexPath) as? AirbnbDatePickerCell {
                if curIndexPath != startDateIndexPath && curIndexPath != endDateIndexPath {
                    cell.type.insert(.InBetweenDate)
                    cell.configureCell()
                }
                indexPathArr.append(curIndexPath)
            }
            
            if section == endDateIndexPath!.section && item >= endDateIndexPath!.item {
                // stop iterating beyond end date
                break
            } else if item >= (collectionView!.numberOfItems(inSection: section) - 1) {
                // more than num of days in the month
                section += 1
                item = 0
            } else {
                item += 1
            }
        }
        
        collectionView?.performBatchUpdates({
            self.collectionView?.reloadItems(at: indexPathArr)
        }, completion: nil)
    }
    
    func deselectSelectedCells() {
        if let start = startDateIndexPath {
            var section = start.section
            var item = start.item + 1
            
            if let cell = collectionView?.cellForItem(at: start) as? AirbnbDatePickerCell {
                cell.type.remove([.InBetweenDate, .SelectedStartDate, .SelectedEndDate, .Selected])
                cell.configureCell()
                collectionView?.deselectItem(at: start, animated: false)
            }
            
            if let end = endDateIndexPath {
                let indexPathArr = [IndexPath]()
                while section < months.count, section <= end.section {
                    let curIndexPath = IndexPath(item: item, section: section)
                    if let cell = collectionView?.cellForItem(at: curIndexPath) as? AirbnbDatePickerCell {
                        cell.type.remove([.InBetweenDate, .SelectedStartDate, .SelectedEndDate, .Selected])
                        cell.configureCell()
                        collectionView?.deselectItem(at: curIndexPath, animated: false)
                    }
                    
                    if section == end.section && item >= end.item {
                        // stop iterating beyond end date
                        break
                    } else if item >= (collectionView!.numberOfItems(inSection: section) - 1) {
                        // more than num of days in the month
                        section += 1
                        item = 0
                    } else {
                        item += 1
                    }
                }
                
                collectionView?.performBatchUpdates({
                    self.collectionView?.reloadItems(at: indexPathArr)
                }, completion: nil)
            }
        }
    }
    
    // MARK: - Event Handlers
    
    @objc func handleDismiss() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleClearInput() {
        deselectSelectedCells()
        selectedStartDate = nil
        selectedEndDate = nil
        
        startDateIndexPath = nil
        endDateIndexPath = nil
    }
    
    func loadMoreMonths(completion: (() -> Void)?) {
        let lastDate = months.last!
        let month = calendar.component(.month, from: lastDate)
        let year = calendar.component(.year, from: lastDate)
        let dateComp = DateComponents(year: year, month: month + 1, day: 1)
        var curMonth = calendar.date(from: dateComp)
        
        for _ in 0..<subsequentMonthsLoadCount {
            months.append(curMonth!)
            
            let numOfDays = calendar.range(of: .day, in: .month, for: curMonth!)!.count
            let firstWeekDay = calendar.component(.weekday, from: curMonth!.startOfMonth())
            let lastWeekDay = calendar.component(.weekday, from: curMonth!.endOfMonth())
            
            days.append((days: numOfDays, prepend: firstWeekDay - 1, append: 7 - lastWeekDay))
            curMonth = calendar.date(byAdding: .month, value: 1, to: curMonth!)
            
        }
        
        if let handler = completion {
            handler()
        }
    }
    
    // MARK: - Functions
    
    func findIndexPath(forDate date: Date) -> IndexPath? {
        var indexPath: IndexPath? = nil
        if let section = months.index(where: {
            calendar.component(.year, from: $0) == calendar.component(.year, from: date) && calendar.component(.month, from: $0) == calendar.component(.month, from: date)}) {
            let item = days[section].prepend + calendar.component(.day, from: date) - 1
            indexPath = IndexPath(item: item, section: section)
        }
        return indexPath
    }
}

// MARK: - AirbnbDatePickerFooterDelegate

extension AirbnbDatePickerViewController: AirbnbDatePickerFooterDelegate {
    func didSave() {
        if let del = delegate {
            del.datePickerController(self, didSaveStartDate: selectedStartDate, endDate: selectedEndDate)
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
    }
}

